class PlayerAction {
  String action;
  double amount;
  // Include other relevant fields like the stage of the game, etc.

  PlayerAction({required this.action, this.amount = 0.0});
}

class Player {
  String name;
  List<PlayerAction> actionsHistory;

  Player({required this.name}) : actionsHistory = [];
}
