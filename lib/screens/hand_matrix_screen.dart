import 'package:flutter/material.dart';
import 'package:my_app/models/hand_model.dart';


class HandMatrixScreen extends StatefulWidget {
  final String category;
  final String position;

  const HandMatrixScreen({Key? key, required this.category, required this.position}) : super(key: key);

  @override
  _HandMatrixScreenState createState() => _HandMatrixScreenState();
}

class _HandMatrixScreenState extends State<HandMatrixScreen> {
  Set<String> selectedHands = {};
  HandSelection handSelection = HandSelection();

  @override
  void initState() {
    super.initState();
    _loadSelectedHands();
  }

  void _loadSelectedHands() async {
  Set<String> hands = await handSelection.getSelectedHands(widget.category, widget.position);
    if (mounted) {
      setState(() {
        selectedHands = hands;
      });
    }
  }

  List<String> ranks = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'];

  List<List<String>> buildPokerHandsMatrix(List<String> ranks) {
    List<List<String>> matrix = [];

    for (int i = 0; i < ranks.length; i++) {
      for (int j = 0; j < ranks.length; j++) {
        String hand;
        if (i == j) {
          hand = '${ranks[i]}${ranks[j]}'; // Pair
        } else if (i < j) {
          hand = '${ranks[j]}${ranks[i]}s'; // Suited
        } else {
          hand = '${ranks[i]}${ranks[j]}o'; // Offsuit
        }
        if (j == 0) {
          matrix.add([hand]); // Start a new row
        } else {
          matrix[i].add(hand); // Add to the existing row
        }
      }
    }
    return matrix;
  }

  @override
  Widget build(BuildContext context) {

    // Get the MediaQuery to determine screen width
    double screenWidth = MediaQuery.of(context).size.width;

   // Calculate the size of each cell to fit the screen width
    // 13 cells across, minus padding and grid spacing
    double cellWidth = (screenWidth - 26) / 13; // Assuming 1.0 is the spacing between cells
    double cellHeight = cellWidth; // Keep the cell height the same as the width for square cells
    
   // You may want to adjust the padding value to suit your design.
    const EdgeInsets gridPadding = EdgeInsets.all(8.0); // This can be any value you need
    

    List<List<String>> matrix = buildPokerHandsMatrix(ranks);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - ${widget.position}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              // Clear the selected hands
              await handSelection.clearSelectedHands(widget.category, widget.position);
              // Update the UI
              setState(() {
                selectedHands.clear();
              });
            },
          ),
        ],
      ),

      body: Padding(
          padding: gridPadding, // Set padding here
          child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 13, // Since poker hands are 13x13
            childAspectRatio: 1, // Ensuring the cells are square
            mainAxisSpacing: 0.5, // Main axis (vertical) spacing
            crossAxisSpacing: 0.5, // Cross axis (horizontal) spacing
          ),
          itemCount: matrix.length * matrix[0].length, // Total number of items in the matrix
          
          itemBuilder: (context, index) {
            int row = index ~/ 13;
            int col = index % 13;
            
            // Ensure we don't go out of bounds if the last row is incomplete
            if (row >= matrix.length || col >= matrix[row].length) return Container();
            
            String hand = matrix[row][col];

            return InkWell(
              onTap: () async {
                bool isSelected = selectedHands.contains(hand);
                setState(() {
                  if (isSelected) {
                    selectedHands.remove(hand);
                  } else {
                    selectedHands.add(hand);
                  }
                });
                // Persist the changes
                await handSelection.selectHand(widget.category, widget.position, hand);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  color: selectedHands.contains(hand) ? Colors.blue : Colors.transparent,
                ),
                child: Center(
                  child: Text(hand, style: TextStyle(color: selectedHands.contains(hand) ? Colors.white : Colors.black)),
                ),
              ),
            );
          },
          ),
      ),
    );
  }
}
