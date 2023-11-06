import 'package:shared_preferences/shared_preferences.dart';

class HandSelection {
  static const String _prefsKey = 'selectedHands';

  Future<Set<String>> getSelectedHands(String category, String position) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_getKey(category, position))?.toSet() ?? <String>{};
  }

  Future<void> selectHand(String category, String position, String hand) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = _getKey(category, position);
    final hands = (prefs.getStringList(key) ?? []).toSet();

    if (hands.contains(hand)) {
      hands.remove(hand);
    } else {
      hands.add(hand);
    }

    await prefs.setStringList(key, hands.toList());
  }

  Future<void> clearSelectedHands(String category, String position) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_getKey(category, position));
  }


  String _getKey(String category, String position) => '$_prefsKey-$category-$position';
}
