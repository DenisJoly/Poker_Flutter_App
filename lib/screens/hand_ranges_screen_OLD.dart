import 'package:flutter/material.dart';

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
          buildHandRangeExpansionTileRFI('Raising First In'),
          buildHandRangeExpansionTile3BET('3-Betting'),
          buildHandRangeExpansionTileCC('Cold Calling'),
          buildHandRangeExpansionTileBD('Blind Defense'),
          buildHandRangeExpansionTileRest('Isolation Raising, Over-Limping & Over-Calling'),
        ],
      ),
    );
  }

  Widget buildHandRangeExpansionTileRFI(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'UTG'
              },
              child: Text('UTG'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('MP'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'CO'
              },
              child: Text('CO'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'BTN'
              },
              child: Text('BTN'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'SB'
              },
              child: Text('SB'),
            ),
          ],
        ),
      ],
    );
  }



  Widget buildHandRangeExpansionTile3BET(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'UTG'
              },
              child: Text('Versus UTG RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('Versus MP RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'CO'
              },
              child: Text('Versus CO RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'BTN'
              },
              child: Text('Versus BTN RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'SB'
              },
              child: Text('Versus SB RFI'),
            ),
             ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'SB'
              },
              child: Text('3-Bet Bluffing Range'),
            ),
          ],
        ),
      ],
    );
  }

    Widget buildHandRangeExpansionTileCC(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'UTG'
              },
              child: Text('Versus UTG RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('Versus MP RFI'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'CO'
              },
              child: Text('Versus CO RFI'),
            ),        
          ],
        ),
      ],
    );
  }

      Widget buildHandRangeExpansionTileBD(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'UTG'
              },
              child: Text('SB Blind Defense'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('BB Blind Defense'),
            ),
           
          ],
        ),
      ],
    );
  }


      Widget buildHandRangeExpansionTileRest(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'UTG'
              },
              child: Text('Iso-Raising Range'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('Over-Limping Range'),
            ),
              ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality for 'MP'
              },
              child: Text('Over-Calling Range'),
            ),
          ],
        ),
      ],
    );
  }

}