class GameState {
  final HashMap<String,Integer> values = new HashMap<String,Integer>();
  
  GameState(ArrayList<Human> _humans, ArrayList<Human> _deadHumans) {
    int _healthy = 0;
    int _infected = 0;
    int _imune = 0;
    int _dead = deadHumans.size();

    for (int i = 0; i < _humans.size(); i++) {
      switch(_humans.get(i).state) {
      case "healthy":
        _healthy++;
        break;
      case "infected":
        _infected++;
        break;
      case "imune":
        _imune++;
        break;
      case "dead":
        _dead++;
        break;
      }
    }
    values.put("healthy", _healthy);
    values.put("infected", _infected);
    values.put("imune", _imune);
    values.put("dead", _dead);
    
    values.put("infectedGraph", _healthy + _infected);
    values.put("imuneGraph", _healthy + _infected + _imune);
    values.put("deadGraph", _healthy + _infected + _imune + _dead);
  }
}
