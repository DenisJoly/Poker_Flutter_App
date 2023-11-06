import 'package:flutter/material.dart';
import 'game_screen.dart'; // Make sure to create this file and screen.


class NewGameScreen extends StatefulWidget {
  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  int numberOfPlayers = 6; // default value
  String heroPosition = '';
  double heroStack = 100.0; // Example default value
  double bigBlindValue = 1.0; // Example default value

void startGame() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GameScreen(
        numberOfPlayers: numberOfPlayers,
        heroPosition: heroPosition,
        heroStack: heroStack,
        bigBlindValue: bigBlindValue,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    List<String> positions = ['BTN', 'SB', 'BB', 'UTG', 'MP', 'CO'];
    if (numberOfPlayers == 5) {
      positions.remove('MP'); // Remove 'MP' if number of players is 5
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Game Settings'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to avoid overflow when the keyboard is displayed
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: '$numberOfPlayers',
              decoration: InputDecoration(labelText: 'Number of Players'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfPlayers = int.tryParse(value) ?? 6;
                  if (numberOfPlayers < 5) {
                    numberOfPlayers = 5; // Minimum number of players is 5
                  }
                  if (numberOfPlayers > 6) {
                    numberOfPlayers = 6; // Maximum number of players is 6
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0, // Spacing between the buttons
              children: positions.map((position) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    heroPosition = position;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: heroPosition == position ? Colors.blue : Colors.grey[300],
                  onPrimary: heroPosition == position ? Colors.white : Colors.black,
                ),
                child: Text(position),
              )).toList(),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: '$heroStack',
              decoration: InputDecoration(labelText: 'Hero Stack'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  heroStack = double.tryParse(value) ?? 100.0;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: '$bigBlindValue',
              decoration: InputDecoration(labelText: 'Big Blind Value'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  bigBlindValue = double.tryParse(value) ?? 1.0;
                });
              },
            ),
                ElevatedButton(
      onPressed: startGame,
      child: Text('Start Game Now!'),
    ),// .Add any other settings here ...
          ],
        ),
      ),
    );
  }
}
