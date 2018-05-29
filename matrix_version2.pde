PFont font;
String sen = "古い兵士彼らはただ消ことはありま";
int textsize = 20;
ArrayList<Drop> dropList = new ArrayList<Drop>();



void setup() {
  rectMode(CENTER);
  font = createFont("黑体", 32);
  size(1600, 900);
  background(0);
  textFont(font);
  textAlign(CENTER);
  stroke(0);
  fill(0, 255, 0);
  
  for (int i = 1; i < width / 20 + 1; i++) {
    dropList.add(new Drop(20 * i));
  }
}



void draw() { 
  background(0);
  for (int i = 0; i < dropList.size(); i++) {
    Drop theDrop = dropList.get(i);
    theDrop.increase();
    theDrop.display();
    theDrop.reboot();
  }

  delay(60);
}



class Zimu {
  int xPos;
  int yPos;
  color c;
  int alpha;
  char letter;
  int counter;

  Zimu(int temxpos, int temypos) {
    counter = 0;
    xPos = temxpos;
    yPos = temypos;
    alpha = int(map(yPos, 0, 720, 100, 200));
    alpha += int(random(0, 50));
    alpha = constrain(alpha, 0, 255);
    c = color(0, 255, 0, alpha);
    letter = sen.charAt(int(random(0, 16)));
  }

  void display() {
    textSize(textsize);
    fill(c);
    text(letter, xPos, yPos);
    counter += 1;
    c = color(0, 255, 0, alpha);
  }

  void colorChange() {
    c = color(255, 255, 255, alpha);
  }

  void fade() {
    alpha -= 2.5;
    alpha = constrain(alpha, 0, 255);
  }

  void change() {
    this.letter = sen.charAt(int(random(0, 16)));
  }
}


class Drop {
  ArrayList<Zimu> letters;
  int xPos;
  int startPoint;
  int distance;
  int lifespan;
  int endPoint;
  Zimu first;

  Drop(int temxpos) {
    distance = textsize;
    letters = new ArrayList<Zimu>();
    xPos = temxpos;
    startPoint = -int(random(5))*25;
    lifespan = int(random(0, 25));
    endPoint = int(random(600,1000));
    Zimu first = new Zimu(temxpos, startPoint);
    letters.add(first);
  }

  void increase() {
    if (startPoint > endPoint) {
      return;
    }
    startPoint += distance;
    letters.add(new Zimu(xPos, startPoint));
    ;
  }

  void display() {

    for (int i = 0; i < letters.size(); i++) {
      Zimu theZimu = letters.get(i);

      if (int(random(0, 50)) == 3) {
        theZimu.change();
      }
      theZimu.fade();
      
      if (i == letters.size() - 1) {
        theZimu.colorChange();
      }
      
      theZimu.display();
      if (theZimu.counter >= lifespan) {
        letters.remove(theZimu);
      }
    }
  }

  void reboot() {
    if (letters.isEmpty()) {
      startPoint = int(random(0, 100));
      lifespan = int(random(0, 100));
    }
  }
}