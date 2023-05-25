import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> players = [];
  TextEditingController playerNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    playerNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mind Mingles'),
        centerTitle: true,
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField(context),
            const SizedBox(
              height: 20,
            ),
            letsPlayButton(context),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Players',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            playersList(context),
          ],
        ),
      ),
    );
  }

  SizedBox playersList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.37,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: players.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Card(
              color: Colors.orange,
              child: ListTile(
                title: Text(players[index]),
                trailing: IconButton(
                  onPressed: () {
                    removePlayer(players[index]);
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row textField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextField(
            controller: playerNameController,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'Enter Player Name',
                contentPadding: EdgeInsets.all(8)),
          ),
        ),
        IconButton(
          onPressed: () {
            if (playerNameController.text.isNotEmpty) {
              addPlayer(playerNameController.text);
              playerNameController.clear();
              FocusScope.of(context).unfocus();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Validation Failed'),
                    content: const Text('Please enter player name.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          icon: const Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  SizedBox letsPlayButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.36,
      height: MediaQuery.of(context).size.height * 0.045,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          startGame();
        },
        child: const Text(
          'Let\'s Play',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Functions

  void startGame() {
    if (players.length < 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Failed'),
            content:
                const Text('Minimum 2 players are required to start the game.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // show dialog that game is started
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Started'),
            content: const Text('Game has started successfully'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // add player
  void addPlayer(String playerName) {
    setState(() {
      players.add(playerName);
    });
  }

  //remove player
  void removePlayer(String playerName) {
    setState(() {
      players.remove(playerName);
    });
  }
}
