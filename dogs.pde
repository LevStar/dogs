// fixed second dog, added game over


boolean thrust = false;//boolean = can be only "true" or "false"
int cDia = 80, dDia = 80, health = 700; 
float catX=400;//horizantal position of the image
float catY=300;//"float" = decimal number
float catAng=0;
float catRot=0;
float mvX=0;//amount to move horizantal
float mvY=0;//amount to move vertically
float dogX=500;//horizantal position of the image
float dogY=200;//"float" = decimal number
float dog2X=300;
float dog2Y=209;
float d1MVx=0;//amount to move horizantal
float d1MVy=0;//amount to move vertically
int dog1dir = -1;
int dog2dir = 1;
float d2MVx=0;//amount to move horizantally
float d2MVy=0;//amount to move horizantally
float speedVarC = .25;//how fast the game will run
float speedVarD = .25;
float speedVarD2 = .5;
color bgCol;
PImage catSpr, catJet, dogSpr, dogViz, catViz, dog2Spr, dog2Viz;


void setup() {  

  catSpr = loadImage("data/cat.png");
  catJet = loadImage("data/cat26.png");
  dogSpr = loadImage("data/dog.png");
  dog2Spr = loadImage("data/dog.png");
  catViz = catSpr;//sets the image we can see.
  size(700, 800);
  dogViz = dogSpr;//sets the image we can see.
  dog2Viz = dog2Spr;//sets the image we can see.
  bgCol = color(255.255, 255);//sets bgCol to white.
}


void draw() {

  fill(bgCol);//Fill the next shape with this color
  rect(0, 0, 700, 800);//draw the background

  // cat code ---------------------------------------------------------------------
  catAng = (catAng + catRot);//set the image to what is was + catRot

  if (thrust==true) {
    mvX += cos(radians(catAng));
    mvY += sin(radians(catAng));
  }


  catX = catX + mvX * speedVarC;//set horizantal position of image

  catY = catY + mvY * speedVarC;//set vertical position of image

  if (catX < -100) {//has image gone off left edge?
    catX = 900;//teleport image to right edge
  } else if (catX > 900) {//has image gone off the right edge?
    catX = 0;//teleport image to left edge
  }

  if (catY < -100) {//has image gone off the top edge?
    catY = 600;//teleport image to bottom ege
  } else if (catY > 700) {// has image gone off bottom
    catY = 0;//teleport image to top edge
  }



  imageMode(CENTER);//sets image
  pushMatrix();
  translate(catX, catY);
  rotate(radians(catAng));//Rotate the image to catAng.
  image(catViz, 0, 0, 100, 100);//shows image on screen.
  popMatrix();

 //ellipse(  catX, catY, cDia, cDia);




  // dog 1 code --------------------------------------------------------------------- 

  if (catX < dogX) {
    d1MVx = -2;
    dog1dir = -1;
  } else if (catX > dogX) {
    d1MVx = 2;
    dog1dir = 1;
  } else {
    d1MVx = 0;
  }

  if (catY < dogY) {
    d1MVy = -2;
  } else if (catY > dogY) {
    d1MVy = 2;
  } else {
    d1MVy = 0;
  }

  dogX = dogX + d1MVx * speedVarD;//set horizantal position of image
  dogY = dogY + d1MVy * speedVarD;//set vertical position of image

  imageMode(CENTER);//sets image
  pushMatrix();
  translate(dogX, dogY);
  scale(dog1dir, 1);
  image(dogViz, 0, 0, 100, 100);//shows image on screen.
  popMatrix();

  //ellipse(  dogX, dogY, dDia, dDia);

  if (dist(catX, catY, dogX, dogY) < cDia / 2 + cDia / 2) {
    println("munch");
     health -= 1;
  }
  
  // dog2 code --------------------------------------------------------------------- 

  if (catX < dog2X) {
    d2MVx = -2;
    dog2dir = -1;
   } 
  else if (catX > dog2X) {
    d2MVx = 2;
    dog2dir = 1;
  } else {
    d2MVx = 0;
  }

  if (catY < dog2Y) {
    d2MVy = -2;
  } else if (catY > dog2Y) {
    d2MVy = 2;
  } else {
    d2MVy = 0;
  }
  
  dog2X = dog2X + d2MVx * speedVarD;//set horizantal position of image
  dog2Y = dog2Y + d2MVy * speedVarD;//set vertical position of image
  
  if (dist(catX, catY, dog2X, dog2Y) < cDia / 2 + cDia / 2) {
  }
  
  
 

 imageMode(CENTER);//sets image
    pushMatrix();
    translate(dog2X, dog2Y);
    scale(dog2dir, 1);
    image(dogViz,0,0,100,100);//shows image on screen.
    popMatrix();
  
   //ellipse(  dog2X, dog2Y, dDia, dDia);
  
  // ------------------- health bar -------------------------------
  fill(255,0,0);
  rect(0, 780, 700, 20);
  
  fill(0,255,0);
  rect(0, 780, health, 20);
  
  if(health == 0){ 
    exit();
  }
  
}


void keyPressed() {// checks if a key has been pressed

  if (key== 'a') { // If a is pressed....
    catRot = -3.0;//set the movement var to go left
  }
  if (key== 'd') {  // If d is pressed....
    catRot = 3.0; //set the rotation to cw 3 degrees.
  }
  if (key== 'w') { // If w is pressed....
    mvY = -3.0;//set the rotation to ccw 3 degrees.
  }
  if (key== 's') {//if s is pressed....
    catViz = catJet;
    thrust = true;//the thrust situation is now TRUE
  }
}


void keyReleased() { //check is key has been let go of.

  if (key== 's') {//if you let go of s...
    catViz = catSpr;
    thrust = false;// thrust situation becomes false
  }

  if (key== 'a') { //If you let go of a...
    catRot = 0.0;//set rotation to 0
  }

  if (key== 'd') { // if you let go of d...
    catRot = 0.0; //set rotationto 0
  }
}