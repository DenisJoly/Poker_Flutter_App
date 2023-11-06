import 'package:flutter/material.dart';
import 'package:my_app/screens/hand_ranges_screen.dart';
import 'package:my_app/screens/new_game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microstakes Poker Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Microstakes Poker Helper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewGameScreen()),
              );
            },
            child: Text('Start a New Game'),
          ),

            SizedBox(height: 20), // This adds space between the two buttons.
           ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetHandRangesScreen()),
    );
  },
  child: Text('Set Hand Ranges'),
),

          ],
        ),
      ),
    );
  }
}
