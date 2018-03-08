// controls
player player1;
player player2;
boolean[] controls = new boolean[12];
boolean tester = false;
// sizes of players
int p1s = 8;
int p2s = 8;
// hitboxes 
hitbox[] hitboxes = new hitbox[7];
// images
PImage titleScreen; 
PImage karel; 
PImage campbell; 
PImage doge; 
PImage stage1thumb; 
PImage stage2thumb; 
PImage titlescreenthumb;
PImage stage1;
PImage stage2;
//different screens
boolean opening = true;
boolean start = false;
boolean characters = false;
boolean stages = false;
// for selecting characters
boolean campbell1;
boolean karel1;
boolean doge1;
boolean campbell2;
boolean karel2;
boolean doge2;
int charactercount;
// for selecting stages
boolean terminalrendezvous;
boolean titlescreen;
boolean stagetwo;
// opening screen image size
float titleHeight = 20;
float titleWidth = 32;
// character starting positions
int startingpos1;
int startingpos2;
// music
import ddf.minim.*;
AudioPlayer player;
AudioPlayer gameplayer;
Minim music;
// health bars
healthbar p1health = new healthbar();
healthbar p2health = new healthbar();
// two end screens
boolean win1;
boolean win2;
//
int p1;
int p2;
PFont myFont;

void setup() {
  size(1280, 800);
  
  //initializing pictures
  titleScreen = loadImage("TitleScreen.jpg");
  campbell = loadImage("campbell.jpg");
  karel = loadImage("karel.jpg");
  doge = loadImage("doge.jpg");
  stage1thumb = loadImage("stage1thumb.jpg");
  stage2thumb = loadImage("stage2thumb.jpg");
  titlescreenthumb = loadImage("titlescreenthumb.jpg");
  stage1 = loadImage("Stage1.jpg");
  stage2 = loadImage("Stage2.jpg");
  
  // setting up controls
  for (int i = 0; i<12; i++) controls[i] = false;
 
  // music
  music = new Minim(this);
  player = music.loadFile("music.mp3",2048);
  gameplayer = music.loadFile("kazoomusic.mp3", 2048);
  player.play();
  
  // font
  myFont = createFont("VT323.ttf", 12);
  
  }
  
void mouseClicked()
  {
   //******STAGE SCREEN BUTTONS*********// 
   
   // back button
   if (stages && (mouseX > width/4 - 5 && mouseX < width/4 + 145) && (mouseY > 655 && mouseY < 705))
   {
     characters = true;
     stages = false;
   }
   // start button
   if (stages && (mouseX > 2*width/3 - 10 && mouseX < 2*width/3 + 110) && (mouseY > 655 && mouseY < 705))
   {
     start = true;
     characters = false;
     stages = false;
   }
   // select terminal rendevous
   if (stages && (mouseX > width/2 - 100 && mouseX < width/2 + 100) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     terminalrendezvous = true;
     titlescreen = false;
     stagetwo=false;
   }
   // select stage two
   if (stages && (mouseX > width/2 + 150 && mouseX < width/2 + 350) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     stagetwo = true;
     titlescreen = false;
     terminalrendezvous = false;
   }
   // select titlescreen
   if (stages && (mouseX > width/2 - 350 && mouseX < width/2 - 150) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     titlescreen = true;
     terminalrendezvous = false;
     stagetwo = false;
   }
   
   //******CHARACTER SCREEN BUTTONS*********//
   
   // select mr. campbell
   if (characters && (mouseX > width/2 - 100 && mouseX < width/2 + 100) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     // if player 1 is selecting
     if (charactercount == 0)
     {
       campbell1 = true;
       p1 = 0;
       player1= new player(289, 0, p1);
     }
     // if player 2 is selecting
     if (charactercount == 1)
     {
       campbell2 = true;
       p2 = 0;
       player2= new player(973, 0, p2);
     }
     // proceed to next character
     if (charactercount < 2)
     {
       charactercount++;
     }
   }
   
   // select karel the robot
   if (characters && (mouseX > width/2 + 150 && mouseX < width/2 + 350) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     if (charactercount == 0)
     {
       karel1 = true;
       p1 = 1;
       player1=new player(289, 0, p1);
     }
     if (charactercount == 1)
     {
       karel2 = true;
       p2 = 1;
       player2=new player(973, 0, p2);
     }
     if (charactercount <2)
     {
       charactercount++;
     }
   }
   
   // select doge
   if (characters && (mouseX > width/2 - 350 && mouseX < width/2 - 150) && (mouseY > height/2 - 100 && mouseY < height/2 + 100))
   {
     if (charactercount == 0)
     {
       doge1 = true;
       p1 = 2;
       player1=new player(289, 0, p1);
     }
     if (charactercount == 1)
     {
       doge2 = true;
       p2 = 2;
       player2=new player(973, 0, p2);
     }
     if (charactercount <2)
     {
       charactercount++;
     }
   }
   
   // reset button
   if (characters && (mouseX > width/4 - 5 && mouseX < width/4 + 145) && (mouseY > 655 && mouseY < 705))
   {
     charactercount = 0;
     karel1 = false;
     doge1 = false;
     campbell1 = false;
     karel2 = false;
     doge2 = false;
     campbell2 = false;
     rect(width/4 + 70, height - 120, 120, 50);
   }
   
   // okay button
   if (characters && (mouseX > 2*width/3 - 10 && mouseX < 2*width/3 + 110) && (mouseY > 655 && mouseY < 705) && charactercount == 2)
   {
     characters = false;
     stages = true;
   }
   
  
  if (win1 || win2)
   {
     exit();
   }
   
  }

// character controls
void keyPressed() {
  switch(key) {
    case 'a':
    controls[0]=true;
    break;
    case 'w':
    player1.jump();
    break;
    case 'd':
    controls[1]=true;
    break;
    case 'f':
    player1.shoot();
    break;
    case '.':
    player2.shoot();
    break;
  }
  switch(keyCode) {
    case 37:
    controls[2]=true;
    break;
    case 38:
    player2.jump();
    break;
    case 39:
    controls[3]=true;
    break;
  }
} 

void keyReleased() {
  switch(key) {
    case 'a':
    controls[0]=false;
    break;
    case 'd':
    controls[1]=false;
    break;
  }
  switch(keyCode) {
    case 37:
    controls[2]=false;
    break;
    case 39:
    controls[3]=false;
  }
}


void draw() {
  textFont(myFont);
  // opening "animation"
  if (opening)
  {
    background(255);
    if (titleWidth <= 1280)
    {
      titleWidth = titleWidth + 10;
    }
    if (titleHeight <= 800)
    {
      titleHeight = titleHeight + 6.25;
    }
    image(titleScreen, width/2 - (titleWidth/2) - 50, height/2 - (titleHeight/2)- 15, titleWidth, titleHeight);
    if (titleWidth >= 1280 && millis() > 9000)
    {
      characters = true;
      opening = false;
    }
  }
  
  // character selection screen 
  if (characters)
  {
    background(255);
    rectMode(CENTER);
    fill(0);
    
    // players
    textSize(32);
    text("Player 1:", width/4 + 20, 100); 
    text("Player 2:", 2*width/3 - 20, 100); 
    
    // player 1
    if (campbell1)
    {
      text("Mr. Campbell", width/4, 150); 
    }
    if (karel1)
    {
      text("Karel the Robot", width/4 - 20, 150); 
    }
    if (doge1)
    {
      text("Doge", width/4 + 40, 150); 
    }
    
    // player 2
    if (campbell2)
    {
      text("Mr. Campbell", 2*width/3 - 40, 150); 
    }
    if (karel2)
    {
      text("Karel the Robot", 2*width/3 - 70, 150); 
    }
    if (doge2)
    {
      text("Doge", 2*width/3 + 10, 150); 
    }
    
    // reset button 
     fill(0);
     rect(width/4 + 70, height - 120, 150, 50);
     fill(255);
     text("reset", width/4 + 40, height - 110);
      
   
    // okay button
    fill(0);
    rect(2*width/3 + 50, height - 120, 120, 50);
    fill(255);
    text("okay", 2*width/3 + 25, height - 110);
    
    // characters
    fill(0);
    rect(width/2, height/2, 200, 200); 
    image(campbell, width/2 - 90, height/2- 90, 180, 180);
    rect(width/2 + 250, height/2, 200, 200);
    image(karel, width/2 + 160, height/2 - 90, 180, 180);
    rect(width/2 - 250, height/2, 200, 200); 
    image(doge, width/2 -340, height/2 - 90, 180, 180);
  }
  
  // stage screen
  if (stages)
  {
    textSize(32);
    background(255);
    if (terminalrendezvous)
    {
      tint(255, 126);
      image(stage1, 0, 0, 1280, 800);
      fill(0);
      text("Terminal Rendezvous", width/2 - 130, 150);
    }
    
    if (titlescreen)
    {
      tint(255, 126);
      image(titleScreen, 0, 0, 1280, 800);
      fill(0);
      text("Title Screen", width/2 - 80, 150); 
    }
    
     if (stagetwo)
    {
      tint(255, 126);
      image(stage2, 0, 0, 1280, 800);
      fill(0);
      text("Stage Two", width/2 - 60, 150);
    }
    
    rectMode(CENTER);
    noTint();
    fill(0);
    rect(width/2, height/2, 200, 200); 
    image(stage1thumb, width/2 - 90, height/2- 90, 180, 180);
    rect(width/2 + 250, height/2, 200, 200);
    image(stage2thumb, width/2 + 160, height/2 - 90, 180, 180);
    rect(width/2 - 250, height/2, 200, 200); 
    image(titlescreenthumb, width/2 -340, height/2 - 90, 180, 180);
    
    // back button
     fill(0);
     rect(width/4 + 70, height - 120, 120, 50);
     fill(255);
     text("back", width/4 + 40, height - 110);
     
    // okay button
    fill(0);
    rect(2*width/3 + 50, height - 120, 120, 50);
    fill(255);
    text("start", 2*width/3 + 15, height - 110);
    
    // stage text
    fill(0);
    text("Stage:", width/2 - 40, 100); 
    
  }
  
  // playing screen
  if (start)
  {
    if (titlescreen)
    {
      background(255);
      image(titleScreen, 0, 0, 1280, 800);
      // erorequiem
      hitboxes[0]=new hitbox(671,573,169,0);
      // tussle2z
      hitboxes[1]=new hitbox(393,516,97,0);
      // mash
      hitboxes[2]=new hitbox(648,329,127,0);
      // HD
      hitboxes[3]=new hitbox(900,250,148,0);
      // floor
      hitboxes[4]=new hitbox(width/2,height,width,0);
      // extras
      hitboxes[5]=new hitbox(width,height,0,0);
      hitboxes[6]=new hitbox(width,height,0,0);
    }
    if (terminalrendezvous)
    {
      background(0);
      image(stage1, 0, 0, 1280, 800);
      // bottom platform
      hitboxes[0]=new hitbox(width/2 - 10,510,350,0);
      // two side platforms
      hitboxes[1]=new hitbox(289,335,110,0);
      hitboxes[2]=new hitbox(973,335,120,0);
      // top platform
      hitboxes[3]=new hitbox(width/2 - 10,160,120,0);
      // extras
      hitboxes[4]=new hitbox(width,height,0,0);
      hitboxes[5]=new hitbox(width,height,0,0);
      hitboxes[6]=new hitbox(width,height,0,0);
    }
    if (stagetwo)
    {
      background(161,249,255);
      image(stage2, 0, 0, 1280, 800);
      // bridge crest
      hitboxes[0]=new hitbox(556,251,68,0);
      hitboxes[1]=new hitbox(707,249,60,0);
      // left
      hitboxes[2]=new hitbox(126,360,133,0);
      // right
      hitboxes[3]=new hitbox(1145,340,126,0);
      // floor
      hitboxes[4]=new hitbox(width/2,582,width/2,0);
      // extras
      hitboxes[5]=new hitbox(width,height,0,0);
      hitboxes[6]=new hitbox(width,height,0,0);
      // startingpositions
      startingpos1 = 126;
      startingpos2 = 1145;
    }
    
  if (controls[0])player1.accelerateLeft();
  if (controls[1])player1.accelerateRight();
  if (controls[2])player2.accelerateLeft();
  if (controls[3])player2.accelerateRight();
  if (!win1 && !win2)
  {
  player1.showhealth1(); // shows player1 health
  player2.showhealth2();
  player1.getHit(player2);
  player2.getHit(player1);
  player1.friction(); // decelerates player1 if they are grounded
  player1.gravitate(); // accelerates player1 downwards
  player1.collide(); // detects if in the next frame player1 will collide with a hitbox
  player1.move(); // accelerates player1 in the direction of the corresponding keys (wasd/arrows)
  player1.make(); // displays player1
  player2.friction(); // deccelerates player2
  player2.gravitate();
  player2.collide();
  player2.move();
  player2.make();
  }
  if (win1)
  {
    background(255);
    fill(0);
    textSize(32);
    text("Player 1 wins!", 550, height/3);
    text("click to exit", 550, 500);
  }
  if (win2)
  {
    background(255);
    fill(0);
    textSize(32);
    text("Player 2 wins!", 550, height/3);
    text("click to exit", 550, 500);
  }
  println(player1.health);
  println(player2.health);
  for (int i = 0; i<hitboxes.length; i++) {
    hitboxes[i].make();
  }
}
}

public class healthbar
{
  public healthbar() {
  }
  
  // player 1 bars
  public void p1full() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(250, 50, 200, 20);
  }
  public void p190() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(240, 50, 180, 20);
  }
  
  public void p180() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(230, 50, 160, 20);
  }
  public void p170() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(220, 50, 140, 20);
  }
  public void p160() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(210, 50, 120, 20);
  }
   public void p150() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(200, 50, 100, 20);
  }
   public void p140() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(190, 50, 80, 20);
  }
  public void p130() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(180, 50, 60, 20);
  }
  public void p120() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(170, 50, 40, 20);
  }
  public void p110() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
    fill(255, 0, 0);
    rect(160, 50, 20, 20);
  }
   public void p1dead() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(250, 50, 210, 30);
  }
  
  // player 2 bars
  public void p2full() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1030, 50, 200, 20);
  }
  public void p290() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1040, 50, 180, 20);
  }
  
  public void p280() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1050, 50, 160, 20);
  }
  public void p270() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1060, 50, 140, 20);
  }
  public void p260() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1070, 50, 120, 20);
  }
   public void p250() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1080, 50, 100, 20);
  }
   public void p240() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1090, 50, 80, 20);
  }
  public void p230() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1100, 50, 60, 20);
  }
  public void p220() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1110, 50, 40, 20);
  }
  public void p210() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
    fill(255, 0, 0);
    rect(1120, 50, 20, 20);
  }
   public void p2dead() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(1030, 50, 210, 30);
  }
}

public class player{
  private float fakeX; // relative to the center of the player
  private int x;
  private float fakeY; // relative to the center of the player
  private int y;
  private int size=8;
  private float xVel=0;
  private float yVel=0;
  private float health = 10;
  private int character;
  private float playerWidth;
  private float playerHeightUp;
  private float playerHeightDown;
  private bullet[] bullets = new bullet[3];
  private int bulletCount = 0;
  private boolean grounded = false;
  private boolean canJump = false;
  public player(float xC, float yC, int characterC) {
    fakeX = xC;
    fakeY = yC;
    character = characterC;
    for (int i = 0; i<bullets.length; i++) {
      bullets[i] = new bullet(0,0,character);
    }
    switch(character) {
      case 0:
      playerHeightUp = 100;
      playerHeightDown = 68;
      playerWidth = 44;
      break;
      case 1:
      playerHeightUp = 92;
      playerHeightDown = 68;
      playerWidth = 68;
      break;
      case 2:
      playerHeightUp = 50;
      playerHeightDown = 44;
      playerWidth = 60;
      break;
    }
  }
  
  public void showhealth1()
  {
    if (health == 10)
    {
      p1health.p1full();
    }
    if (health == 9)
    {
      p1health.p190();
    }
    if (health == 8)
    {
      p1health.p180();
    }
    if (health == 7)
    {
      p1health.p170();
    }
    if (health == 6)
    {
      p1health.p160();
    }
    if (health == 5)
    {
      p1health.p150();
    }
    if (health == 4)
    {
      p1health.p140();
    }
    if (health == 3)
    {
      p1health.p130();
    }
    if (health == 2)
    {
      p1health.p120();
    }
    if (health == 1)
    {
      p1health.p110();
    }
    if (health <= 0)
    {
      p1health.p1dead();
      win2 = true;
    }
  }
  
  public void showhealth2()
  {
    if (health == 10)
    {
      p2health.p2full();
    }
    if (health == 9)
    {
      p2health.p290();
    }
    if (health == 8)
    {
      p2health.p280();
    }
    if (health == 7)
    { 
      p2health.p270();
    }
    if (health == 6)
    {
      p2health.p260();
    }
    if (health == 5)
    {
      p2health.p250();
    }
    if (health == 4)
    {
      p2health.p240();
    }
    if (health == 3)
    {
      p2health.p230();
    }
    if (health == 2)
    {
      p2health.p220();
    }
    if (health == 1)
    {
      p2health.p210();
    }
    if (health == 0)
    {
      p2health.p2dead();
      win1 = true;
    }
  }
  public void shoot() {
    bulletCount = -1;
    for (int i = 0; i < bullets.length; i++) {
      if (!bullets[i].active) bulletCount = i;
    }
    if (bulletCount != -1) {
      bullets[bulletCount].active = true;
      bullets[bulletCount].x = x;
      
      bullets[bulletCount].y = y-playerHeightUp/2;
      if (xVel==0) bullets[bulletCount].xVel = -abs(bullets[bulletCount].xVel);
      else bullets[bulletCount].xVel = abs(bullets[bulletCount].xVel)*xVel/abs(xVel);
    }
  }
  public void getHit(player p) {
    for (int i = 0; i<p.bullets.length; i++) {
      if (p.bullets[i].active && abs(x-p.bullets[i].x) < playerWidth+p.bullets[i].xWidth && y-playerHeightUp < p.bullets[i].y+p.bullets[i].yWidth && y+playerHeightDown > p.bullets[i].y-p.bullets[i].yWidth) {
        health--;
        p.bullets[i].active = false;
      }
    }
  }
 public void make() {
    if (character == 0) {
      if (yVel > 0) {
        if (xVel > 0) {
          drawCampbellFallingRight(x, y, size);
        } else { 
          drawCampbellFallingLeft(x, y, size);
        }
      } else {
        if (xVel > 0) {
          drawCampbellRight(x, y, size);
        } else {
          drawCampbellLeft(x, y, size);
        }
      }
      noFill();
      noStroke();
      rect(x, y-2*size, 11*size, 21*size);
      stroke(255, 0, 0);
      point(x-playerWidth, y-playerHeightUp);
    }
    if (character == 1) {
      if (yVel>0) {
        drawKarelFallingNeutral(x, y, size);
      } else {
        drawKarelNeutral(x, y, size);
      }
      noFill();
      noStroke();
      rect(x,y-1.5*size,17*size,20*size);
    }
    if (character == 2) {
      if (xVel < 0) {
        drawDogeRight(x, y, size);
      } else {
        drawDogeLeft(x, y, size);
      }
      noFill();
      noStroke();
      rect(x, y-size/2, 15*size, 12*size);
    }
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].make();
    }
  }
  public void move() {
    fakeX+=xVel;
    fakeY+=yVel;
    x = ceil(fakeX);
    y = ceil(fakeY);
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].move();
    }
    if (fakeY > height + playerHeightUp) {
      health--;
    }
  }
  private void accelerateLeft( ) {
    xVel -= 0.2;
  }
  private void accelerateRight() {
    xVel += 0.2;
  }
  private void friction() {
    xVel *= 0.97;
  }
  public void gravitate() {
    if (!grounded) {
      yVel += 0.2;
    }
  }
  public void jump() {
    if (canJump) {
      yVel -= 10;
      canJump = false;
    }
  }
public void collide() {
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].collide();
    }
    for (int i = 0; i < hitboxes.length; i++) {
      //up
      if (y+playerHeightDown+yVel>hitboxes[i].y-hitboxes[i].yWidth&&y+playerHeightDown<=hitboxes[i].y-hitboxes[i].yWidth) {
        if (abs(x-hitboxes[i].x)<abs(playerWidth+hitboxes[i].xWidth)) {
          yVel = 0;
          fakeY = hitboxes[i].y-hitboxes[i].yWidth-playerHeightDown;
          canJump = true;
        }
      }
      if (fakeY == hitboxes[i].y-hitboxes[i].yWidth-playerHeightDown && abs(x-hitboxes[i].x) < abs(playerWidth+hitboxes[i].xWidth)) {
        grounded = true;
      } else {
        grounded = false;
      }
      //right
      if (x-playerWidth+xVel < hitboxes[i].x+hitboxes[i].xWidth && x-playerWidth >= hitboxes[i].x + hitboxes[i].xWidth) {
        if (y-playerHeightUp < hitboxes[i].y+hitboxes[i].yWidth && y+playerHeightDown > hitboxes[i].y-hitboxes[i].yWidth) {
          xVel = 0;
          fakeX = hitboxes[i].x + hitboxes[i].xWidth + playerWidth;
        }
      }
      //left
      if (x+playerWidth+xVel > hitboxes[i].x-hitboxes[i].xWidth && x+playerWidth <= hitboxes[i].x-hitboxes[i].xWidth) {
        if (y-playerHeightUp < hitboxes[i].y+hitboxes[i].yWidth && y+playerHeightDown > hitboxes[i].y-hitboxes[i].yWidth) {
          xVel = 0;
          fakeX = hitboxes[i].x - hitboxes[i].xWidth - playerWidth;
        }
      }
    }
  }
}

public class hitbox {
  public int x;
  public int y;
  public int xWidth;
  public int yWidth;
  public hitbox(int xC, int yC, int xWidthC, int yWidthC) {
    x = xC;
    y = yC;
    xWidth = xWidthC;
    yWidth = yWidthC;
  }
  public void make() {
    noStroke();
    rectMode(CENTER);
    rect(x, y, 2*xWidth, 2*yWidth);
  }
}

public class bullet {
  private float x;
  private float y;
  private float s = 5;
  private boolean active=false;
  private int character;//0=Campbell,1=Karel,2=Doge
  private float xVel=width/120;
  private float xWidth=6;
  private float yWidth=3;
  public bullet(float xC, float yC, int characterC) {
    x=xC;
    y=yC;
    character=characterC;
  }
  
  // moves character
  public void move() {
    x+=xVel;
  }
  
  // character interaction with hitboxes
  public void collide() {
    if (x > width + 10 || x < -10) active = false;
    for (int i = 0; i<hitboxes.length; i++) {
      if (active && abs(x-hitboxes[i].x) < xWidth*s/2+hitboxes[i].xWidth && abs(y-hitboxes[i].y) < yWidth*s/2 + hitboxes[i].yWidth) {
        active = false;
      }
    }
  }
  
  public void make() {
    if (character == 0) {
      fill(100, 200, 100);
    }
    if (character == 1) {
      fill(0);
    }
    if (character == 2) {
      fill(250,200,40);
    }
    rectMode(CENTER);
    noStroke();
    if (active) {
      rect(x, y, xWidth*s, yWidth*s);
    }
  }
}

public void drawDogeLeft(int x, int y, int s) {
  rectMode(CENTER);
    noStroke();
    noFill();
    //6 above
    fill(83,56,70);
    rect(x - 3*s, y - 6*s, s, s);
    rect(x - 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    
    //5 above
    fill(83,56,70);
    rect(x - 4*s, y - 5*s, s, s);
    fill(255,224,175);
    rect(x - 3*s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    fill(83,56,70);
    rect(x - s, y - 5*s, s, s);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    rect(x + 2*s, y - 5*s, s, s);
    fill(255,224,175);
    rect(x + 3*s, y - 5*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 5*s, s, s);
    
    //4 above
    fill(83,56,70);
    rect(x - 4*s, y - 4*s, s, s);
    fill(255,224,175);
    rect(x - 3*s, y - 4*s, s, s);
    fill(249,194,65);
    rect(x - 2*s, y - 4*s, s, s);
    rect(x - s, y - 4*s, s, s);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    rect(x + 2*s, y - 4*s, s, s);
    rect(x + 3*s, y - 4*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 4*s, s, s);
    
    //3 above
    fill(83,56,70);
    rect(x - 4*s, y - 3*s, s, s);
    fill(255,224,175);
    rect(x - 3*s, y - 3*s, s, s);
    fill(249,194,65);
    rect(x - 2*s, y - 3*s, s, s);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    rect(x + 2*s, y - 3*s, s, s);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x + 4*s, y - 3*s, s, s);
    fill(83,56,70);
    rect(x + 5*s, y - 3*s, s, s);
    
    //2 above
    fill(83,56,70);
    rect(x - 4*s, y - 2*s, s, s);
    fill(249,194,65);
    rect(x - 3*s, y - 2*s, s, s);
    rect(x - 2*s, y - 2*s, s, s);
    rect(x - s, y - 2*s, s, s);
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 2*s, s, s);
    fill(235,252,221);
    rect(x + 5*s, y - 2*s, s, s);
    fill(83,56,70);
    rect(x + 6*s, y - 2*s, s, s);
    
    //1 above
    fill(83,56,70);
    rect(x - 8*s, y - s, s, s);
    rect(x - 5*s, y - s, s, s);
    fill(249,194,65);
    rect(x - 4*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    rect(x - 2*s, y - s, s, s);
    rect(x - s, y - s, s, s);
    rect(x, y - s, s, s);
    fill(83,56,70);
    rect(x + s, y - s, s, s);
    fill(235,252,221);
    rect(x + 2*s, y - s, s, s);
    fill(249,194,65);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    fill(83,56,70);
    rect(x + 6*s, y - s, s, s);
    
    //center row
    fill(83,56,70);
    rect(x - 9*s, y, s, s);
    fill(255,224,175);
    rect(x - 8*s, y, s, s);
    fill(83,56,70);
    rect(x - 7*s, y, s, s);
    rect(x - 5*s, y, s, s);
    fill(249,194,65);
    rect(x - 4*s, y, s, s);
    rect(x - 3*s, y, s, s);
    fill(223,214,171);
    rect(x - 2*s, y, s, s);
    rect(x - s, y, s, s);
    rect(x, y, s, s);
    fill(249,194,65);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    fill(83,56,70);
    rect(x + 4*s, y, s, s);
    rect(x + 5*s, y, s, s);
    fill(223,214,171);
    rect(x + 6*s, y, s, s);
    fill(83,56,70);
    rect(x + 7*s, y, s, s);
    
    //1 below
    rect(x - 9*s, y + s, s, s);
    fill(255,224,175);
    rect(x - 8*s, y + s, s, s);
    rect(x - 7*s, y + s, s, s);
    fill(83,56,70);
    rect(x - 6*s, y + s, s, s);
    fill(249,194,65);
    rect(x - 5*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    fill(223,214,171);
    rect(x - 2*s, y + s, s, s);
    rect(x - s, y + s, s, s);
    rect(x, y + s, s, s);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    fill(83,56,70);
    rect(x + 5*s, y + s, s, s);
    fill(223,214,171);
    rect(x + 6*s, y + s, s, s);
    fill(83,56,70);
    rect(x + 7*s, y + s, s, s);
    
    //2 below
    rect(x - 9*s, y + 2*s, s, s);
    fill(249,194,65);
    rect(x - 8*s, y + 2*s, s, s);
    fill(255,224,175);
    rect(x - 7*s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x - 6*s, y + 2*s, s, s);
    fill(183,120,39);
    rect(x - 5*s, y + 2*s, s, s);
    fill(249,194,65);
    rect(x - 4*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    fill(130,124,96);
    rect(x - 2*s, y + 2*s, s, s);
    fill(223,214,171);
    rect(x - s, y + 2*s, s, s);
    rect(x, y + 2*s, s, s);
    rect(x + s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    fill(223,214,171);
    rect(x + 5*s, y + 2*s, s, s);
    rect(x + 6*s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x + 7*s, y + 2*s, s, s);
    
    //3 below
    rect(x - 8*s, y + 3*s, s, s);
    fill(249,194,65);
    rect(x - 7*s, y + 3*s, s, s);
    rect(x - 6*s, y + 3*s, s, s);
    fill(83,56,70);
    rect(x - 5*s, y + 3*s, s, s);
    fill(183,120,39);
    rect(x - 4*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    rect(x - 2*s, y + 3*s, s, s);
    fill(130,124,96);
    rect(x - s, y + 3*s, s, s);
    fill(223,214,171);
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    rect(x + 2*s, y + 3*s, s, s);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    rect(x + 5*s, y + 3*s, s, s);
    fill(130,124,96);
    rect(x + 6*s, y + 3*s, s, s);
    fill(83,56,70);
    rect(x + 7*s, y + 3*s, s, s);
    
    //4 below
    rect(x - 7*s, y + 4*s, s, s);
    rect(x - 6*s, y + 4*s, s, s);
    rect(x - 5*s, y + 4*s, s, s);
    rect(x - 4*s, y + 4*s, s, s);
    fill(183,120,39);
    rect(x - 3*s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    fill(130,124,96);
    rect(x - s, y + 4*s, s, s);
    rect(x, y + 4*s, s, s);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x + 4*s, y + 4*s, s, s);
    rect(x + 5*s, y + 4*s, s, s);
    fill(83,56,70);
    rect(x + 6*s, y + 4*s, s, s);
    
    //5 below
    rect(x - 4*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    rect(x, y + 5*s, s, s);
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
    rect(x + 5*s, y + 5*s, s, s);
}

public void drawDogeRight(int x, int y, int s) {
  rectMode(CENTER);
    noStroke();
    //6 above
    fill(83,56,70);
    rect(x - 3*s, y - 6*s, s, s);
    rect(x + 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    
    //5 above
    rect(x - 4*s, y - 5*s, s, s);
    fill(255,224,175);
    rect(x - 3*s, y - 5*s, s, s);
    fill(83,56,70);
    rect(x - 2*s, y - 5*s, s, s);
    rect(x - s, y - 5*s, s, s);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    fill(255,224,175);
    rect(x + 2*s, y - 5*s, s, s);
    rect(x + 3*s, y - 5*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 5*s, s, s);
    
    //4 above
    rect(x - 4*s, y - 4*s, s, s);
    fill(249,194,65);
    rect(x - 3*s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    rect(x - s, y - 4*s, s, s);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    rect(x + 2*s, y - 4*s, s, s);
    fill(255,224,175);
    rect(x + 3*s, y - 4*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 4*s, s, s);
    
    //3 above
    rect(x - 5*s, y - 3*s, s, s);
    fill(249,194,65);
    rect(x - 4*s, y - 3*s, s, s);
    rect(x - 3*s, y - 3*s, s, s);
    rect(x - 2*s, y - 3*s, s, s);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    rect(x + 2*s, y - 3*s, s, s);
    fill(255,224,175);
    rect(x + 3*s, y - 3*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 3*s, s, s);
    
    //2 above
    rect(x - 6*s, y - 2*s, s, s);
    fill(235,252,221);
    rect(x - 5*s, y - 2*s, s, s);
    fill(83,56,70);
    rect(x - 4*s, y - 2*s, s, s);
    fill(249,194,65);
    rect(x - 3*s, y - 2*s, s, s);
    rect(x - 2*s, y - 2*s, s, s);
    rect(x - s, y - 2*s, s, s);
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y - 2*s, s, s);
    
    //1 above
    rect(x - 6*s, y - s, s, s);
    fill(249,194,65);
    rect(x - 5*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    fill(235,252,221);
    rect(x - 2*s, y - s, s, s);
    fill(83,56,70);
    rect(x - s, y - s, s, s);
    fill(249,194,65);
    rect(x, y - s, s, s);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    fill(83,56,70);
    rect(x + 5*s, y - s, s, s);
    rect(x + 8*s, y - s, s, s);
    
    //center row
    rect(x - 7*s, y, s, s);
    fill(223,214,171);
    rect(x - 6*s, y, s, s);
    fill(83,56,70);
    rect(x - 5*s, y, s, s);
    rect(x - 4*s, y, s, s);
    fill(249,194,65);
    rect(x - 3*s, y, s, s);
    rect(x - 2*s, y, s, s);
    rect(x - s, y, s, s);
    fill(223,214,171);
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    fill(249,194,65);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    fill(83,56,70);
    rect(x + 5*s, y, s, s);
    rect(x + 7*s, y, s, s);
    fill(255,224,175);
    rect(x + 8*s, y, s, s);
    fill(83,56,70);
    rect(x + 9*s, y, s, s);
    
    //1 below
    rect(x - 7*s, y + s, s, s);
    fill(223,214,171);
    rect(x - 6*s, y + s, s, s);
    fill(83,56,70);
    rect(x - 5*s, y + s, s, s);
    fill(223,214,171);
    rect(x - 4*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    rect(x - 2*s, y + s, s, s);
    rect(x - s, y + s, s, s);
    rect(x, y + s, s, s);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    fill(249,194,65);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x + 5*s, y + s, s, s);
    fill(83,56,70);
    rect(x + 6*s, y + s, s, s);
    fill(255,224,175);
    rect(x + 7*s, y + s, s, s);
    rect(x + 8*s, y + s, s, s);
    fill(83,56,70);
    rect(x + 9*s, y + s, s, s);
    
    //2 below
    rect(x - 7*s, y + 2*s, s, s);
    fill(223,214,171);
    rect(x - 6*s, y + 2*s, s, s);
    rect(x - 5*s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x - 4*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    rect(x - 2*s, y + 2*s, s, s);
    fill(223,214,171);
    rect(x - s, y + 2*s, s, s);
    rect(x, y + 2*s, s, s);
    rect(x + s, y + 2*s, s, s);
    fill(130,124,96);
    rect(x + 2*s, y + 2*s, s, s);
    fill(249,194,65);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    fill(183,120,39);
    rect(x + 5*s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x + 6*s, y + 2*s, s, s);
    fill(255,224,175);
    rect(x + 7*s, y + 2*s, s, s);
    fill(249,194,65);
    rect(x + 8*s, y + 2*s, s, s);
    fill(83,56,70);
    rect(x + 9*s, y + 2*s, s, s);
    
    //3 below
    rect(x - 7*s, y + 3*s, s, s);
    fill(130,124,96);
    rect(x - 6*s, y + 3*s, s, s);
    fill(223,214,171);
    rect(x - 5*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    rect(x - 2*s, y + 3*s, s, s);
    rect(x - s, y + 3*s, s, s);
    rect(x, y + 3*s, s, s);
    fill(130,124,96);
    rect(x + s, y + 3*s, s, s);
    fill(183,120,39);
    rect(x + 2*s, y + 3*s, s, s);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    fill(83,56,70);
    rect(x + 5*s, y + 3*s, s, s);
    fill(249,194,65);
    rect(x + 6*s, y + 3*s, s, s);
    rect(x + 7*s, y + 3*s, s, s);
    fill(83,56,70);
    rect(x + 8*s, y + 3*s, s, s);
    
    //4 below
    rect(x - 6*s, y + 4*s, s, s);
    fill(130,124,96);
    rect(x - 5*s, y + 4*s, s, s);
    rect(x - 4*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x, y + 4*s, s, s);
    rect(x + s, y + 4*s, s, s);
    fill(183,120,39);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    fill(83,56,70);
    rect(x + 4*s, y + 4*s, s, s);
    rect(x + 5*s, y + 4*s, s, s);
    rect(x + 6*s, y + 4*s, s, s);
    rect(x + 7*s, y + 4*s, s, s);
    
    //5 below
    rect(x - 5*s, y + 5*s, s, s);
    rect(x - 4*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    rect(x, y + 5*s, s, s);
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
}
public void drawCampbellFallingLeft(int x, int y, int s) {
  rectMode(CENTER);
    noStroke();
    //12 above
    fill(68, 59, 59);
    rect(x, y - 12*s, s, s);
    rect(x + s, y - 12*s, s, s);
    rect(x - s, y - 12*s, s, s);
    rect(x - 2*s, y - 12*s, s, s);
    rect(x - 3*s, y - 12*s, s, s);
    rect(x - 4*s, y - 12*s, s, s);
    //11 above
    rect(x, y - 11*s, s, s);
    rect(x + s, y - 11*s, s, s);
    rect(x + 2*s, y - 11*s, s, s);
    rect(x + 3*s, y - 11*s, s, s);
    rect(x - s, y - 11*s, s, s);
    rect(x - 2*s, y - 11*s, s, s);
    rect(x - 3*s, y - 11*s, s, s);
    rect(x - 4*s, y - 11*s, s, s);
    rect(x - 5*s, y - 11*s, s, s);
    //10 above
    rect(x, y - 10*s, s, s);
    rect(x + s, y - 10*s, s, s);
    rect(x + 2*s, y - 10*s, s, s);
    rect(x + 3*s, y - 10*s, s, s);
    rect(x + 4*s, y - 10*s, s, s);
    rect(x - s, y - 10*s, s, s);
    rect(x - 2*s, y - 10*s, s, s);
    rect(x - 3*s, y - 10*s, s, s);
    rect(x - 4*s, y - 10*s, s, s);
    rect(x - 5*s, y - 10*s, s, s);
    //9 above
    fill(232,183,141);
    rect(x, y - 9*s, s, s);
    rect(x + s, y - 9*s, s, s);
    rect(x + 2*s, y - 9*s, s, s);
    fill(68, 59, 59);
    rect(x + 3*s, y - 9*s, s, s);
    rect(x + 4*s, y - 9*s, s, s);
    fill(232,183,141);
    rect(x - s, y - 9*s, s, s);
    rect(x - 2*s, y - 9*s, s, s);
    rect(x - 3*s, y - 9*s, s, s);
    rect(x - 4*s, y - 9*s, s, s);
    fill(68, 59, 59);
    rect(x - 5*s, y - 9*s, s, s);
    //8 above
    fill(255);
    rect(x, y - 8*s, s, s);
    rect(x + s, y - 8*s, s, s);
    fill(232,183,141);
    rect(x + 2*s, y - 8*s, s, s);
    rect(x + 3*s, y - 8*s, s, s);
    fill(68, 59, 59);
    rect(x + 4*s, y - 8*s, s, s);
    fill(0);
    rect(x + 5*s, y - 8*s, s, s);
    rect(x + 6*s, y - 8*s, s, s);
    fill(255);
    rect(x - s, y - 8*s, s, s);
    rect(x - 2*s, y - 8*s, s, s);
    fill(232,183,141);
    rect(x - 3*s, y - 8*s, s, s);
    fill(255);
    rect(x - 4*s, y - 8*s, s, s);
    rect(x - 5*s, y - 8*s, s, s);
    //7 above
    fill(255);
    rect(x, y - 7*s, s, s);
    rect(x + s, y - 7*s, s, s);
    rect(x + 2*s, y - 7*s, s, s);
    rect(x + 3*s, y - 7*s, s, s);
    fill(68, 59, 59);
    rect(x + 4*s, y - 7*s, s, s);
    fill(0);
    rect(x + 5*s, y - 7*s, s, s);
    rect(x + 6*s, y - 7*s, s, s);
    rect(x + 7*s, y - 7*s, s, s);
    fill(0);
    rect(x - s, y - 7*s, s, s);
    rect(x - 2*s, y - 7*s, s, s);
    fill(255);
    rect(x - 3*s, y - 7*s, s, s);
    fill(0);
    rect(x - 4*s, y - 7*s, s, s);
    fill(255);
    rect(x - 5*s, y - 7*s, s, s);
     //6 above
    fill(255);
    rect(x, y - 6*s, s, s);
    rect(x + s, y - 6*s, s, s);
    fill(232,183,141);
    rect(x + 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    fill(0);
    rect(x + 4*s, y - 6*s, s, s);
    rect(x + 5*s, y - 6*s, s, s);
    rect(x + 6*s, y - 6*s, s, s);
    rect(x + 7*s, y - 6*s, s, s);
    fill(0);
    rect(x - s, y - 6*s, s, s);
    rect(x - 2*s, y - 6*s, s, s);
    fill(255);
    rect(x - 3*s, y - 6*s, s, s);
    fill(0);
    rect(x - 4*s, y - 6*s, s, s);
    fill(255);
    rect(x - 5*s, y - 6*s, s, s);
    //5 above
    fill(255);
    rect(x, y - 5*s, s, s);
    fill(232,183,141);
    rect(x + s, y - 5*s, s, s);
    rect(x + 2*s, y - 5*s, s, s);
    rect(x + 3*s, y - 5*s, s, s);
    fill(0);
    rect(x + 4*s, y - 5*s, s, s);
    rect(x + 5*s, y - 5*s, s, s);
    rect(x + 6*s, y - 5*s, s, s);
    rect(x + 7*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x + 8*s, y - 5*s, s, s);
    fill(255);
    rect(x - s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x - 3*s, y - 5*s, s, s);
    fill(255);
    rect(x - 4*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x - 5*s, y - 5*s, s, s);
    rect(x - 8*s, y - 5*s, s, s);
    
    //4 above
    fill(0);
    rect(x, y - 4*s, s, s);
    fill(232,183,141);
    rect(x + s, y - 4*s, s, s);
    rect(x + 2*s, y - 4*s, s, s);
    fill(0);
    rect(x + 3*s, y - 4*s, s, s);
    rect(x + 4*s, y - 4*s, s, s);
    rect(x + 5*s, y - 4*s, s, s);
    rect(x + 6*s, y - 4*s, s, s);
    rect(x + 8*s, y - 4*s, s, s);
    fill(0);
    rect(x - s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    rect(x - 3*s, y - 4*s, s, s);
    fill(232,183,141);
    rect(x - 4*s, y - 4*s, s, s);
    fill(0);
    rect(x - 5*s, y - 4*s, s, s);
    rect(x - 8*s, y - 4*s, s, s);
    //3 above
    fill(0);
    rect(x - 7*s, y - 3*s, s, s);
    rect(x - 4*s, y - 3*s, s, s);
    fill(232,183,141);
    rect(x - 3*s, y - 3*s, s, s);
    rect(x - 2*s, y - 3*s, s, s);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    fill(0);
    rect(x + 2*s, y - 3*s, s, s);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x + 4*s, y - 3*s, s, s);
    rect(x + 7*s, y - 3*s, s, s);
    
    //2 above
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    rect(x + 4*s, y - 2*s, s, s);
    rect(x + 6*s, y - 2*s, s, s);
    rect(x - s, y - 2*s, s, s);
    rect(x - 2*s, y - 2*s, s, s);
    rect(x - 3*s, y - 2*s, s, s);
    rect(x - 4*s, y - 2*s, s, s);
    rect(x - 6*s, y - 2*s, s, s);
    
    //1 above
    rect(x, y - s, s, s);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    rect(x - s, y - s, s, s);
    rect(x - 2*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 5*s, y - s, s, s);
    //center row
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    rect(x - s, y, s, s);
    rect(x - 2*s, y, s, s);
    rect(x - 3*s, y, s, s);
    rect(x - 4*s, y, s, s);
    //1 below
    rect(x, y + s, s, s);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x - s, y + s, s, s);
    rect(x - 2*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    //2 below
    rect(x, y + 2*s, s, s);
    rect(x + s, y + 2*s, s, s);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    rect(x - s, y + 2*s, s, s);
    rect(x - 2*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    rect(x - 4*s, y + 2*s, s, s);
    
    //3 below
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    rect(x + 2*s, y + 3*s, s, s);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    fill(0);
    rect(x - s, y + 3*s, s, s);
    rect(x - 2*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    //4 below
    fill(36,37,134);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    //5 below
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 4*s, y + 5*s, s, s);
    //6 below
    rect(x, y + 6*s, s, s);
    rect(x + s, y + 6*s, s, s);
    rect(x + 2*s, y + 6*s, s, s);
    rect(x - 2*s, y + 6*s, s, s);
    rect(x - 3*s, y + 6*s, s, s);
    rect(x - 4*s, y + 6*s, s, s);
    //7 below
    rect(x, y + 7*s, s, s);
    rect(x + s, y + 7*s, s, s);
    rect(x + 2*s, y + 7*s, s, s);
    rect(x - 3*s, y + 7*s, s, s);
    rect(x - 4*s, y + 7*s, s, s);
    rect(x - 5*s, y + 7*s, s, s);
    //8 below
    fill(0);
    rect(x - 3*s, y + 8*s, s, s);
    rect(x - 4*s, y + 8*s, s, s);
    rect(x - 5*s, y + 8*s, s, s);
    rect(x - 6*s, y + 8*s, s, s);
    fill(36,37,134);
    rect(x - s, y + 8*s, s, s);
    rect(x, y + 8*s, s, s);
    rect(x + s, y + 8*s, s, s);
    //9 below
    fill(0);
    rect(x - 2*s, y + 9*s, s, s);
    rect(x - s, y + 9*s, s, s);
    rect(x, y + 9*s, s, s);
    rect(x + s, y + 9*s, s, s);
}
public void drawCampbellFallingRight(int x, int y, int s) {
  rectMode(CENTER);
    noStroke();
    //12 above
    fill(68, 59, 59);
    rect(x, y - 12*s, s, s);
    rect(x + s, y - 12*s, s, s);
    rect(x + 2*s, y - 12*s, s, s);
    rect(x + 3*s, y - 12*s, s, s);
    rect(x + 4*s, y - 12*s, s, s);
    rect(x - s, y - 12*s, s, s);
    //11 above
    rect(x, y - 11*s, s, s);
    rect(x + s, y - 11*s, s, s);
    rect(x + 2*s, y - 11*s, s, s);
    rect(x + 3*s, y - 11*s, s, s);
    rect(x + 4*s, y - 11*s, s, s);
    rect(x + 5*s, y - 11*s, s, s);
    rect(x - s, y - 11*s, s, s);
    rect(x - 2*s, y - 11*s, s, s);
    rect(x - 3*s, y - 11*s, s, s);
    //10 above
    rect(x, y - 10*s, s, s);
    rect(x + s, y - 10*s, s, s);
    rect(x + 2*s, y - 10*s, s, s);
    rect(x + 3*s, y - 10*s, s, s);
    rect(x + 4*s, y - 10*s, s, s);
    rect(x + 5*s, y - 10*s, s, s);
    rect(x - s, y - 10*s, s, s);
    rect(x - 2*s, y - 10*s, s, s);
    rect(x - 3*s, y - 10*s, s, s);
    rect(x - 4*s, y - 10*s, s, s);
    //9 above
    fill(232,183,141);
    rect(x, y - 9*s, s, s);
    rect(x + s, y - 9*s, s, s);
    rect(x + 2*s, y - 9*s, s, s);
    rect(x + 3*s, y - 9*s, s, s);
    rect(x + 4*s, y - 9*s, s, s);
    rect(x - s, y - 9*s, s, s);
    rect(x - 2*s, y - 9*s, s, s);
    fill(68, 59, 59);
    rect(x - 3*s, y - 9*s, s, s);
    rect(x - 4*s, y - 9*s, s, s);
    rect(x + 5*s, y - 9*s, s, s);
    //8 above
    fill(255);
    rect(x, y - 8*s, s, s);
    rect(x + s, y - 8*s, s, s);
    rect(x + 2*s, y - 8*s, s, s);
    fill(232,183,141);
    rect(x + 3*s, y - 8*s, s, s);
    fill(255);
    rect(x + 4*s, y - 8*s, s, s);
    rect(x + 5*s, y - 8*s, s, s);
    fill(255);
    rect(x - s, y - 8*s, s, s);
    fill(232,183,141);
    rect(x - 2*s, y - 8*s, s, s);
    rect(x - 3*s, y - 8*s, s, s);
    fill(68, 59, 59);
    rect(x - 4*s, y - 8*s, s, s);
    fill(0);
    rect(x - 5*s, y - 8*s, s, s);
    rect(x - 6*s, y - 8*s, s, s);
    //7 above
    fill(255);
    rect(x, y - 7*s, s, s);
    fill(0);
    rect(x + s, y - 7*s, s, s);
    rect(x + 2*s, y - 7*s, s, s);
    fill(255);
    rect(x + 3*s, y - 7*s, s, s);
    fill(0);
    rect(x + 4*s, y - 7*s, s, s);
    fill(255);
    rect(x + 5*s, y - 7*s, s, s);
    fill(255);
    rect(x - s, y - 7*s, s, s);
    rect(x - 2*s, y - 7*s, s, s);
    rect(x - 3*s, y - 7*s, s, s);
    fill(68, 59, 59);
    rect(x - 4*s, y - 7*s, s, s);
    fill(0);
    rect(x - 5*s, y - 7*s, s, s);
    rect(x - 6*s, y - 7*s, s, s);
    rect(x - 7*s, y - 7*s, s, s);
     //6 above
    fill(255);
    rect(x, y - 6*s, s, s);
    fill(0);
    rect(x + s, y - 6*s, s, s);
    rect(x + 2*s, y - 6*s, s, s);
    fill(255);
    rect(x + 3*s, y - 6*s, s, s);
    fill(0);
    rect(x + 4*s, y - 6*s, s, s);
    fill(255);
    rect(x + 5*s, y - 6*s, s, s);
    fill(255);
    rect(x - s, y - 6*s, s, s);
    fill(232,183,141);
    rect(x - 2*s, y - 6*s, s, s);
    rect(x - 3*s, y - 6*s, s, s);
    fill(0);
    rect(x - 4*s, y - 6*s, s, s);
    rect(x - 5*s, y - 6*s, s, s);
    rect(x - 6*s, y - 6*s, s, s);
    rect(x - 7*s, y - 6*s, s, s);
    //5 above
    fill(255);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    rect(x + 2*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x + 3*s, y - 5*s, s, s);
    fill(255);
    rect(x + 4*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x + 5*s, y - 5*s, s, s);
    rect(x + 8*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x - s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    rect(x - 3*s, y - 5*s, s, s);
    fill(0);
    rect(x - 4*s, y - 5*s, s, s);
    rect(x - 5*s, y - 5*s, s, s);
    rect(x - 6*s, y - 5*s, s, s);
    rect(x - 7*s, y - 5*s, s, s);
    fill(232,183,141);
    rect(x - 8*s, y - 5*s, s, s);
    //4 above
    fill(0);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    rect(x + 2*s, y - 4*s, s, s);
    rect(x + 3*s, y - 4*s, s, s);
    fill(232,183,141);
    rect(x + 4*s, y - 4*s, s, s);
    fill(0);
    rect(x + 5*s, y - 4*s, s, s);
    rect(x + 8*s, y - 4*s, s, s);
    fill(232,183,141);
    rect(x - s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    fill(0);
    rect(x - 3*s, y - 4*s, s, s);
    rect(x - 4*s, y - 4*s, s, s);
    rect(x - 5*s, y - 4*s, s, s);
    rect(x - 6*s, y - 4*s, s, s);
    rect(x - 8*s, y - 4*s, s, s);
    //3 above
    fill(232,183,141);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    rect(x + 2*s, y - 3*s, s, s);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x - s, y - 3*s, s, s);
    fill(0);
    rect(x + 4*s, y - 3*s, s, s);
    rect(x + 7*s, y - 3*s, s, s);
    fill(0);
    rect(x - 2*s, y - 3*s, s, s);
    rect(x - 3*s, y - 3*s, s, s);
    rect(x - 4*s, y - 3*s, s, s);
    rect(x - 7*s, y - 3*s, s, s);
    //2 above
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    rect(x + 4*s, y - 2*s, s, s);
    rect(x + 6*s, y - 2*s, s, s);
    rect(x - s, y - 2*s, s, s);
    rect(x - 2*s, y - 2*s, s, s);
    rect(x - 3*s, y - 2*s, s, s);
    rect(x - 4*s, y - 2*s, s, s);
    rect(x - 6*s, y - 2*s, s, s);
    //1 above
    rect(x, y - s, s, s);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    rect(x - s, y - s, s, s);
    rect(x - 2*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 5*s, y - s, s, s);
    //center row
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    rect(x - s, y, s, s);
    rect(x - 2*s, y, s, s);
    rect(x - 3*s, y, s, s);
    rect(x - 4*s, y, s, s);
    //1 below
    rect(x, y + s, s, s);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x - s, y + s, s, s);
    rect(x - 2*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    //2 below
    rect(x, y + 2*s, s, s);
    rect(x + s, y + 2*s, s, s);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    rect(x - s, y + 2*s, s, s);
    rect(x - 2*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    rect(x - 4*s, y + 2*s, s, s);
    //3 below
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    rect(x + 2*s, y + 3*s, s, s);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    fill(0);
    rect(x - s, y + 3*s, s, s);
    rect(x - 2*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    //4 below
    fill(36,37,134);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    
    //5 below
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
    
    //6 below
    rect(x - 2*s, y + 6*s, s, s);
    rect(x - s, y + 6*s, s, s);
    rect(x, y + 6*s, s, s);
    
    rect(x + 2*s, y + 6*s, s, s);
    rect(x + 3*s, y + 6*s, s, s);
    rect(x + 4*s, y + 6*s, s, s);
    
    //7 below
    rect(x - 2*s, y + 7*s, s, s);
    rect(x - s, y + 7*s, s, s);
    rect(x, y + 7*s, s, s);
    
    rect(x + 3*s, y + 7*s, s, s);
    rect(x + 4*s, y + 7*s, s, s);
    rect(x + 5*s, y + 7*s, s, s);
    
    //8 below
    rect(x - s, y + 8*s, s, s);
    rect(x, y + 8*s, s, s);
    rect(x + s, y + 8*s, s, s);
    fill(0);
    rect(x + 3*s, y + 8*s, s, s);
    rect(x + 4*s, y + 8*s, s, s);
    rect(x + 5*s, y + 8*s, s, s);
    rect(x + 6*s, y + 8*s, s, s);
    
    //9 below
    rect(x - s, y + 9*s, s, s);
    rect(x, y + 9*s, s, s);
    rect(x + s, y + 9*s, s, s);
    rect(x + 2*s, y + 9*s, s, s);
}

public void drawKarelFallingAttack(int x, int y, int s) {
  noStroke();
    //11 above
    fill(0);
    rect(x - 4*s, y - 11*s, s, s);
    rect(x - 3*s, y - 11*s, s, s);
    rect(x - 2*s, y - 11*s, s, s);
    rect(x - s, y - 11*s, s, s);
    rect(x, y - 11*s, s, s);
    rect(x + s, y - 11*s, s, s);
    rect(x + 2*s, y - 11*s, s, s);
    rect(x + 3*s, y - 11*s, s, s);
    rect(x + 4*s, y - 11*s, s, s);
    
    //10 above
    fill(0);
    rect(x - 5*s, y - 10*s, s, s);
    fill(205,205,205);
    rect(x - 4*s, y - 10*s, s, s);
    rect(x - 3*s, y - 10*s, s, s);
    rect(x - 2*s, y - 10*s, s, s);
    rect(x - s, y - 10*s, s, s);
    rect(x, y - 10*s, s, s);
    rect(x + s, y - 10*s, s, s);
    rect(x + 2*s, y - 10*s, s, s);
    rect(x + 3*s, y - 10*s, s, s);
    rect(x + 4*s, y - 10*s, s, s);
    fill(0);
    rect(x + 5*s, y - 10*s, s, s);
    
    //9 above
    fill(0);
    rect(x - 6*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 9*s, s, s);
    rect(x - 4*s, y - 9*s, s, s);
    fill(0);
    rect(x - 3*s, y - 9*s, s, s);
    rect(x - 2*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 9*s, s, s);
    rect(x, y - 9*s, s, s);
    rect(x + s, y - 9*s, s, s);
    fill(0);
    rect(x + 2*s, y - 9*s, s, s);
    rect(x + 3*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 9*s, s, s);
    rect(x + 5*s, y - 9*s, s, s);
    fill(0);
    rect(x + 6*s, y - 9*s, s, s);
    
    //8 above
    fill(0);
    rect(x - 6*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 8*s, s, s);
    rect(x - 4*s, y - 8*s, s, s);
    fill(0);
    rect(x - 3*s, y - 8*s, s, s);
    fill(255, 0, 0);
    rect(x - 2*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 8*s, s, s);
    rect(x, y - 8*s, s, s);
    rect(x + s, y - 8*s, s, s);
    fill(0);
    rect(x + 2*s, y - 8*s, s, s);
    fill(255,0, 0);
    rect(x + 3*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 8*s, s, s);
    rect(x + 5*s, y - 8*s, s, s);
    fill(0);
    rect(x + 6*s, y - 8*s, s, s);
    
    //7 above
    fill(0);
    rect(x - 11*s, y - 7*s, s, s);
    rect(x - 10*s, y - 7*s, s, s);
    rect(x - 9*s, y - 7*s, s, s);
    rect(x - 6*s, y - 7*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 7*s, s, s);
    rect(x - 4*s, y - 7*s, s, s);
    rect(x - 3*s, y - 7*s, s, s);
    rect(x - 2*s, y - 7*s, s, s);
    rect(x - s, y - 7*s, s, s);
    rect(x, y - 7*s, s, s);
    rect(x + s, y - 7*s, s, s);
    rect(x + 2*s, y - 7*s, s, s);
    rect(x + 3*s, y - 7*s, s, s);
    rect(x + 4*s, y - 7*s, s, s);
    rect(x + 5*s, y - 7*s, s, s);
    fill(0);
    rect(x + 6*s, y - 7*s, s, s);
    rect(x + 9*s, y - 7*s, s, s);
    rect(x + 10*s, y - 7*s, s, s);
    rect(x + 11*s, y - 7*s, s, s);
    
    //6 above
    fill(0);
    rect(x - 11*s, y - 6*s, s, s);
    fill(97,97,97);
    rect(x - 10*s, y - 6*s, s, s);
    fill(0);
    rect(x - 9*s, y - 6*s, s, s);
    rect(x - 6*s, y - 6*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 6*s, s, s);
    rect(x - 4*s, y - 6*s, s, s);
    rect(x - 3*s, y - 6*s, s, s);
    rect(x - 2*s, y - 6*s, s, s);
    rect(x - s, y - 6*s, s, s);
    fill(0);
    rect(x, y - 6*s, s, s);
    fill(205,205,205);
    rect(x + s, y - 6*s, s, s);
    rect(x + 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    rect(x + 4*s, y - 6*s, s, s);
    rect(x + 5*s, y - 6*s, s, s);
    fill(0);
    rect(x + 6*s, y - 6*s, s, s);
    rect(x + 9*s, y - 6*s, s, s);
    fill(97,97,97);
    rect(x + 10*s, y - 6*s, s, s);
    fill(0);
    rect(x + 11*s, y - 6*s, s, s);
    
    //5 above
     fill(0);
    rect(x - 11*s, y - 5*s, s, s);
    fill(48,183,61);
    rect(x - 10*s, y - 5*s, s, s);
    fill(0);
    rect(x - 9*s, y - 5*s, s, s);
    fill(0);
    rect(x - 5*s, y - 5*s, s, s);
    rect(x - 4*s, y - 5*s, s, s);
    rect(x - 3*s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 5*s, s, s);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    fill(0);
    rect(x + 2*s, y - 5*s, s, s);
    rect(x + 3*s, y - 5*s, s, s);
    rect(x + 4*s, y - 5*s, s, s);
    rect(x + 5*s, y - 5*s, s, s);
    rect(x + 9*s, y - 5*s, s, s);
    fill(48,183,61);
    rect(x + 10*s, y - 5*s, s, s);
    fill(0);
    rect(x + 11*s, y - 5*s, s, s);
    
    
    //4 above
    fill(0);
    rect(x - 10*s, y - 4*s, s, s);
    fill(48,183,61);
    rect(x - 9*s, y - 4*s, s, s);
    fill(0);
    rect(x - 8*s, y - 4*s, s, s);
    rect(x - 6*s, y - 4*s, s, s);
    rect(x - 5*s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x - 4*s, y - 4*s, s, s);
    rect(x - 3*s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    fill(255, 0,0);
    rect(x - s, y - 4*s, s, s);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 4*s, s, s);
    rect(x + 3*s, y - 4*s, s, s);
    rect(x + 4*s, y - 4*s, s, s);
    fill(0);
    rect(x + 5*s, y - 4*s, s, s);
    rect(x + 6*s, y - 4*s, s, s);
    rect(x + 8*s, y - 4*s, s, s);
    fill(48,183,61);
    rect(x + 9*s, y - 4*s, s, s);
    fill(0);
    rect(x + 10*s, y - 4*s, s, s);
    
    //3 above
    fill(0);
    rect(x - 9*s, y - 3*s, s, s);
    fill(48,183,61);
    rect(x - 8*s, y - 3*s, s, s);
    fill(0);
    rect(x - 7*s, y - 3*s, s, s);
    rect(x - 6*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 3*s, s, s);
    rect(x - 4*s, y - 3*s, s, s);
    rect(x - 3*s, y - 3*s, s, s);
    fill(0);
    rect(x - 2*s, y - 3*s, s, s);
    fill(255,0, 0);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    fill(0);
    rect(x + 2*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x + 4*s, y - 3*s, s, s);
    rect(x + 5*s, y - 3*s, s, s);
    fill(0);
    rect(x + 6*s, y - 3*s, s, s);
    rect(x + 7*s, y - 3*s, s, s);
    fill(48,183,61);
    rect(x + 8*s, y - 3*s, s, s);
    fill(0);
    rect(x + 9*s, y - 3*s, s, s);
    
    //2 above
    fill(0);
    rect(x - 8*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x - 7*s, y - 2*s, s, s);
    fill(0);
    rect(x - 6*s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 2*s, s, s);
    rect(x - 4*s, y - 2*s, s, s);
    rect(x - 3*s, y - 2*s, s, s);
    fill(0);
    rect(x - 2*s, y - 2*s, s, s);
    fill(255, 0, 0);
    rect(x - s, y - 2*s, s, s);
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    rect(x + 4*s, y - 2*s, s, s);
    rect(x + 5*s, y - 2*s, s, s);
    fill(0);
    rect(x + 6*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x + 7*s, y - 2*s, s, s);
    fill(0);
    rect(x + 8*s, y - 2*s, s, s);
    
    //1 above
    fill(0);
    rect(x - 7*s, y - s, s, s);
    rect(x - 6*s, y - s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    fill(0);
    rect(x - 2*s, y - s, s, s);
    fill(234,255,0);
    rect(x - s, y - s, s, s);
    fill(0);
    rect(x, y - s, s, s);
    fill(234,255,0);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    fill(0);
    rect(x + 6*s, y - s, s, s);
    rect(x + 7*s, y - s, s, s);
    
    //center row
    fill(0);
    rect(x - 6*s, y, s, s);
    fill(234,255,0);
    rect(x - 5*s, y, s, s);
    rect(x - 4*s, y, s, s);
    rect(x - 3*s, y, s, s);
    fill(0);
    rect(x - 2*s, y, s, s);
    rect(x - s, y, s, s);
    fill(234,255,0);
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    rect(x + 5*s, y, s, s);
    fill(0);
    rect(x + 6*s, y, s, s);
    
    //1 below
    fill(0);
    rect(x - 6*s, y + s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    fill(0);
    rect(x - 2*s, y + s, s, s);
    fill(234,255,0);
    rect(x - s, y + s, s, s);
    fill(0);
    rect(x, y + s, s, s);
    fill(234,255,0);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x + 5*s, y + s, s, s);
    fill(0);
    rect(x + 6*s, y + s, s, s);
    
    //2 below
    fill(0);
    rect(x - 6*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 2*s, s, s);
    rect(x - 4*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    fill(0);
    rect(x - 2*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 2*s, s, s);
    rect(x, y + 2*s, s, s);
    fill(0);
    rect(x + s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    rect(x + 5*s, y + 2*s, s, s);
    fill(0);
    rect(x + 6*s, y + 2*s, s, s);
    
     //3 below
    fill(0);
    rect(x - 6*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    fill(0);
    rect(x - 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 3*s, s, s);
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    fill(0);
    rect(x + 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    rect(x + 5*s, y + 3*s, s, s);
    fill(0);
    rect(x + 6*s, y + 3*s, s, s);
    
     //4 below
    fill(0);
    rect(x - 6*s, y + 4*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 4*s, s, s);
    rect(x - 4*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x, y + 4*s, s, s);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x + 4*s, y + 4*s, s, s);
    rect(x + 5*s, y + 4*s, s, s);
    fill(0);
    rect(x + 6*s, y + 4*s, s, s);
    
    //5 below
    fill(0);
    rect(x - 5*s, y + 5*s, s, s);
    rect(x - 4*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    rect(x, y + 5*s, s, s);
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
    rect(x + 5*s, y + 5*s, s, s);
    
    //6 below
    fill(0);
    rect(x - 5*s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 6*s, s, s);
    rect(x - 3*s, y + 6*s, s, s);
    rect(x - 2*s, y + 6*s, s, s);
    fill(0);
    rect(x - s, y + 6*s, s, s);
    rect(x, y + 6*s, s, s);
    rect(x + s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x + 2*s, y + 6*s, s, s);
    rect(x + 3*s, y + 6*s, s, s);
    rect(x + 4*s, y + 6*s, s, s);
    fill(0);
    rect(x + 5*s, y + 6*s, s, s);
    
    //7 below
    fill(0);
    rect(x - 5*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 7*s, s, s);
    rect(x - 3*s, y + 7*s, s, s);
    fill(0);
    rect(x - 2*s, y + 7*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x + 3*s, y + 7*s, s, s);
    rect(x + 4*s, y + 7*s, s, s);
    fill(0);
    rect(x + 5*s, y + 7*s, s, s);
    
    //8 below
    fill(0);
    rect(x - 5*s, y + 8*s, s, s);
    rect(x - 4*s, y + 8*s, s, s);
    rect(x - 3*s, y + 8*s, s, s);
    rect(x - 2*s, y + 8*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 8*s, s, s);
    rect(x + 3*s, y + 8*s, s, s);
    rect(x + 4*s, y + 8*s, s, s);
    rect(x + 5*s, y + 8*s, s, s);
}
public void drawKarelAttack(int x, int y, int s) {
  noStroke();
    //11 above
    fill(0);
    rect(x - 4*s, y - 11*s, s, s);
    rect(x - 3*s, y - 11*s, s, s);
    rect(x - 2*s, y - 11*s, s, s);
    rect(x - s, y - 11*s, s, s);
    rect(x, y - 11*s, s, s);
    rect(x + s, y - 11*s, s, s);
    rect(x + 2*s, y - 11*s, s, s);
    rect(x + 3*s, y - 11*s, s, s);
    rect(x + 4*s, y - 11*s, s, s);
    
    //10 above
    fill(0);
    rect(x - 5*s, y - 10*s, s, s);
    fill(205,205,205);
    rect(x - 4*s, y - 10*s, s, s);
    rect(x - 3*s, y - 10*s, s, s);
    rect(x - 2*s, y - 10*s, s, s);
    rect(x - s, y - 10*s, s, s);
    rect(x, y - 10*s, s, s);
    rect(x + s, y - 10*s, s, s);
    rect(x + 2*s, y - 10*s, s, s);
    rect(x + 3*s, y - 10*s, s, s);
    rect(x + 4*s, y - 10*s, s, s);
    fill(0);
    rect(x + 5*s, y - 10*s, s, s);
    
    //9 above
    fill(0);
    rect(x - 6*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 9*s, s, s);
    rect(x - 4*s, y - 9*s, s, s);
    fill(0);
    rect(x - 3*s, y - 9*s, s, s);
    rect(x - 2*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 9*s, s, s);
    rect(x, y - 9*s, s, s);
    rect(x + s, y - 9*s, s, s);
    fill(0);
    rect(x + 2*s, y - 9*s, s, s);
    rect(x + 3*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 9*s, s, s);
    rect(x + 5*s, y - 9*s, s, s);
    fill(0);
    rect(x + 6*s, y - 9*s, s, s);
    
    //8 above
    fill(0);
    rect(x - 6*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 8*s, s, s);
    rect(x - 4*s, y - 8*s, s, s);
    fill(0);
    rect(x - 3*s, y - 8*s, s, s);
    fill(255, 0, 0);
    rect(x - 2*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 8*s, s, s);
    rect(x, y - 8*s, s, s);
    rect(x + s, y - 8*s, s, s);
    fill(0);
    rect(x + 2*s, y - 8*s, s, s);
    fill(255, 0, 0);
    rect(x + 3*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 8*s, s, s);
    rect(x + 5*s, y - 8*s, s, s);
    fill(0);
    rect(x + 6*s, y - 8*s, s, s);
    
    //7 above
    fill(0);
    rect(x - 6*s, y - 7*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 7*s, s, s);
    rect(x - 4*s, y - 7*s, s, s);
    rect(x - 3*s, y - 7*s, s, s);
    rect(x - 2*s, y - 7*s, s, s);
    rect(x - s, y - 7*s, s, s);
    rect(x, y - 7*s, s, s);
    rect(x + s, y - 7*s, s, s);
    rect(x + 2*s, y - 7*s, s, s);
    rect(x + 3*s, y - 7*s, s, s);
    rect(x + 4*s, y - 7*s, s, s);
    rect(x + 5*s, y - 7*s, s, s);
    fill(0);
    rect(x + 6*s, y - 7*s, s, s);
    
    //6 above
    fill(0);
    rect(x - 6*s, y - 6*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 6*s, s, s);
    rect(x - 4*s, y - 6*s, s, s);
    rect(x - 3*s, y - 6*s, s, s);
    rect(x - 2*s, y - 6*s, s, s);
    rect(x - s, y - 6*s, s, s);
    fill(0);
    rect(x, y - 6*s, s, s);
    fill(205,205,205);
    rect(x + s, y - 6*s, s, s);
    rect(x + 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    rect(x + 4*s, y - 6*s, s, s);
    rect(x + 5*s, y - 6*s, s, s);
    fill(0);
    rect(x + 6*s, y - 6*s, s, s);
    
    //5 above
    fill(0);
    rect(x - 5*s, y - 5*s, s, s);
    rect(x - 4*s, y - 5*s, s, s);
    rect(x - 3*s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 5*s, s, s);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    fill(0);
    rect(x + 2*s, y - 5*s, s, s);
    rect(x + 3*s, y - 5*s, s, s);
    rect(x + 4*s, y - 5*s, s, s);
    rect(x + 5*s, y - 5*s, s, s);
    
    //4 above
    fill(0);
    rect(x - 6*s, y - 4*s, s, s);
    rect(x - 5*s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x - 4*s, y - 4*s, s, s);
    rect(x - 3*s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    fill(255, 0, 0);
    rect(x - s, y - 4*s, s, s);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 4*s, s, s);
    rect(x + 3*s, y - 4*s, s, s);
    rect(x + 4*s, y - 4*s, s, s);
    fill(0);
    rect(x + 5*s, y - 4*s, s, s);
    rect(x + 6*s, y - 4*s, s, s);
    
    //3 above
    fill(0);
    rect(x - 8*s, y - 3*s, s, s);
    rect(x - 7*s, y - 3*s, s, s);
    rect(x - 6*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 3*s, s, s);
    rect(x - 4*s, y - 3*s, s, s);
    rect(x - 3*s, y - 3*s, s, s);
    fill(0);
    rect(x - 2*s, y - 3*s, s, s);
    fill(255, 0, 0);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    fill(0);
    rect(x + 2*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x + 4*s, y - 3*s, s, s);
    rect(x + 5*s, y - 3*s, s, s);
    fill(0);
    rect(x + 6*s, y - 3*s, s, s);
    rect(x + 7*s, y - 3*s, s, s);
    rect(x + 8*s, y - 3*s, s, s);
    
    //2 above
    fill(0);
    rect(x - 8*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x - 7*s, y - 2*s, s, s);
    fill(0);
    rect(x - 6*s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 2*s, s, s);
    rect(x - 4*s, y - 2*s, s, s);
    rect(x - 3*s, y - 2*s, s, s);
    fill(0);
    rect(x - 2*s, y - 2*s, s, s);
    fill(255, 0, 0);
    rect(x - s, y - 2*s, s, s);
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    rect(x + 4*s, y - 2*s, s, s);
    rect(x + 5*s, y - 2*s, s, s);
    fill(0);
    rect(x + 6*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x + 7*s, y - 2*s, s, s);
    fill(0);
    rect(x + 8*s, y - 2*s, s, s);
    
    //1 above
    fill(0);
    rect(x - 8*s, y - s, s, s);
    fill(48,183,61);
    rect(x - 7*s, y - s, s, s);
    fill(0);
    rect(x - 6*s, y - s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    fill(0);
    rect(x - 2*s, y - s, s, s);
    fill(234,255,0);
    rect(x - s, y - s, s, s);
    fill(0);
    rect(x, y - s, s, s);
    fill(234,255,0);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    fill(0);
    rect(x + 6*s, y - s, s, s);
    fill(48,183,61);
    rect(x + 7*s, y - s, s, s);
    fill(0);
    rect(x + 8*s, y - s, s, s);
    
    //center row
    fill(0);
    rect(x - 8*s, y, s, s);
    fill(48,183,61);
    rect(x - 7*s, y, s, s);
    fill(0);
    rect(x - 6*s, y, s, s);
    fill(234,255,0);
    rect(x - 5*s, y, s, s);
    rect(x - 4*s, y, s, s);
    rect(x - 3*s, y, s, s);
    fill(0);
    rect(x - 2*s, y, s, s);
    rect(x - s, y, s, s);
    fill(234,255,0);
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    rect(x + 5*s, y, s, s);
    fill(0);
    rect(x + 6*s, y, s, s);
    fill(48,183,61);
    rect(x + 7*s, y, s, s);
    fill(0);
    rect(x + 8*s, y, s, s);
    
    //1 below
    fill(0);
    rect(x - 8*s, y + s, s, s);
    fill(48,183,61);
    rect(x - 7*s, y + s, s, s);
    fill(0);
    rect(x - 6*s, y + s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    fill(0);
    rect(x - 2*s, y + s, s, s);
    fill(234,255,0);
    rect(x - s, y + s, s, s);
    fill(0);
    rect(x, y + s, s, s);
    fill(234,255,0);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x + 5*s, y + s, s, s);
    fill(0);
    rect(x + 6*s, y + s, s, s);
    fill(48,183,61);
    rect(x + 7*s, y + s, s, s);
    fill(0);
    rect(x + 8*s, y + s, s, s);
    
    //2 below
    fill(0);
    rect(x - 8*s, y + 2*s, s, s);
    fill(97,97,97);
    rect(x - 7*s, y + 2*s, s, s);
    fill(0);
    rect(x - 6*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 2*s, s, s);
    rect(x - 4*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    fill(0);
    rect(x - 2*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 2*s, s, s);
    rect(x, y + 2*s, s, s);
    fill(0);
    rect(x + s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    rect(x + 5*s, y + 2*s, s, s);
    fill(0);
    rect(x + 6*s, y + 2*s, s, s);
    fill(97,97,97);
    rect(x + 7*s, y + 2*s, s, s);
    fill(0);
    rect(x + 8*s, y + 2*s, s, s);
    
     //3 below
    fill(0);
    rect(x - 8*s, y + 3*s, s, s);
    rect(x - 7*s, y + 3*s, s, s);
    rect(x - 6*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    fill(0);
    rect(x - 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 3*s, s, s);
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    fill(0);
    rect(x + 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    rect(x + 5*s, y + 3*s, s, s);
    fill(0);
    rect(x + 6*s, y + 3*s, s, s);
    rect(x + 7*s, y + 3*s, s, s);
    rect(x + 8*s, y + 3*s, s, s);
    
     //4 below
    fill(0);
    rect(x - 6*s, y + 4*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 4*s, s, s);
    rect(x - 4*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x, y + 4*s, s, s);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x + 4*s, y + 4*s, s, s);
    rect(x + 5*s, y + 4*s, s, s);
    fill(0);
    rect(x + 6*s, y + 4*s, s, s);
    
    //5 below
    fill(0);
    rect(x - 5*s, y + 5*s, s, s);
    rect(x - 4*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    rect(x, y + 5*s, s, s);
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
    rect(x + 5*s, y + 5*s, s, s);
    
    //6 below
    fill(0);
    rect(x - 5*s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 6*s, s, s);
    rect(x - 3*s, y + 6*s, s, s);
    rect(x - 2*s, y + 6*s, s, s);
    fill(0);
    rect(x - s, y + 6*s, s, s);
    rect(x, y + 6*s, s, s);
    rect(x + s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x + 2*s, y + 6*s, s, s);
    rect(x + 3*s, y + 6*s, s, s);
    rect(x + 4*s, y + 6*s, s, s);
    fill(0);
    rect(x + 5*s, y + 6*s, s, s);
    
    //7 below
    fill(0);
    rect(x - 5*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 7*s, s, s);
    rect(x - 3*s, y + 7*s, s, s);
    fill(0);
    rect(x - 2*s, y + 7*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x + 3*s, y + 7*s, s, s);
    rect(x + 4*s, y + 7*s, s, s);
    fill(0);
    rect(x + 5*s, y + 7*s, s, s);
    
    //8 below
    fill(0);
    rect(x - 5*s, y + 8*s, s, s);
    rect(x - 4*s, y + 8*s, s, s);
    rect(x - 3*s, y + 8*s, s, s);
    rect(x - 2*s, y + 8*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 8*s, s, s);
    rect(x + 3*s, y + 8*s, s, s);
    rect(x + 4*s, y + 8*s, s, s);
    rect(x + 5*s, y + 8*s, s, s);
}
public void drawKarelFallingNeutral(int x, int y, int s) {
  noStroke();
    //11 above
    fill(0);
    rect(x - 4*s, y - 11*s, s, s);
    rect(x - 3*s, y - 11*s, s, s);
    rect(x - 2*s, y - 11*s, s, s);
    rect(x - s, y - 11*s, s, s);
    rect(x, y - 11*s, s, s);
    rect(x + s, y - 11*s, s, s);
    rect(x + 2*s, y - 11*s, s, s);
    rect(x + 3*s, y - 11*s, s, s);
    rect(x + 4*s, y - 11*s, s, s);
    
    //10 above
    fill(0);
    rect(x - 5*s, y - 10*s, s, s);
    fill(205,205,205);
    rect(x - 4*s, y - 10*s, s, s);
    rect(x - 3*s, y - 10*s, s, s);
    rect(x - 2*s, y - 10*s, s, s);
    rect(x - s, y - 10*s, s, s);
    rect(x, y - 10*s, s, s);
    rect(x + s, y - 10*s, s, s);
    rect(x + 2*s, y - 10*s, s, s);
    rect(x + 3*s, y - 10*s, s, s);
    rect(x + 4*s, y - 10*s, s, s);
    fill(0);
    rect(x + 5*s, y - 10*s, s, s);
    
    //9 above
    fill(0);
    rect(x - 6*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 9*s, s, s);
    rect(x - 4*s, y - 9*s, s, s);
    fill(0);
    rect(x - 3*s, y - 9*s, s, s);
    rect(x - 2*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 9*s, s, s);
    rect(x, y - 9*s, s, s);
    rect(x + s, y - 9*s, s, s);
    fill(0);
    rect(x + 2*s, y - 9*s, s, s);
    rect(x + 3*s, y - 9*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 9*s, s, s);
    rect(x + 5*s, y - 9*s, s, s);
    fill(0);
    rect(x + 6*s, y - 9*s, s, s);
    
    //8 above
    fill(0);
    rect(x - 6*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 8*s, s, s);
    rect(x - 4*s, y - 8*s, s, s);
    fill(0);
    rect(x - 3*s, y - 8*s, s, s);
    fill(91,150,222);
    rect(x - 2*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 8*s, s, s);
    rect(x, y - 8*s, s, s);
    rect(x + s, y - 8*s, s, s);
    fill(0);
    rect(x + 2*s, y - 8*s, s, s);
    fill(91,150,222);
    rect(x + 3*s, y - 8*s, s, s);
    fill(205,205,205);
    rect(x + 4*s, y - 8*s, s, s);
    rect(x + 5*s, y - 8*s, s, s);
    fill(0);
    rect(x + 6*s, y - 8*s, s, s);
    
    //7 above
    fill(0);
    rect(x - 11*s, y - 7*s, s, s);
    rect(x - 10*s, y - 7*s, s, s);
    rect(x - 9*s, y - 7*s, s, s);
    rect(x - 6*s, y - 7*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 7*s, s, s);
    rect(x - 4*s, y - 7*s, s, s);
    rect(x - 3*s, y - 7*s, s, s);
    rect(x - 2*s, y - 7*s, s, s);
    rect(x - s, y - 7*s, s, s);
    rect(x, y - 7*s, s, s);
    rect(x + s, y - 7*s, s, s);
    rect(x + 2*s, y - 7*s, s, s);
    rect(x + 3*s, y - 7*s, s, s);
    rect(x + 4*s, y - 7*s, s, s);
    rect(x + 5*s, y - 7*s, s, s);
    fill(0);
    rect(x + 6*s, y - 7*s, s, s);
    rect(x + 9*s, y - 7*s, s, s);
    rect(x + 10*s, y - 7*s, s, s);
    rect(x + 11*s, y - 7*s, s, s);
    
    //6 above
    fill(0);
    rect(x - 11*s, y - 6*s, s, s);
    fill(97,97,97);
    rect(x - 10*s, y - 6*s, s, s);
    fill(0);
    rect(x - 9*s, y - 6*s, s, s);
    rect(x - 6*s, y - 6*s, s, s);
    fill(205,205,205);
    rect(x - 5*s, y - 6*s, s, s);
    rect(x - 4*s, y - 6*s, s, s);
    rect(x - 3*s, y - 6*s, s, s);
    rect(x - 2*s, y - 6*s, s, s);
    rect(x - s, y - 6*s, s, s);
    fill(0);
    rect(x, y - 6*s, s, s);
    fill(205,205,205);
    rect(x + s, y - 6*s, s, s);
    rect(x + 2*s, y - 6*s, s, s);
    rect(x + 3*s, y - 6*s, s, s);
    rect(x + 4*s, y - 6*s, s, s);
    rect(x + 5*s, y - 6*s, s, s);
    fill(0);
    rect(x + 6*s, y - 6*s, s, s);
    rect(x + 9*s, y - 6*s, s, s);
    fill(97,97,97);
    rect(x + 10*s, y - 6*s, s, s);
    fill(0);
    rect(x + 11*s, y - 6*s, s, s);
    
    //5 above
     fill(0);
    rect(x - 11*s, y - 5*s, s, s);
    fill(48,183,61);
    rect(x - 10*s, y - 5*s, s, s);
    fill(0);
    rect(x - 9*s, y - 5*s, s, s);
    fill(0);
    rect(x - 5*s, y - 5*s, s, s);
    rect(x - 4*s, y - 5*s, s, s);
    rect(x - 3*s, y - 5*s, s, s);
    rect(x - 2*s, y - 5*s, s, s);
    fill(205,205,205);
    rect(x - s, y - 5*s, s, s);
    rect(x, y - 5*s, s, s);
    rect(x + s, y - 5*s, s, s);
    fill(0);
    rect(x + 2*s, y - 5*s, s, s);
    rect(x + 3*s, y - 5*s, s, s);
    rect(x + 4*s, y - 5*s, s, s);
    rect(x + 5*s, y - 5*s, s, s);
    rect(x + 9*s, y - 5*s, s, s);
    fill(48,183,61);
    rect(x + 10*s, y - 5*s, s, s);
    fill(0);
    rect(x + 11*s, y - 5*s, s, s);
    
    
    //4 above
    fill(0);
    rect(x - 10*s, y - 4*s, s, s);
    fill(48,183,61);
    rect(x - 9*s, y - 4*s, s, s);
    fill(0);
    rect(x - 8*s, y - 4*s, s, s);
    rect(x - 6*s, y - 4*s, s, s);
    rect(x - 5*s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x - 4*s, y - 4*s, s, s);
    rect(x - 3*s, y - 4*s, s, s);
    rect(x - 2*s, y - 4*s, s, s);
    fill(0,58,255);
    rect(x - s, y - 4*s, s, s);
    rect(x, y - 4*s, s, s);
    rect(x + s, y - 4*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 4*s, s, s);
    rect(x + 3*s, y - 4*s, s, s);
    rect(x + 4*s, y - 4*s, s, s);
    fill(0);
    rect(x + 5*s, y - 4*s, s, s);
    rect(x + 6*s, y - 4*s, s, s);
    rect(x + 8*s, y - 4*s, s, s);
    fill(48,183,61);
    rect(x + 9*s, y - 4*s, s, s);
    fill(0);
    rect(x + 10*s, y - 4*s, s, s);
    
    //3 above
    fill(0);
    rect(x - 9*s, y - 3*s, s, s);
    fill(48,183,61);
    rect(x - 8*s, y - 3*s, s, s);
    fill(0);
    rect(x - 7*s, y - 3*s, s, s);
    rect(x - 6*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 3*s, s, s);
    rect(x - 4*s, y - 3*s, s, s);
    rect(x - 3*s, y - 3*s, s, s);
    fill(0);
    rect(x - 2*s, y - 3*s, s, s);
    fill(0,58,255);
    rect(x - s, y - 3*s, s, s);
    rect(x, y - 3*s, s, s);
    rect(x + s, y - 3*s, s, s);
    fill(0);
    rect(x + 2*s, y - 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y - 3*s, s, s);
    rect(x + 4*s, y - 3*s, s, s);
    rect(x + 5*s, y - 3*s, s, s);
    fill(0);
    rect(x + 6*s, y - 3*s, s, s);
    rect(x + 7*s, y - 3*s, s, s);
    fill(48,183,61);
    rect(x + 8*s, y - 3*s, s, s);
    fill(0);
    rect(x + 9*s, y - 3*s, s, s);
    
    //2 above
    fill(0);
    rect(x - 8*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x - 7*s, y - 2*s, s, s);
    fill(0);
    rect(x - 6*s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - 2*s, s, s);
    rect(x - 4*s, y - 2*s, s, s);
    rect(x - 3*s, y - 2*s, s, s);
    fill(0);
    rect(x - 2*s, y - 2*s, s, s);
    fill(0,58,255);
    rect(x - s, y - 2*s, s, s);
    rect(x, y - 2*s, s, s);
    rect(x + s, y - 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y - 2*s, s, s);
    rect(x + 3*s, y - 2*s, s, s);
    rect(x + 4*s, y - 2*s, s, s);
    rect(x + 5*s, y - 2*s, s, s);
    fill(0);
    rect(x + 6*s, y - 2*s, s, s);
    fill(48,183,61);
    rect(x + 7*s, y - 2*s, s, s);
    fill(0);
    rect(x + 8*s, y - 2*s, s, s);
    
    //1 above
    fill(0);
    rect(x - 7*s, y - s, s, s);
    rect(x - 6*s, y - s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y - s, s, s);
    rect(x - 4*s, y - s, s, s);
    rect(x - 3*s, y - s, s, s);
    fill(0);
    rect(x - 2*s, y - s, s, s);
    fill(234,255,0);
    rect(x - s, y - s, s, s);
    fill(0);
    rect(x, y - s, s, s);
    fill(234,255,0);
    rect(x + s, y - s, s, s);
    rect(x + 2*s, y - s, s, s);
    rect(x + 3*s, y - s, s, s);
    rect(x + 4*s, y - s, s, s);
    rect(x + 5*s, y - s, s, s);
    fill(0);
    rect(x + 6*s, y - s, s, s);
    rect(x + 7*s, y - s, s, s);
    
    //center row
    fill(0);
    rect(x - 6*s, y, s, s);
    fill(234,255,0);
    rect(x - 5*s, y, s, s);
    rect(x - 4*s, y, s, s);
    rect(x - 3*s, y, s, s);
    fill(0);
    rect(x - 2*s, y, s, s);
    rect(x - s, y, s, s);
    fill(234,255,0);
    rect(x, y, s, s);
    rect(x + s, y, s, s);
    rect(x + 2*s, y, s, s);
    rect(x + 3*s, y, s, s);
    rect(x + 4*s, y, s, s);
    rect(x + 5*s, y, s, s);
    fill(0);
    rect(x + 6*s, y, s, s);
    
    //1 below
    fill(0);
    rect(x - 6*s, y + s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + s, s, s);
    rect(x - 4*s, y + s, s, s);
    rect(x - 3*s, y + s, s, s);
    fill(0);
    rect(x - 2*s, y + s, s, s);
    fill(234,255,0);
    rect(x - s, y + s, s, s);
    fill(0);
    rect(x, y + s, s, s);
    fill(234,255,0);
    rect(x + s, y + s, s, s);
    rect(x + 2*s, y + s, s, s);
    rect(x + 3*s, y + s, s, s);
    rect(x + 4*s, y + s, s, s);
    rect(x + 5*s, y + s, s, s);
    fill(0);
    rect(x + 6*s, y + s, s, s);
    
    //2 below
    fill(0);
    rect(x - 6*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 2*s, s, s);
    rect(x - 4*s, y + 2*s, s, s);
    rect(x - 3*s, y + 2*s, s, s);
    fill(0);
    rect(x - 2*s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 2*s, s, s);
    rect(x, y + 2*s, s, s);
    fill(0);
    rect(x + s, y + 2*s, s, s);
    fill(234,255,0);
    rect(x + 2*s, y + 2*s, s, s);
    rect(x + 3*s, y + 2*s, s, s);
    rect(x + 4*s, y + 2*s, s, s);
    rect(x + 5*s, y + 2*s, s, s);
    fill(0);
    rect(x + 6*s, y + 2*s, s, s);
    
     //3 below
    fill(0);
    rect(x - 6*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 3*s, s, s);
    rect(x - 4*s, y + 3*s, s, s);
    rect(x - 3*s, y + 3*s, s, s);
    fill(0);
    rect(x - 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x - s, y + 3*s, s, s);
    rect(x, y + 3*s, s, s);
    rect(x + s, y + 3*s, s, s);
    fill(0);
    rect(x + 2*s, y + 3*s, s, s);
    fill(234,255,0);
    rect(x + 3*s, y + 3*s, s, s);
    rect(x + 4*s, y + 3*s, s, s);
    rect(x + 5*s, y + 3*s, s, s);
    fill(0);
    rect(x + 6*s, y + 3*s, s, s);
    
     //4 below
    fill(0);
    rect(x - 6*s, y + 4*s, s, s);
    fill(234,255,0);
    rect(x - 5*s, y + 4*s, s, s);
    rect(x - 4*s, y + 4*s, s, s);
    rect(x - 3*s, y + 4*s, s, s);
    rect(x - 2*s, y + 4*s, s, s);
    rect(x - s, y + 4*s, s, s);
    rect(x, y + 4*s, s, s);
    rect(x + s, y + 4*s, s, s);
    rect(x + 2*s, y + 4*s, s, s);
    rect(x + 3*s, y + 4*s, s, s);
    rect(x + 4*s, y + 4*s, s, s);
    rect(x + 5*s, y + 4*s, s, s);
    fill(0);
    rect(x + 6*s, y + 4*s, s, s);
    
    //5 below
    fill(0);
    rect(x - 5*s, y + 5*s, s, s);
    rect(x - 4*s, y + 5*s, s, s);
    rect(x - 3*s, y + 5*s, s, s);
    rect(x - 2*s, y + 5*s, s, s);
    rect(x - s, y + 5*s, s, s);
    rect(x, y + 5*s, s, s);
    rect(x + s, y + 5*s, s, s);
    rect(x + 2*s, y + 5*s, s, s);
    rect(x + 3*s, y + 5*s, s, s);
    rect(x + 4*s, y + 5*s, s, s);
    rect(x + 5*s, y + 5*s, s, s);
    
    //6 below
    fill(0);
    rect(x - 5*s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 6*s, s, s);
    rect(x - 3*s, y + 6*s, s, s);
    rect(x - 2*s, y + 6*s, s, s);
    fill(0);
    rect(x - s, y + 6*s, s, s);
    rect(x, y + 6*s, s, s);
    rect(x + s, y + 6*s, s, s);
    fill(211,47,47);
    rect(x + 2*s, y + 6*s, s, s);
    rect(x + 3*s, y + 6*s, s, s);
    rect(x + 4*s, y + 6*s, s, s);
    fill(0);
    rect(x + 5*s, y + 6*s, s, s);
    
    //7 below
    fill(0);
    rect(x - 5*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x - 4*s, y + 7*s, s, s);
    rect(x - 3*s, y + 7*s, s, s);
    fill(0);
    rect(x - 2*s, y + 7*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 7*s, s, s);
    fill(211,47,47);
    rect(x + 3*s, y + 7*s, s, s);
    rect(x + 4*s, y + 7*s, s, s);
    fill(0);
    rect(x + 5*s, y + 7*s, s, s);
    
    //8 below
    fill(0);
    rect(x - 5*s, y + 8*s, s, s);
    rect(x - 4*s, y + 8*s, s, s);
    rect(x - 3*s, y + 8*s, s, s);
    rect(x - 2*s, y + 8*s, s, s);
    
    fill(0);
    rect(x + 2*s, y + 8*s, s, s);
    rect(x + 3*s, y + 8*s, s, s);
    rect(x + 4*s, y + 8*s, s, s);
    rect(x + 5*s, y + 8*s, s, s);
}
public void drawKarelNeutral(int x, int y, int s) {
  rectMode(CENTER);
  noStroke();
  //11 above
  fill(0);
  rect(x - 4*s, y - 11*s, s, s);
  rect(x - 3*s, y - 11*s, s, s);
  rect(x - 2*s, y - 11*s, s, s);
  rect(x - s, y - 11*s, s, s);
  rect(x, y - 11*s, s, s);
  rect(x + s, y - 11*s, s, s);
  rect(x + 2*s, y - 11*s, s, s);
  rect(x + 3*s, y - 11*s, s, s);
  rect(x + 4*s, y - 11*s, s, s);
  
  //10 above
  fill(0);
  rect(x - 5*s, y - 10*s, s, s);
  fill(205,205,205);
  rect(x - 4*s, y - 10*s, s, s);
  rect(x - 3*s, y - 10*s, s, s);
  rect(x - 2*s, y - 10*s, s, s);
  rect(x - s, y - 10*s, s, s);
  rect(x, y - 10*s, s, s);
  rect(x + s, y - 10*s, s, s);
  rect(x + 2*s, y - 10*s, s, s);
  rect(x + 3*s, y - 10*s, s, s);
  rect(x + 4*s, y - 10*s, s, s);
  fill(0);
  rect(x + 5*s, y - 10*s, s, s);
  
  //9 above
  fill(0);
  rect(x - 6*s, y - 9*s, s, s);
  fill(205,205,205);
  rect(x - 5*s, y - 9*s, s, s);
  rect(x - 4*s, y - 9*s, s, s);
  fill(0);
  rect(x - 3*s, y - 9*s, s, s);
  rect(x - 2*s, y - 9*s, s, s);
  fill(205,205,205);
  rect(x - s, y - 9*s, s, s);
  rect(x, y - 9*s, s, s);
  rect(x + s, y - 9*s, s, s);
  fill(0);
  rect(x + 2*s, y - 9*s, s, s);
  rect(x + 3*s, y - 9*s, s, s);
  fill(205,205,205);
  rect(x + 4*s, y - 9*s, s, s);
  rect(x + 5*s, y - 9*s, s, s);
  fill(0);
  rect(x + 6*s, y - 9*s, s, s);
  
  //8 above
  fill(0);
  rect(x - 6*s, y - 8*s, s, s);
  fill(205,205,205);
  rect(x - 5*s, y - 8*s, s, s);
  rect(x - 4*s, y - 8*s, s, s);
  fill(0);
  rect(x - 3*s, y - 8*s, s, s);
  fill(91,150,222);
  rect(x - 2*s, y - 8*s, s, s);
  fill(205,205,205);
  rect(x - s, y - 8*s, s, s);
  rect(x, y - 8*s, s, s);
  rect(x + s, y - 8*s, s, s);
  fill(0);
  rect(x + 2*s, y - 8*s, s, s);
  fill(91,150,222);
  rect(x + 3*s, y - 8*s, s, s);
  fill(205,205,205);
  rect(x + 4*s, y - 8*s, s, s);
  rect(x + 5*s, y - 8*s, s, s);
  fill(0);
  rect(x + 6*s, y - 8*s, s, s);
  
  //7 above
  fill(0);
  rect(x - 6*s, y - 7*s, s, s);
  fill(205,205,205);
  rect(x - 5*s, y - 7*s, s, s);
  rect(x - 4*s, y - 7*s, s, s);
  rect(x - 3*s, y - 7*s, s, s);
  rect(x - 2*s, y - 7*s, s, s);
  rect(x - s, y - 7*s, s, s);
  rect(x, y - 7*s, s, s);
  rect(x + s, y - 7*s, s, s);
  rect(x + 2*s, y - 7*s, s, s);
  rect(x + 3*s, y - 7*s, s, s);
  rect(x + 4*s, y - 7*s, s, s);
  rect(x + 5*s, y - 7*s, s, s);
  fill(0);
  rect(x + 6*s, y - 7*s, s, s);
  
  //6 above
  fill(0);
  rect(x - 6*s, y - 6*s, s, s);
  fill(205,205,205);
  rect(x - 5*s, y - 6*s, s, s);
  rect(x - 4*s, y - 6*s, s, s);
  rect(x - 3*s, y - 6*s, s, s);
  rect(x - 2*s, y - 6*s, s, s);
  rect(x - s, y - 6*s, s, s);
  fill(0);
  rect(x, y - 6*s, s, s);
  fill(205,205,205);
  rect(x + s, y - 6*s, s, s);
  rect(x + 2*s, y - 6*s, s, s);
  rect(x + 3*s, y - 6*s, s, s);
  rect(x + 4*s, y - 6*s, s, s);
  rect(x + 5*s, y - 6*s, s, s);
  fill(0);
  rect(x + 6*s, y - 6*s, s, s);
  
  //5 above
  fill(0);
  rect(x - 5*s, y - 5*s, s, s);
  rect(x - 4*s, y - 5*s, s, s);
  rect(x - 3*s, y - 5*s, s, s);
  rect(x - 2*s, y - 5*s, s, s);
  fill(205,205,205);
  rect(x - s, y - 5*s, s, s);
  rect(x, y - 5*s, s, s);
  rect(x + s, y - 5*s, s, s);
  fill(0);
  rect(x + 2*s, y - 5*s, s, s);
  rect(x + 3*s, y - 5*s, s, s);
  rect(x + 4*s, y - 5*s, s, s);
  rect(x + 5*s, y - 5*s, s, s);
  
  //4 above
  fill(0);
  rect(x - 6*s, y - 4*s, s, s);
  rect(x - 5*s, y - 4*s, s, s);
  fill(234,255,0);
  rect(x - 4*s, y - 4*s, s, s);
  rect(x - 3*s, y - 4*s, s, s);
  rect(x - 2*s, y - 4*s, s, s);
  fill(0,58,255);
  rect(x - s, y - 4*s, s, s);
  rect(x, y - 4*s, s, s);
  rect(x + s, y - 4*s, s, s);
  fill(234,255,0);
  rect(x + 2*s, y - 4*s, s, s);
  rect(x + 3*s, y - 4*s, s, s);
  rect(x + 4*s, y - 4*s, s, s);
  fill(0);
  rect(x + 5*s, y - 4*s, s, s);
  rect(x + 6*s, y - 4*s, s, s);
  
  //3 above
  fill(0);
  rect(x - 8*s, y - 3*s, s, s);
  rect(x - 7*s, y - 3*s, s, s);
  rect(x - 6*s, y - 3*s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y - 3*s, s, s);
  rect(x - 4*s, y - 3*s, s, s);
  rect(x - 3*s, y - 3*s, s, s);
  fill(0);
  rect(x - 2*s, y - 3*s, s, s);
  fill(0,58,255);
  rect(x - s, y - 3*s, s, s);
  rect(x, y - 3*s, s, s);
  rect(x + s, y - 3*s, s, s);
  fill(0);
  rect(x + 2*s, y - 3*s, s, s);
  fill(234,255,0);
  rect(x + 3*s, y - 3*s, s, s);
  rect(x + 4*s, y - 3*s, s, s);
  rect(x + 5*s, y - 3*s, s, s);
  fill(0);
  rect(x + 6*s, y - 3*s, s, s);
  rect(x + 7*s, y - 3*s, s, s);
  rect(x + 8*s, y - 3*s, s, s);
  
  //2 above
  fill(0);
  rect(x - 8*s, y - 2*s, s, s);
  fill(48,183,61);
  rect(x - 7*s, y - 2*s, s, s);
  fill(0);
  rect(x - 6*s, y - 2*s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y - 2*s, s, s);
  rect(x - 4*s, y - 2*s, s, s);
  rect(x - 3*s, y - 2*s, s, s);
  fill(0);
  rect(x - 2*s, y - 2*s, s, s);
  fill(0,58,255);
  rect(x - s, y - 2*s, s, s);
  rect(x, y - 2*s, s, s);
  rect(x + s, y - 2*s, s, s);
  fill(234,255,0);
  rect(x + 2*s, y - 2*s, s, s);
  rect(x + 3*s, y - 2*s, s, s);
  rect(x + 4*s, y - 2*s, s, s);
  rect(x + 5*s, y - 2*s, s, s);
  fill(0);
  rect(x + 6*s, y - 2*s, s, s);
  fill(48,183,61);
  rect(x + 7*s, y - 2*s, s, s);
  fill(0);
  rect(x + 8*s, y - 2*s, s, s);
  
  //1 above
  fill(0);
  rect(x - 8*s, y - s, s, s);
  fill(48,183,61);
  rect(x - 7*s, y - s, s, s);
  fill(0);
  rect(x - 6*s, y - s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y - s, s, s);
  rect(x - 4*s, y - s, s, s);
  rect(x - 3*s, y - s, s, s);
  fill(0);
  rect(x - 2*s, y - s, s, s);
  fill(234,255,0);
  rect(x - s, y - s, s, s);
  fill(0);
  rect(x, y - s, s, s);
  fill(234,255,0);
  rect(x + s, y - s, s, s);
  rect(x + 2*s, y - s, s, s);
  rect(x + 3*s, y - s, s, s);
  rect(x + 4*s, y - s, s, s);
  rect(x + 5*s, y - s, s, s);
  fill(0);
  rect(x + 6*s, y - s, s, s);
  fill(48,183,61);
  rect(x + 7*s, y - s, s, s);
  fill(0);
  rect(x + 8*s, y - s, s, s);
  
  //center row
  fill(0);
  rect(x - 8*s, y, s, s);
  fill(48,183,61);
  rect(x - 7*s, y, s, s);
  fill(0);
  rect(x - 6*s, y, s, s);
  fill(234,255,0);
  rect(x - 5*s, y, s, s);
  rect(x - 4*s, y, s, s);
  rect(x - 3*s, y, s, s);
  fill(0);
  rect(x - 2*s, y, s, s);
  rect(x - s, y, s, s);
  fill(234,255,0);
  rect(x, y, s, s);
  rect(x + s, y, s, s);
  rect(x + 2*s, y, s, s);
  rect(x + 3*s, y, s, s);
  rect(x + 4*s, y, s, s);
  rect(x + 5*s, y, s, s);
  fill(0);
  rect(x + 6*s, y, s, s);
  fill(48,183,61);
  rect(x + 7*s, y, s, s);
  fill(0);
  rect(x + 8*s, y, s, s);
  
  //1 below
  fill(0);
  rect(x - 8*s, y + s, s, s);
  fill(48,183,61);
  rect(x - 7*s, y + s, s, s);
  fill(0);
  rect(x - 6*s, y + s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y + s, s, s);
  rect(x - 4*s, y + s, s, s);
  rect(x - 3*s, y + s, s, s);
  fill(0);
  rect(x - 2*s, y + s, s, s);
  fill(234,255,0);
  rect(x - s, y + s, s, s);
  fill(0);
  rect(x, y + s, s, s);
  fill(234,255,0);
  rect(x + s, y + s, s, s);
  rect(x + 2*s, y + s, s, s);
  rect(x + 3*s, y + s, s, s);
  rect(x + 4*s, y + s, s, s);
  rect(x + 5*s, y + s, s, s);
  fill(0);
  rect(x + 6*s, y + s, s, s);
  fill(48,183,61);
  rect(x + 7*s, y + s, s, s);
  fill(0);
  rect(x + 8*s, y + s, s, s);
  
  //2 below
  fill(0);
  rect(x - 8*s, y + 2*s, s, s);
  fill(97,97,97);
  rect(x - 7*s, y + 2*s, s, s);
  fill(0);
  rect(x - 6*s, y + 2*s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y + 2*s, s, s);
  rect(x - 4*s, y + 2*s, s, s);
  rect(x - 3*s, y + 2*s, s, s);
  fill(0);
  rect(x - 2*s, y + 2*s, s, s);
  fill(234,255,0);
  rect(x - s, y + 2*s, s, s);
  rect(x, y + 2*s, s, s);
  fill(0);
  rect(x + s, y + 2*s, s, s);
  fill(234,255,0);
  rect(x + 2*s, y + 2*s, s, s);
  rect(x + 3*s, y + 2*s, s, s);
  rect(x + 4*s, y + 2*s, s, s);
  rect(x + 5*s, y + 2*s, s, s);
  fill(0);
  rect(x + 6*s, y + 2*s, s, s);
  fill(97,97,97);
  rect(x + 7*s, y + 2*s, s, s);
  fill(0);
  rect(x + 8*s, y + 2*s, s, s);
  
   //3 below
  fill(0);
  rect(x - 8*s, y + 3*s, s, s);
  rect(x - 7*s, y + 3*s, s, s);
  rect(x - 6*s, y + 3*s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y + 3*s, s, s);
  rect(x - 4*s, y + 3*s, s, s);
  rect(x - 3*s, y + 3*s, s, s);
  fill(0);
  rect(x - 2*s, y + 3*s, s, s);
  fill(234,255,0);
  rect(x - s, y + 3*s, s, s);
  rect(x, y + 3*s, s, s);
  rect(x + s, y + 3*s, s, s);
  fill(0);
  rect(x + 2*s, y + 3*s, s, s);
  fill(234,255,0);
  rect(x + 3*s, y + 3*s, s, s);
  rect(x + 4*s, y + 3*s, s, s);
  rect(x + 5*s, y + 3*s, s, s);
  fill(0);
  rect(x + 6*s, y + 3*s, s, s);
  rect(x + 7*s, y + 3*s, s, s);
  rect(x + 8*s, y + 3*s, s, s);
  
   //4 below
  fill(0);
  rect(x - 6*s, y + 4*s, s, s);
  fill(234,255,0);
  rect(x - 5*s, y + 4*s, s, s);
  rect(x - 4*s, y + 4*s, s, s);
  rect(x - 3*s, y + 4*s, s, s);
  rect(x - 2*s, y + 4*s, s, s);
  rect(x - s, y + 4*s, s, s);
  rect(x, y + 4*s, s, s);
  rect(x + s, y + 4*s, s, s);
  rect(x + 2*s, y + 4*s, s, s);
  rect(x + 3*s, y + 4*s, s, s);
  rect(x + 4*s, y + 4*s, s, s);
  rect(x + 5*s, y + 4*s, s, s);
  fill(0);
  rect(x + 6*s, y + 4*s, s, s);
  
  //5 below
  fill(0);
  rect(x - 5*s, y + 5*s, s, s);
  rect(x - 4*s, y + 5*s, s, s);
  rect(x - 3*s, y + 5*s, s, s);
  rect(x - 2*s, y + 5*s, s, s);
  rect(x - s, y + 5*s, s, s);
  rect(x, y + 5*s, s, s);
  rect(x + s, y + 5*s, s, s);
  rect(x + 2*s, y + 5*s, s, s);
  rect(x + 3*s, y + 5*s, s, s);
  rect(x + 4*s, y + 5*s, s, s);
  rect(x + 5*s, y + 5*s, s, s);
  
  //6 below
  fill(0);
  rect(x - 5*s, y + 6*s, s, s);
  fill(211,47,47);
  rect(x - 4*s, y + 6*s, s, s);
  rect(x - 3*s, y + 6*s, s, s);
  rect(x - 2*s, y + 6*s, s, s);
  fill(0);
  rect(x - s, y + 6*s, s, s);
  rect(x, y + 6*s, s, s);
  rect(x + s, y + 6*s, s, s);
  fill(211,47,47);
  rect(x + 2*s, y + 6*s, s, s);
  rect(x + 3*s, y + 6*s, s, s);
  rect(x + 4*s, y + 6*s, s, s);
  fill(0);
  rect(x + 5*s, y + 6*s, s, s);
  
  //7 below
  fill(0);
  rect(x - 5*s, y + 7*s, s, s);
  fill(211,47,47);
  rect(x - 4*s, y + 7*s, s, s);
  rect(x - 3*s, y + 7*s, s, s);
  fill(0);
  rect(x - 2*s, y + 7*s, s, s);
  
  fill(0);
  rect(x + 2*s, y + 7*s, s, s);
  fill(211,47,47);
  rect(x + 3*s, y + 7*s, s, s);
  rect(x + 4*s, y + 7*s, s, s);
  fill(0);
  rect(x + 5*s, y + 7*s, s, s);
  
  //8 below
  fill(0);
  rect(x - 5*s, y + 8*s, s, s);
  rect(x - 4*s, y + 8*s, s, s);
  rect(x - 3*s, y + 8*s, s, s);
  rect(x - 2*s, y + 8*s, s, s);
  
  fill(0);
  rect(x + 2*s, y + 8*s, s, s);
  rect(x + 3*s, y + 8*s, s, s);
  rect(x + 4*s, y + 8*s, s, s);
  rect(x + 5*s, y + 8*s, s, s); 
  
}
public void drawCampbellRight(int x,int y,int size) {
  rectMode(CENTER);
  rectMode(CENTER);
  noStroke();
  //12 above
  fill(68, 59, 59);
  rect(x, y - 12*size, size, size);
  rect(x + size, y - 12*size, size, size);
  rect(x + 2*size, y - 12*size, size, size);
  rect(x + 3*size, y - 12*size, size, size);
  rect(x + 4*size, y - 12*size, size, size);
  rect(x - size, y - 12*size, size, size);
  //11 above
  rect(x, y - 11*size, size, size);
  rect(x + size, y - 11*size, size, size);
  rect(x + 2*size, y - 11*size, size, size);
  rect(x + 3*size, y - 11*size, size, size);
  rect(x + 4*size, y - 11*size, size, size);
  rect(x + 5*size, y - 11*size, size, size);
  rect(x - size, y - 11*size, size, size);
  rect(x - 2*size, y - 11*size, size, size);
  rect(x - 3*size, y - 11*size, size, size);
  //10 above
  rect(x, y - 10*size, size, size);
  rect(x + size, y - 10*size, size, size);
  rect(x + 2*size, y - 10*size, size, size);
  rect(x + 3*size, y - 10*size, size, size);
  rect(x + 4*size, y - 10*size, size, size);
  rect(x + 5*size, y - 10*size, size, size);
  rect(x - size, y - 10*size, size, size);
  rect(x - 2*size, y - 10*size, size, size);
  rect(x - 3*size, y - 10*size, size, size);
  rect(x - 4*size, y - 10*size, size, size);
  //9 above
  fill(232,183,141);
  rect(x, y - 9*size, size, size);
  rect(x + size, y - 9*size, size, size);
  rect(x + 2*size, y - 9*size, size, size);
  rect(x + 3*size, y - 9*size, size, size);
  rect(x + 4*size, y - 9*size, size, size);
  rect(x - size, y - 9*size, size, size);
  rect(x - 2*size, y - 9*size, size, size);
  fill(68, 59, 59);
  rect(x - 3*size, y - 9*size, size, size);
  rect(x - 4*size, y - 9*size, size, size);
  rect(x + 5*size, y - 9*size, size, size);
  //8 above
  fill(255);
  rect(x, y - 8*size, size, size);
  rect(x + size, y - 8*size, size, size);
  rect(x + 2*size, y - 8*size, size, size);
  fill(232,183,141);
  rect(x + 3*size, y - 8*size, size, size);
  fill(255);
  rect(x + 4*size, y - 8*size, size, size);
  rect(x + 5*size, y - 8*size, size, size);
  fill(255);
  rect(x - size, y - 8*size, size, size);
  fill(232,183,141);
  rect(x - 2*size, y - 8*size, size, size);
  rect(x - 3*size, y - 8*size, size, size);
  fill(68, 59, 59);
  rect(x - 4*size, y - 8*size, size, size);
  fill(0);
  rect(x - 5*size, y - 8*size, size, size);
  rect(x - 6*size, y - 8*size, size, size);
  //7 above
  fill(255);
  rect(x, y - 7*size, size, size);
  fill(0);
  rect(x + size, y - 7*size, size, size);
  rect(x + 2*size, y - 7*size, size, size);
  fill(255);
  rect(x + 3*size, y - 7*size, size, size);
  fill(0);
  rect(x + 4*size, y - 7*size, size, size);
  fill(255);
  rect(x + 5*size, y - 7*size, size, size);
  fill(255);
  rect(x - size, y - 7*size, size, size);
  rect(x - 2*size, y - 7*size, size, size);
  rect(x - 3*size, y - 7*size, size, size);
  fill(68, 59, 59);
  rect(x - 4*size, y - 7*size, size, size);
  fill(0);
  rect(x - 5*size, y - 7*size, size, size);
  rect(x - 6*size, y - 7*size, size, size);
  rect(x - 7*size, y - 7*size, size, size);
   //6 above
  fill(255);
  rect(x, y - 6*size, size, size);
  fill(0);
  rect(x + size, y - 6*size, size, size);
  rect(x + 2*size, y - 6*size, size, size);
  fill(255);
  rect(x + 3*size, y - 6*size, size, size);
  fill(0);
  rect(x + 4*size, y - 6*size, size, size);
  fill(255);
  rect(x + 5*size, y - 6*size, size, size);
  fill(255);
  rect(x - size, y - 6*size, size, size);
  fill(232,183,141);
  rect(x - 2*size, y - 6*size, size, size);
  rect(x - 3*size, y - 6*size, size, size);
  fill(0);
  rect(x - 4*size, y - 6*size, size, size);
  rect(x - 5*size, y - 6*size, size, size);
  rect(x - 6*size, y - 6*size, size, size);
  rect(x - 7*size, y - 6*size, size, size);
  //5 above
  fill(255);
  rect(x, y - 5*size, size, size);
  rect(x + size, y - 5*size, size, size);
  rect(x + 2*size, y - 5*size, size, size);
  fill(232,183,141);
  rect(x + 3*size, y - 5*size, size, size);
  fill(255);
  rect(x + 4*size, y - 5*size, size, size);
  fill(232,183,141);
  rect(x + 5*size, y - 5*size, size, size);
  fill(232,183,141);
  rect(x - size, y - 5*size, size, size);
  rect(x - 2*size, y - 5*size, size, size);
  rect(x - 3*size, y - 5*size, size, size);
  fill(0);
  rect(x - 4*size, y - 5*size, size, size);
  rect(x - 5*size, y - 5*size, size, size);
  rect(x - 6*size, y - 5*size, size, size);
  rect(x - 7*size, y - 5*size, size, size);
  //4 above
  fill(0);
  rect(x, y - 4*size, size, size);
  rect(x + size, y - 4*size, size, size);
  rect(x + 2*size, y - 4*size, size, size);
  rect(x + 3*size, y - 4*size, size, size);
  fill(232,183,141);
  rect(x + 4*size, y - 4*size, size, size);
  fill(0);
  rect(x + 5*size, y - 4*size, size, size);
  fill(232,183,141);
  rect(x - size, y - 4*size, size, size);
  rect(x - 2*size, y - 4*size, size, size);
  fill(0);
  rect(x - 3*size, y - 4*size, size, size);
  rect(x - 4*size, y - 4*size, size, size);
  rect(x - 5*size, y - 4*size, size, size);
  rect(x - 6*size, y - 4*size, size, size);
  //3 above
  fill(232,183,141);
  rect(x, y - 3*size, size, size);
  rect(x + size, y - 3*size, size, size);
  rect(x + 2*size, y - 3*size, size, size);
  rect(x + 3*size, y - 3*size, size, size);
  rect(x - size, y - 3*size, size, size);
  fill(0);
  rect(x + 4*size, y - 3*size, size, size);
  fill(0);
  rect(x - 2*size, y - 3*size, size, size);
  rect(x - 3*size, y - 3*size, size, size);
  rect(x - 4*size, y - 3*size, size, size);
  //2 above
  rect(x, y - 2*size, size, size);
  rect(x + size, y - 2*size, size, size);
  rect(x + 2*size, y - 2*size, size, size);
  rect(x + 3*size, y - 2*size, size, size);
  rect(x + 4*size, y - 2*size, size, size);
  rect(x + 5*size, y - 2*size, size, size);
  rect(x - size, y - 2*size, size, size);
  rect(x - 2*size, y - 2*size, size, size);
  rect(x - 3*size, y - 2*size, size, size);
  rect(x - 4*size, y - 2*size, size, size);
  //1 above
  rect(x, y - size, size, size);
  rect(x + size, y - size, size, size);
  rect(x + 2*size, y - size, size, size);
  rect(x + 3*size, y - size, size, size);
  rect(x + 4*size, y - size, size, size);
  rect(x + 5*size, y - size, size, size);
  rect(x - size, y - size, size, size);
  rect(x - 2*size, y - size, size, size);
  rect(x - 3*size, y - size, size, size);
  rect(x - 4*size, y - size, size, size);
  rect(x - 5*size, y - size, size, size);
  //center row
  rect(x, y, size, size);
  rect(x + size, y, size, size);
  rect(x + 2*size, y, size, size);
  rect(x + 3*size, y, size, size);
  rect(x + 4*size, y, size, size);
  rect(x + 5*size, y, size, size);
  rect(x - size, y, size, size);
  rect(x - 2*size, y, size, size);
  rect(x - 3*size, y, size, size);
  rect(x - 4*size, y, size, size);
  rect(x - 5*size, y, size, size);
  //1 below
  rect(x, y + size, size, size);
  rect(x + size, y + size, size, size);
  rect(x + 2*size, y + size, size, size);
  rect(x + 3*size, y + size, size, size);
  rect(x + 4*size, y + size, size, size);
  rect(x + 5*size, y + size, size, size);
  rect(x - size, y + size, size, size);
  rect(x - 2*size, y + size, size, size);
  rect(x - 3*size, y + size, size, size);
  rect(x - 4*size, y + size, size, size);
  rect(x - 5*size, y + size, size, size);
  //2 below
  rect(x, y + 2*size, size, size);
  rect(x + size, y + 2*size, size, size);
  rect(x + 2*size, y + 2*size, size, size);
  rect(x + 3*size, y + 2*size, size, size);
  rect(x + 4*size, y + 2*size, size, size);
  rect(x + 5*size, y + 2*size, size, size);
  rect(x - size, y + 2*size, size, size);
  rect(x - 2*size, y + 2*size, size, size);
  rect(x - 3*size, y + 2*size, size, size);
  rect(x - 4*size, y + 2*size, size, size);
  rect(x - 5*size, y + 2*size, size, size);
  //3 below
  rect(x, y + 3*size, size, size);
  rect(x + size, y + 3*size, size, size);
  rect(x + 2*size, y + 3*size, size, size);
  rect(x + 3*size, y + 3*size, size, size);
  rect(x + 4*size, y + 3*size, size, size);
  fill(232,183,141);
  rect(x + 5*size, y + 3*size, size, size);
  fill(0);
  rect(x - size, y + 3*size, size, size);
  rect(x - 2*size, y + 3*size, size, size);
  rect(x - 3*size, y + 3*size, size, size);
  rect(x - 4*size, y + 3*size, size, size);
  fill(232,183,141);
  rect(x - 5*size, y + 3*size, size, size);
  //4 below
  fill(36,37,134);
  rect(x + size, y + 4*size, size, size);
  rect(x + 2*size, y + 4*size, size, size);
  rect(x + 3*size, y + 4*size, size, size);
  rect(x - size, y + 4*size, size, size);
  rect(x - 2*size, y + 4*size, size, size);
  rect(x - 3*size, y + 4*size, size, size);
  //5 below
  rect(x + size, y + 4*size, size, size);
  rect(x + 2*size, y + 4*size, size, size);
  rect(x + 3*size, y + 4*size, size, size);
  rect(x - size, y + 4*size, size, size);
  rect(x - 2*size, y + 4*size, size, size);
  rect(x - 3*size, y + 4*size, size, size);
  //6 below
   rect(x + size, y + 5*size, size, size);
  rect(x + 2*size, y + 5*size, size, size);
  rect(x + 3*size, y + 5*size, size, size);
  rect(x - size, y + 5*size, size, size);
  rect(x - 2*size, y + 5*size, size, size);
  rect(x - 3*size, y + 5*size, size, size);
  //7 below
  rect(x + size, y + 6*size, size, size);
  rect(x + 2*size, y + 6*size, size, size);
  rect(x + 3*size, y + 6*size, size, size);
  rect(x - size, y + 6*size, size, size);
  rect(x - 2*size, y + 6*size, size, size);
  rect(x - 3*size, y + 6*size, size, size);
  //8 below
  rect(x + size, y + 7*size, size, size);
  rect(x + 2*size, y + 7*size, size, size);
  rect(x + 3*size, y + 7*size, size, size);
  rect(x - size, y + 7*size, size, size);
  rect(x - 2*size, y + 7*size, size, size);
  rect(x - 3*size, y + 7*size, size, size);
  //9 below
  fill(0);
  rect(x + size, y + 8*size, size, size);
  rect(x + 2*size, y + 8*size, size, size);
  rect(x + 3*size, y + 8*size, size, size);
  rect(x + 4*size, y + 8*size, size, size);
  rect(x - size, y + 8*size, size, size);
  rect(x - 2*size, y + 8*size, size, size);
  rect(x - 3*size, y + 8*size, size, size);
  rect(x - 4*size, y + 8*size, size, size);
}
void drawCampbellLeft(int x, int y, int s) {
  rectMode(CENTER);
  noStroke();
  //12 above
  fill(68, 59, 59);
  rect(x, y - 12*s, s, s);
  rect(x + s, y - 12*s, s, s);
  rect(x - s, y - 12*s, s, s);
  rect(x - 2*s, y - 12*s, s, s);
  rect(x - 3*s, y - 12*s, s, s);
  rect(x - 4*s, y - 12*s, s, s);
  //11 above
  rect(x, y - 11*s, s, s);
  rect(x + s, y - 11*s, s, s);
  rect(x + 2*s, y - 11*s, s, s);
  rect(x + 3*s, y - 11*s, s, s);
  rect(x - s, y - 11*s, s, s);
  rect(x - 2*s, y - 11*s, s, s);
  rect(x - 3*s, y - 11*s, s, s);
  rect(x - 4*s, y - 11*s, s, s);
  rect(x - 5*s, y - 11*s, s, s);
  //10 above
  rect(x, y - 10*s, s, s);
  rect(x + s, y - 10*s, s, s);
  rect(x + 2*s, y - 10*s, s, s);
  rect(x + 3*s, y - 10*s, s, s);
  rect(x + 4*s, y - 10*s, s, s);
  rect(x - s, y - 10*s, s, s);
  rect(x - 2*s, y - 10*s, s, s);
  rect(x - 3*s, y - 10*s, s, s);
  rect(x - 4*s, y - 10*s, s, s);
  rect(x - 5*s, y - 10*s, s, s);
  //9 above
  fill(232,183,141);
  rect(x, y - 9*s, s, s);
  rect(x + s, y - 9*s, s, s);
  rect(x + 2*s, y - 9*s, s, s);
  fill(68, 59, 59);
  rect(x + 3*s, y - 9*s, s, s);
  rect(x + 4*s, y - 9*s, s, s);
  fill(232,183,141);
  rect(x - s, y - 9*s, s, s);
  rect(x - 2*s, y - 9*s, s, s);
  rect(x - 3*s, y - 9*s, s, s);
  rect(x - 4*s, y - 9*s, s, s);
  fill(68, 59, 59);
  rect(x - 5*s, y - 9*s, s, s);
  //8 above
  fill(255);
  rect(x, y - 8*s, s, s);
  rect(x + s, y - 8*s, s, s);
  fill(232,183,141);
  rect(x + 2*s, y - 8*s, s, s);
  rect(x + 3*s, y - 8*s, s, s);
  fill(68, 59, 59);
  rect(x + 4*s, y - 8*s, s, s);
  fill(0);
  rect(x + 5*s, y - 8*s, s, s);
  rect(x + 6*s, y - 8*s, s, s);
  fill(255);
  rect(x - s, y - 8*s, s, s);
  rect(x - 2*s, y - 8*s, s, s);
  fill(232,183,141);
  rect(x - 3*s, y - 8*s, s, s);
  fill(255);
  rect(x - 4*s, y - 8*s, s, s);
  rect(x - 5*s, y - 8*s, s, s);
  //7 above
  fill(255);
  rect(x, y - 7*s, s, s);
  rect(x + s, y - 7*s, s, s);
  rect(x + 2*s, y - 7*s, s, s);
  rect(x + 3*s, y - 7*s, s, s);
  fill(68, 59, 59);
  rect(x + 4*s, y - 7*s, s, s);
  fill(0);
  rect(x + 5*s, y - 7*s, s, s);
  rect(x + 6*s, y - 7*s, s, s);
  rect(x + 7*s, y - 7*s, s, s);
  fill(0);
  rect(x - s, y - 7*s, s, s);
  rect(x - 2*s, y - 7*s, s, s);
  fill(255);
  rect(x - 3*s, y - 7*s, s, s);
  fill(0);
  rect(x - 4*s, y - 7*s, s, s);
  fill(255);
  rect(x - 5*s, y - 7*s, s, s);
   //6 above
  fill(255);
  rect(x, y - 6*s, s, s);
  rect(x + s, y - 6*s, s, s);
  fill(232,183,141);
  rect(x + 2*s, y - 6*s, s, s);
  rect(x + 3*s, y - 6*s, s, s);
  fill(0);
  rect(x + 4*s, y - 6*s, s, s);
  rect(x + 5*s, y - 6*s, s, s);
  rect(x + 6*s, y - 6*s, s, s);
  rect(x + 7*s, y - 6*s, s, s);
  fill(0);
  rect(x - s, y - 6*s, s, s);
  rect(x - 2*s, y - 6*s, s, s);
  fill(255);
  rect(x - 3*s, y - 6*s, s, s);
  fill(0);
  rect(x - 4*s, y - 6*s, s, s);
  fill(255);
  rect(x - 5*s, y - 6*s, s, s);
  //5 above
  fill(255);
  rect(x, y - 5*s, s, s);
  fill(232,183,141);
  rect(x + s, y - 5*s, s, s);
  rect(x + 2*s, y - 5*s, s, s);
  rect(x + 3*s, y - 5*s, s, s);
  fill(0);
  rect(x + 4*s, y - 5*s, s, s);
  rect(x + 5*s, y - 5*s, s, s);
  rect(x + 6*s, y - 5*s, s, s);
  rect(x + 7*s, y - 5*s, s, s);
  fill(255);
  rect(x - s, y - 5*s, s, s);
  rect(x - 2*s, y - 5*s, s, s);
  fill(232,183,141);
  rect(x - 3*s, y - 5*s, s, s);
  fill(255);
  rect(x - 4*s, y - 5*s, s, s);
  fill(232,183,141);
  rect(x - 5*s, y - 5*s, s, s);
  //4 above
  fill(0);
  rect(x, y - 4*s, s, s);
  fill(232,183,141);
  rect(x + s, y - 4*s, s, s);
  rect(x + 2*s, y - 4*s, s, s);
  fill(0);
  rect(x + 3*s, y - 4*s, s, s);
  rect(x + 4*s, y - 4*s, s, s);
  rect(x + 5*s, y - 4*s, s, s);
  rect(x + 6*s, y - 4*s, s, s);
  fill(0);
  rect(x - s, y - 4*s, s, s);
  rect(x - 2*s, y - 4*s, s, s);
  rect(x - 3*s, y - 4*s, s, s);
  fill(232,183,141);
  rect(x - 4*s, y - 4*s, s, s);
  fill(0);
  rect(x - 5*s, y - 4*s, s, s);
  //3 above
  fill(0);
  rect(x - 4*s, y - 3*s, s, s);
  fill(232,183,141);
  rect(x - 3*s, y - 3*s, s, s);
  rect(x - 2*s, y - 3*s, s, s);
  rect(x - s, y - 3*s, s, s);
  rect(x, y - 3*s, s, s);
  rect(x + s, y - 3*s, s, s);
  fill(0);
  rect(x + 2*s, y - 3*s, s, s);
  rect(x + 3*s, y - 3*s, s, s);
  rect(x + 4*s, y - 3*s, s, s);
  //2 above
  rect(x, y - 2*s, s, s);
  rect(x + s, y - 2*s, s, s);
  rect(x + 2*s, y - 2*s, s, s);
  rect(x + 3*s, y - 2*s, s, s);
  rect(x + 4*s, y - 2*s, s, s);
  rect(x - s, y - 2*s, s, s);
  rect(x - 2*s, y - 2*s, s, s);
  rect(x - 3*s, y - 2*s, s, s);
  rect(x - 4*s, y - 2*s, s, s);
  rect(x - 5*s, y - 2*s, s, s);
  //1 above
  rect(x, y - s, s, s);
  rect(x + s, y - s, s, s);
  rect(x + 2*s, y - s, s, s);
  rect(x + 3*s, y - s, s, s);
  rect(x + 4*s, y - s, s, s);
  rect(x + 5*s, y - s, s, s);
  rect(x - s, y - s, s, s);
  rect(x - 2*s, y - s, s, s);
  rect(x - 3*s, y - s, s, s);
  rect(x - 4*s, y - s, s, s);
  rect(x - 5*s, y - s, s, s);
  //center row
  rect(x, y, s, s);
  rect(x + s, y, s, s);
  rect(x + 2*s, y, s, s);
  rect(x + 3*s, y, s, s);
  rect(x + 4*s, y, s, s);
  rect(x + 5*s, y, s, s);
  rect(x - s, y, s, s);
  rect(x - 2*s, y, s, s);
  rect(x - 3*s, y, s, s);
  rect(x - 4*s, y, s, s);
  rect(x - 5*s, y, s, s);
  //1 below
  rect(x, y + s, s, s);
  rect(x + s, y + s, s, s);
  rect(x + 2*s, y + s, s, s);
  rect(x + 3*s, y + s, s, s);
  rect(x + 4*s, y + s, s, s);
  rect(x + 5*s, y + s, s, s);
  rect(x - s, y + s, s, s);
  rect(x - 2*s, y + s, s, s);
  rect(x - 3*s, y + s, s, s);
  rect(x - 4*s, y + s, s, s);
  rect(x - 5*s, y + s, s, s);
  //2 below
  rect(x, y + 2*s, s, s);
  rect(x + s, y + 2*s, s, s);
  rect(x + 2*s, y + 2*s, s, s);
  rect(x + 3*s, y + 2*s, s, s);
  rect(x + 4*s, y + 2*s, s, s);
  rect(x + 5*s, y + 2*s, s, s);
  rect(x - s, y + 2*s, s, s);
  rect(x - 2*s, y + 2*s, s, s);
  rect(x - 3*s, y + 2*s, s, s);
  rect(x - 4*s, y + 2*s, s, s);
  rect(x - 5*s, y + 2*s, s, s);
  //3 below
  rect(x, y + 3*s, s, s);
  rect(x + s, y + 3*s, s, s);
  rect(x + 2*s, y + 3*s, s, s);
  rect(x + 3*s, y + 3*s, s, s);
  rect(x + 4*s, y + 3*s, s, s);
  fill(232,183,141);
  rect(x + 5*s, y + 3*s, s, s);
  fill(0);
  rect(x - s, y + 3*s, s, s);
  rect(x - 2*s, y + 3*s, s, s);
  rect(x - 3*s, y + 3*s, s, s);
  rect(x - 4*s, y + 3*s, s, s);
  fill(232,183,141);
  rect(x - 5*s, y + 3*s, s, s);
  //4 below
  fill(36,37,134);
  rect(x + s, y + 4*s, s, s);
  rect(x + 2*s, y + 4*s, s, s);
  rect(x + 3*s, y + 4*s, s, s);
  rect(x - s, y + 4*s, s, s);
  rect(x - 2*s, y + 4*s, s, s);
  rect(x - 3*s, y + 4*s, s, s);
  //5 below
  rect(x + s, y + 4*s, s, s);
  rect(x + 2*s, y + 4*s, s, s);
  rect(x + 3*s, y + 4*s, s, s);
  rect(x - s, y + 4*s, s, s);
  rect(x - 2*s, y + 4*s, s, s);
  rect(x - 3*s, y + 4*s, s, s);
  //6 below
   rect(x + s, y + 5*s, s, s);
  rect(x + 2*s, y + 5*s, s, s);
  rect(x + 3*s, y + 5*s, s, s);
  rect(x - s, y + 5*s, s, s);
  rect(x - 2*s, y + 5*s, s, s);
  rect(x - 3*s, y + 5*s, s, s);
  //7 below
  rect(x + s, y + 6*s, s, s);
  rect(x + 2*s, y + 6*s, s, s);
  rect(x + 3*s, y + 6*s, s, s);
  rect(x - s, y + 6*s, s, s);
  rect(x - 2*s, y + 6*s, s, s);
  rect(x - 3*s, y + 6*s, s, s);
  //8 below
  rect(x + s, y + 7*s, s, s);
  rect(x + 2*s, y + 7*s, s, s);
  rect(x + 3*s, y + 7*s, s, s);
  rect(x - s, y + 7*s, s, s);
  rect(x - 2*s, y + 7*s, s, s);
  rect(x - 3*s, y + 7*s, s, s);
  //9 below
  fill(0);
  rect(x + s, y + 8*s, s, s);
  rect(x + 2*s, y + 8*s, s, s);
  rect(x + 3*s, y + 8*s, s, s);
  rect(x + 4*s, y + 8*s, s, s);
  rect(x - s, y + 8*s, s, s);
  rect(x - 2*s, y + 8*s, s, s);
  rect(x - 3*s, y + 8*s, s, s);
  rect(x - 4*s, y + 8*s, s, s);
}