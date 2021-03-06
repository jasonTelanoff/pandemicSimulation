import processing.sound.*;

//  _________________
// |_______   _______| 
//         | |
//         | |
//         | |
//  _      | |
// | |     | |
// \ \     | |
//  \ \___/  /
//   \______/
//
//Feel free to change these

final double spreadChance = .0005;
final int spreadRadius = 100;
final double chanceOfImmunity = .0001;
final double chanceOfDeath = 0.0001;
final double distEffect = 0.5;

//You can use "random", "normal", "boid"
final String behavior = "boid";
final static class startNumOfPeople {
  final static int healthy = 199;
  final static int infected = 2;
};
final int hospitalRoom = 100;
final float chanceOfDeathWithHospital = 0.00001;

final static HashMap<String, Integer> colors = new HashMap<String, Integer>();

final int deadOpacity = 200;

final int padding = 50;

final int snapshotFrames = 30;

// This causes a bit of lag. If there is a large population, this is not recomended.
final boolean showDirection = false;


//Don't change these
boolean graph = false;
int framesSinceSnapshot = 0;
int totalStartPeople;
boolean paused = false;

ArrayList<Human> humans = new ArrayList<Human>();
ArrayList<Human> deadHumans = new ArrayList<Human>();
ArrayList<GameState> gameStates = new ArrayList<GameState>();
ArrayList<HashMap> pointY = new ArrayList<HashMap>();

SoundFile infect;
SoundFile imune;
SoundFile death;


void setup() {  
  fullScreen();
  frameRate(120);

  rectMode(CENTER);

  totalStartPeople = startNumOfPeople.healthy + startNumOfPeople.infected;

  for (int i = 0; i < startNumOfPeople.infected; i++) {
    humans.add(new Human(true));
  }
  for (int i = 0; i < startNumOfPeople.healthy; i++) {
    humans.add(new Human(false));
  }

  gameStates.add(new GameState(humans, deadHumans));
  gameStates.add(new GameState(humans, deadHumans));
  
  pointYInit();

  colors.put("healthy", #00ff00);
  colors.put("infected", #ff0000);
  colors.put("imune", #0000ff);
  colors.put("dead", #696969);
  
  infect = new SoundFile(this, "blop.mp3");
  imune = new SoundFile(this, "cure.wav");
  death = new SoundFile(this, "death.wav");
}

void draw() {
  background(255);

  if (!graph) {
    strokeWeight(2);
    stroke(0);
    for (int i = 0; i < humans.size(); i++) {
      humans.get(i).show();
      if (!paused) {
        humans.get(i).update();
      }
    }
    for (int i = 0; i < deadHumans.size(); i++) {
      deadHumans.get(i).show();
      if (!paused) {
        deadHumans.get(i).update();
      }
    }
  } else {
    if (!paused) {
      for (int i = 0; i < humans.size(); i++) {
        humans.get(i).update();
      }
      for (int i = 0; i < deadHumans.size(); i++) {
        deadHumans.get(i).update();
      }
    }

    drawGraph();
    float y = map(hospitalRoom, 0, totalStartPeople, height - padding, padding);
    if (gameStates.get(gameStates.size() - 1).values.get("infected") <= hospitalRoom) {
      stroke(colors.get("healthy"));
    } else {
      stroke(colors.get("infected"));
    }
    line(padding, y, width - padding, y);
  }

  if (!paused) {
    if (framesSinceSnapshot < snapshotFrames) {
      framesSinceSnapshot++;
    } else {
      framesSinceSnapshot = 0;
      gameStates.add(new GameState(humans, deadHumans));
      pointY.add(new HashMap<String, Integer>());
      setPoints();
    }
  }

  fill(0);
  textSize(20);
  text(frameRate, 20, 30);
  text("v1.1.2", width - 70, height - 30);
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
