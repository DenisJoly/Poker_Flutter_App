import 'package:flutter/material.dart';
import 'package:my_app/screens/hand_matrix_screen.dart';

class SetHandRangesScreen extends StatefulWidget {
  @override
  _SetHandRangesScreenState createState() => _SetHandRangesScreenState();
}

class _SetHandRangesScreenState extends State<SetHandRangesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Hand Ranges'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          buildHandRangeExpansionTile('Raising First In', ['UTG', 'MP', 'CO', 'BTN', 'SB']),
          buildHandRangeExpansionTile('3-Betting', ['Versus UTG RFI', 'Versus MP RFI', 'Versus CO RFI', 'Versus BTN RFI', 'Versus SB RFI', '3-Bet Bluffing Range']),
          buildHandRangeExpansionTile('Cold Calling', ['Versus UTG RFI', 'Versus MP RFI', 'Versus CO RFI']),
          buildHandRangeExpansionTile('Blind Defense', ['SB Blind Defense', 'BB Blind Defense']),
          buildHandRangeExpansionTile('Isolation Raising, Over-Limping & Over-Calling', ['Iso-Raising Range', 'Over-Limping Range', 'Over-Calling Range']),
        ],
      ),
    );
  }

  Widget buildHandRangeExpansionTile(String title, List<String> options) {
    return ExpansionTile(
      title: Text(title),
      children: options.map((option) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HandMatrixScreen(category: title, position: option)),
            );
          },
          child: Text(option),
        ),
      )).toList(),
    );
  }
}
