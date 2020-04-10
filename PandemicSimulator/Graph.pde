class Point {
  final int x;
  final int y;

  Point(int _x, int _y) {
    x = _x;
    y = _y;
  }
}

ArrayList<int[]> ys = new ArrayList<int[]>();

void drawGraph() {
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("healthy"), 0, totalStartPeople, height - padding, padding)), 
    new Point(padding, (int) map(gameStates.get(0).values.get("infected"), 0, totalStartPeople, height - padding, padding)), 
    new Point(padding, (int) map(gameStates.get(0).values.get("imune"), 0, totalStartPeople, height - padding, padding)), 
    new Point(padding, (int) map(gameStates.get(0).values.get("dead"), 0, totalStartPeople, height - padding, padding)), 
    1);
}

void drawLine(Point prevHealthy, Point prevInfec, Point prevImune, Point prevDead, int i) {
  Point pointHealthy = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) map(gameStates.get(i).values.get("healthy"), 0, totalStartPeople, height - padding, padding));
  Point pointInfected = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) map(gameStates.get(i).values.get("infected"), 0, totalStartPeople, height - padding, padding));
  Point pointImune = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) map(gameStates.get(i).values.get("imune"), 0, totalStartPeople, height - padding, padding));
  Point pointDead = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) map(gameStates.get(i).values.get("dead"), 0, totalStartPeople, height - padding, padding));

  //noStroke();
  //fill(colors.dead);
  //  quad(prevDead.x, prevDead.y, pointDead.x, pointDead.y, pointDead.x, height - padding, prevDead.x, height - padding);
  //fill(colors.imune);
  //  quad(prevImune.x, prevImune.y, pointImune.x, pointImune.y, pointImune.x, height - padding, prevImune.x, height - padding);
  //fill(colors.infected);
  //  quad(prevInfec.x, prevInfec.y, pointInfected.x, pointInfected.y, pointInfected.x, height - padding, prevInfec.x, height - padding);
  //fill(colors.healthy);
  //  quad(prevHealthy.x, prevHealthy.y, pointHealthy.x, pointHealthy.y, pointHealthy.x, height - padding, prevHealthy.x, height - padding);
    
    
  strokeWeight(10);
  stroke(0);
  
  stroke(colors.dead);
    line(prevDead.x, prevDead.y, pointDead.x, pointDead.y);
  stroke(colors.imune);
    line(prevImune.x, prevImune.y, pointImune.x, pointImune.y);
  stroke(colors.infected);
    line(prevInfec.x, prevInfec.y, pointInfected.x, pointInfected.y);
  stroke(colors.healthy);
    line(prevHealthy.x, prevHealthy.y, pointHealthy.x, pointHealthy.y);

  if (i < gameStates.size() - 1) {
    drawLine(pointHealthy, pointInfected, pointImune, pointDead, i + 1);
  }
}
