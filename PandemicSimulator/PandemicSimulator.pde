//Feel free to change these

final double spreadChance = .1;
final int spreadDistance = 50;
final double chanceOfImmunity = .001;
final double chanceOfDeath = 0.0005;
final double movementSpeed = 1;

//You can use "random", "normal", "boid", or "staySafe"
final String behavior = "boid";
final boolean breeding = false;
final static class startNumOfPeople {
  final static int healthy = 90;
  final static int infected = 10;
};
final static class colors {
  final static color healthy = #00ff00;
  final static color infected = #ff0000;
  final static color imune = #0000ff;
  final static color dead = #696969;
}

final int snapshotFrames = 30;


//Don't change these
boolean graph = false;
int framesSinceSnapshot = 0;
int totalStartPeople;
boolean paused = false;

ArrayList<Human> humans = new ArrayList<Human>();
ArrayList<GameState> gameStates = new ArrayList<GameState>();


void setup() {  
  fullScreen();
  frameRate(120);

  rectMode(CENTER);

  totalStartPeople = startNumOfPeople.healthy + startNumOfPeople.infected;

  for (int i = 1; i < startNumOfPeople.infected; i++) {
    humans.add(new Human(true));
  }
  for (int i = 1; i < startNumOfPeople.healthy; i++) {
    humans.add(new Human(false));
  }

  gameStates.add(new GameState(humans));
  gameStates.add(new GameState(humans));
}

void draw() {
  background(255);

  if (!graph) {
    strokeWeight(2);
    stroke(0);
    for (int i = 0; i < humans.size(); i++) {
      if (!paused) {
        humans.get(i).update();
      }
      humans.get(i).show();
    }
  } else {
    if (!paused) {
      for (int i = 0; i < humans.size(); i++) {
        humans.get(i).update();
      }
    }

    drawGraph();
  }

  if (!paused) {
    if (framesSinceSnapshot < snapshotFrames) {
      framesSinceSnapshot++;
    } else {
      framesSinceSnapshot = 0;
      gameStates.add(new GameState(humans));
      //println(gameStates.get(gameStates.size() - 1).healthy);
    }
  }

  fill(0);
  textSize(20);
  text(frameRate, 20, 30);
}

void keyReleased() {
  if (keyCode == 32) {
    if (paused) {
      paused = false;
    } else {
      paused = true;
    }
  } else {
    if (graph) {
      graph = false;
    } else {
      graph = true;
    }
  }
}
