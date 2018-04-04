PFont font;
char [] arr = new char[26];
int i = 0;
int xStart = 200;
int yStart = 0;
char letter;
String sen = "古い兵士彼らはただ消ことはありま";
//int leading = 0;
int textsize = 20;
ArrayList<Zimu> zimuList = new ArrayList<Zimu>();
ArrayList [] printList = new ArrayList[100];
int [] y = new int [100];
int [] disappear = new int[100];
int [] end = new int[100];
int [] lead = new int[100];



void setup(){
  rectMode(CENTER);
  font = createFont("黑体", 32);
  size(1600,900);
  background(0);
  textFont(font);
  textAlign(CENTER);
  stroke(0);
  fill(0,255,0);
  for(int i=0;i<100;i++){
  printList[i] = new ArrayList<Zimu>();
  disappear[i] = int(random(20,50));
  y[i] = -int(random(5))*25;
  end[i] = int(random(600,1000));
  lead[i] = 0;
  }
  
  for(char ch='a';ch<='z';ch++){
    arr[i++] = ch;
  }  
}



void draw(){ 
  background(0);
  for(int i=1;i<width/20+1;i++){
  aRain(20*i,y[i],i);
  }


  //leading += 25;

  //if (leading > 1800){
  //  leading = 0;
  //    for(int i=0;i<100;i++){
  //      printList[i] = new ArrayList<Zimu>();
  //      stop[i] = int(random(12,25));
  //      y[i] = -int(random(20))*25;
  //      end[i] = int(random(900,1200));
  //}
      
  //}
  
      delay(50);
 }
      
  //if(y <= 800){
  ////letter = arr[int(random(0, 26))];
  //letter = sen.charAt(int(random(0, 16)));
  //int alpha = int(map(y, 0, 720, 50, 235));
  //alpha += int(random(0, 50));
  //alpha = constrain(alpha, 0, 255);
  //fill(0, 255,0, alpha);
  //text(letter, x, y);
  //y += 35;
  //delay(55);
  //}

class Zimu{
  int xPos;
  int yPos;
  color c;
  int alpha;
  char letter;
  int counter;
  
  Zimu(int temxpos, int temyPos){
    counter = 0;
    xPos = temxpos;
    yPos = temyPos;
    alpha = int(map(yPos, 0, 720, 100, 200));
    alpha += int(random(0, 50));
    alpha = constrain(alpha, 0, 255);
    c = color(0, 255, 0, alpha);
    letter = sen.charAt(int(random(0, 16)));
  }
  
  void display(){
    textSize(textsize);
    fill(c);
    text(letter, xPos, yPos);
  }
  
  void colorChange(){
    fill(225,225,225,alpha);//no alpha for better white to green effect
    text(letter, xPos, yPos);
  }
    
  void disappear(){
   counter += 1;
   fill(0);
   text(letter, xPos, yPos);
   //rect(xPos, yPos, 30, 30); 
  }
  
  void change(){
    this.letter = sen.charAt(int(random(0, 16)));
    //this.c = color(0,255,0,alpha(this.c)+random(-10,10));
  }
    
  
}

void aRain(int xStart, int yStart, int index){
  zimuList = printList[index];

  
  if(lead[index]+yStart < end[index]){//让每条字符的结束位置不同，下一步是让每个function的leading单独计算，并且重置index
  Zimu myZimu = new Zimu(xStart,yStart+lead[index]);
  zimuList.add(myZimu);
  }
  
    
  if (zimuList.size()==0){
    lead[index] = 0;
        printList[index] = new ArrayList<Zimu>();
        disappear[index] = int(random(20,50));
        y[index] = -int(random(5))*10;
        end[index] = int(random(600,1000));
  }
      
    lead[index] += 20;

  
  //for(Zimu theZimu : zimuList){ 
  /* 使用iterator进行遍历时会抛出ConcurrentModificationException异常
  链接http://blog.csdn.net/androiddevelop/article/details/21509345
  https://www.jianshu.com/p/c5b52927a61a */
  

  for(int i=0;i<zimuList.size();i++){
   Zimu theZimu = zimuList.get(i);
   
   if(int(random(0,50))==3){
      theZimu.change();
    }
    

    //theZimu.c = color(0,255,0,250-theZimu.counter*4);
    float gg = alpha(theZimu.c) ;
    gg -= 2.5;
    theZimu.c = color(0,255,0,gg);





   
   theZimu.display();
   theZimu.counter += 1;
   
   Zimu her = zimuList.get(zimuList.size()-1);
   her.colorChange();
   


   
   if (theZimu.counter >= disappear[index]){//让每条字符开始消失的长度不同
   zimuList.remove(theZimu);
   i--;
   }
   

  }
  

   
   

  //if(zimuList.size()>12){
  //  zimuList.remove(0);
  //}
 
}
 




  