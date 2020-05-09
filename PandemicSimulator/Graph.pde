class Point {
  final int x;
  final int y;

  Point(int _x, int _y) {
    x = _x;
    y = _y;
  }
}

void drawGraph() {
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("dead"), 0, totalStartPeople, height - padding, padding)), 
    1, "dead");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("imune"), 0, totalStartPeople, height - padding, padding)), 
    1, "imune");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("infected"), 0, totalStartPeople, height - padding, padding)), 
    1, "infected");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("healthy"), 0, totalStartPeople, height - padding, padding)), 
    1, "healthy");
}

void drawLine(Point prevPoint, int i, String type) {
  Point point = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) pointY.get(i).get(type));

  strokeWeight(10);
  stroke(colors.get(type));
  line(prevPoint.x, prevPoint.y, point.x, point.y);

  if (i < pointY.size() - 1) {
    drawLine(point, i + 1, type);
  }
}

void setPoints() {
  pointAdd("dead");
  pointAdd("imune");
  pointAdd("infected");
  pointAdd("healthy");
}

void pointAdd(String type) {
  final int i = pointY.size() - 1;
  pointY.get(i).put(type, (int) map(gameStates.get(i).values.get(type), 0, totalStartPeople, height - padding, padding));
}

void pointYInit() {
  pointY.add(new HashMap<String, Integer>());
  pointY.add(new HashMap<String, Integer>());

  pointSet(0, "dead");
  pointSet(0, "imune");
  pointSet(0, "infected");
  pointSet(0, "healthy");

  pointSet(1, "dead");
  pointSet(1, "imune");
  pointSet(1, "infected");
  pointSet(1, "healthy");
}

void pointSet(int i, String type) {
  pointY.get(i).put(type, (int) map(gameStates.get(i).values.get(type), 0, totalStartPeople, height - padding, padding));
}
