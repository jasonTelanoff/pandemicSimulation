class GameState {
  final int healthy;
  final int infected;
  final int imune;
  final int dead;
  final int infectedGraph;
  final int imuneGraph;
  final int deadGraph;

  GameState(ArrayList<Human> _humans) {
    int _healthy = 0;
    int _infected = 0;
    int _imune = 0;
    int _dead = 0;

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
    healthy = _healthy;
    infected = _infected;
    imune = _imune;
    dead = _dead;
    
    infectedGraph = _healthy + _infected;
    imuneGraph = _healthy + _infected + _imune;
    deadGraph = _healthy + _infected + _imune + _dead;
  }
}
