import 'package:flutter/material.dart';
import 'package:my_app/models/player_model.dart';

enum HandStage { Preflop, Flop, Turn, River, Showdown }

const List<String> suits = ['♠', '♥', '♦', '♣'];
const List<String> ranks = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];



// Helper widget for card selection
class CardTile extends StatelessWidget {
  final String? rank;
  final String? suit;
  final bool isSelected;
  final VoidCallback onTap;

  const CardTile({
    Key? key,
    this.rank,
    this.suit,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        ),
        child: Center(child: Text(rank ?? suit ?? '')),
      ),
    );
  }
}



class GameScreen extends StatefulWidget {
  final int numberOfPlayers;
  final String heroPosition;
  final double heroStack;
  final double bigBlindValue;


  const GameScreen({
    Key? key,
    required this.numberOfPlayers,
    required this.heroPosition,
    required this.heroStack,
    required this.bigBlindValue,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Player> players = [];
  HandStage currentStage = HandStage.Preflop;

  String? selectedRankCard1;
  String? selectedSuitCard1;
  String? selectedRankCard2;
  String? selectedSuitCard2;  
  
@override
void initState() {
  super.initState();
  for (int i = 0; i < widget.numberOfPlayers; i++) {
    players.add(Player(name: 'Player ${i+1}'));
  }
  // Delay the dialog until after the build method has been completed
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _askHeroCards();  // Ask for hero's cards after the build method is done
  });
}


  void recordAction(int playerIndex, String action, double amount) {
    setState(() {
      players[playerIndex].actionsHistory.add(PlayerAction(action: action, amount: amount));
    });
  }

void _askHeroCards() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // Use StatefulBuilder to manage the local state within the dialog
      return StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          title: const Text('Select Your Cards'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Card 1'),
                Wrap(
                  children: ranks.map((rank) => CardTile(
                    rank: rank,
                    isSelected: selectedRankCard1 == rank,
                    onTap: () {
                      setDialogState(() {
                        selectedRankCard1 = rank;
                      });
                    },
                  )).toList(),
                ),
                Wrap(
                  children: suits.map((suit) => CardTile(
                    suit: suit,
                    isSelected: selectedSuitCard1 == suit,
                    onTap: () {
                      setDialogState(() {
                        selectedSuitCard1 = suit;
                      });
                    },
                  )).toList(),
                ),
                SizedBox(height: 20),
                Text('Card 2'),
                Wrap(
                  children: ranks.map((rank) => CardTile(
                    rank: rank,
                    isSelected: selectedRankCard2 == rank,
                    onTap: () {
                      setDialogState(() {
                        selectedRankCard2 = rank;
                      });
                    },
                  )).toList(),
                ),
                Wrap(
                  children: suits.map((suit) => CardTile(
                    suit: suit,
                    isSelected: selectedSuitCard2 == suit,
                    onTap: () {
                      setDialogState(() {
                        selectedSuitCard2 = suit;
                      });
                    },
                  )).toList(),
                ),              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (selectedRankCard1 != null && selectedSuitCard1 != null &&
                    selectedRankCard2 != null && selectedSuitCard2 != null) {
                  // If all selections are made, close the dialog and potentially do something with the data
                  Navigator.of(context).pop();
                } else {
                  // Prompt the user to make selections for both cards
                }
              },
              child: const Text('Done'),
            ),
          ],
        );
      });
    },
  );
}


void _askPlayerActions() {
  // You can loop over the players list and ask for each player's action
  // For simplicity, here's how you might ask for a single player's action

  showDialog(
    context: context,
    builder: (context) {
      String action = '';
      double amount = 0.0;

      return AlertDialog(
        title: Text('Player Action'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton<String>(
              value: action,
              items: ['Fold', 'Call', 'Raise'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  action = newValue!;
                });
              },
            ),
            if (action == 'Raise')
              TextField(
                onChanged: (value) => amount = double.tryParse(value) ?? 0.0,
                decoration: InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Validate and save the action
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game - ${currentStage.toString().split('.').last}'),
      ),
      body: Column(
        children: [
          // Here you could place a button to manually trigger the _askPlayerActions dialog
          ElevatedButton(
            onPressed: _askPlayerActions,  // This will show the dialog when the button is pressed
            child: Text('Record Player Actions'),
          ),
          // Add other UI elements to represent the game state
        ],
      ),
      // You could also have a button here to move to the next stage of the game
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Here you can check the currentStage and move to the next stage
          // and call _askPlayerActions for the next round of actions
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}


