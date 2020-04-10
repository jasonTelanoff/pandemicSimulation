class Human {
  PVector acceleration = new PVector(0, 0);
  PVector velocity = PVector.random2D();
  PVector position = new PVector(random(width), random(height));
  PVector movement = new PVector(0, 1);

  final float angleOfRotation = 0.1;
  final float r = 5.0;
  final int size = (int) r*5;
  final int maxspeed = 3;
  final float maxforce = 0.05;

  String state = "healthy";
  boolean infected = false;
  color col;

  Human(boolean _infected) {
    infected = _infected;
    if (infected) {
      state = "infected";
    }
  }

  void show() {
    color col = col();
    fill(col);
    //pushMatrix();
    //translate(position.x, position.y);
    //rotate(movement.heading());
    //rect(0, 0, size, size);
    //popMatrix();
    square(position.x, position.y, size);
  }

  void update() {
    if (state != "dead") {
      if (infected) {
        float num = random(1);
        if (num <= chanceOfImmunity) {
          state = "imune";
          infected = false;
          humans.add(this);
          humans.remove(this);
        } else if (num <= chanceOfImmunity + chanceOfDeath) {
          state = "dead";
          infected = false;
          deadHumans.add(this);
          humans.remove(this);
        } else {
          spread();
        }
      }
      switch (behavior) {
      case "random":
        randomMove();
        break;
      case "normal":
        normalMove();
        break;
      case "boid":
        boidMove();
        break;
      default:
        normalMove();
        break;
      }
      borders();
    }
  }

  void randomMove() {
    position.add(PVector.random2D());
  }

  void normalMove() {
    position.add(movement);
    movement.rotate(random(-.1, .1));
  }

  void boidMove() {
    flock(humans);
    boidUpdate();
    borders();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void flock(ArrayList<Human> _humans) {
    PVector sep = separate(_humans);
    PVector ali = align(_humans);
    PVector coh = cohesion(_humans);

    sep.mult(2.5);
    ali.mult(1.0);
    coh.mult(1.0);

    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void boidUpdate() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);

    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  PVector separate(ArrayList<Human> _humans) {
    double desiredseparation = 25.0;
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (int i = 0; i < _humans.size(); i++) {
      float d = PVector.dist(position, _humans.get(i).position);

      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(position, _humans.get(i).position);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.div(count);
    }


    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector align(ArrayList<Human> _humans) {
    int neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (int i = 0; i < _humans.size(); i++) {
      float d = PVector.dist(position, _humans.get(i).position);
      if (d > 0 && d < neighbordist) {
        sum.add(_humans.get(i).velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector cohesion(ArrayList<Human> _humans) {
    int neighbordist = 50;
    PVector sum = new PVector(0, 0); // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = 0; i < _humans.size(); i++) {
      float d = PVector.dist(position, _humans.get(i).position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(_humans.get(i).position); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum); // Steer towards the location
    } else {
      return new PVector(0, 0);
    }
  }

  void borders() {
    if (position.x < -angleOfRotation) {
      position.x = width + angleOfRotation;
    }
    if (position.y < -angleOfRotation) {
      position.y = height + angleOfRotation;
    }
    if (position.x > width + angleOfRotation) {
      position.x = -angleOfRotation;
    }
    if (position.y > height + angleOfRotation) {
      position.y = -angleOfRotation;
    }
  }

  void spread() {
    for (int i = 0; i < humans.size(); i++) {
      Human otherGuy = humans.get(i);
      if (otherGuy.state == "healthy") {
        float dist = dist(position.x, position.y, otherGuy.position.x, otherGuy.position.y);
        if (random(1) <= (-pow(dist, 2)*distEffect*spreadChance)/(2*pow(spreadRadius, 1.69)) + spreadChance) {
            humans.get(i).state = "infected";
            humans.get(i).infected = true;
            humans.add(humans.get(i));
            humans.remove(i);
        }
      }
    }
  }

  color col() {
    switch(state) {
    case "healthy":
      return colors.get("healthy");
    case "infected":
      return colors.get("infected");
    case "imune":
      return colors.get("imune");
    case "dead":
      return color(colors.get("dead"), deadOpacity);
    default:
      println("this is it");
      state = "healthy";
      infected = false;
      return color(0, 255, 0);
    }
  }
}
