//timer
PFont font;
PImage clock;
PImage flag;
PImage flagWhite;

Timer stopWatch = new Timer();
final int timeTextX = 472, timeTextY = 550;

//minesweeper

import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public boolean flagTemp = false;
int bombCount = 20;
boolean dead = false;

void setup ()
{
    font = createFont("minefont.ttf", 64);
    textFont(font);
    size(545, 620);
    textSize(50);
    textAlign(CENTER,CENTER);
    clock = loadImage("clock.png");
    flag = loadImage("flag.png");
    flagWhite = loadImage("flagW.png");
    
    
    
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r< NUM_ROWS; r++){
      for (int c = 0; c<NUM_COLS;c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    
    
    setMines();
    
}
public void setMines()
{
    //your code
}

public void draw ()
{
    background(229, 253, 209);
    stopWatch.update();
    fill(255,0,0);
    if(isWon() == true)
        displayWinningMessage();
     noStroke();
     
     fill(170, 196, 255,200);
     rect(360, 552, 178, 55, 155);
     
     image(clock,365,552, 55, 55);
     rect(4, 552, 178, 55, 155);
     image(flag,20,556, 45,45);
     fill(255);
    //text(timeText, timeTextX, timeTextY + 24);
        text(stopWatch.minutes()+":"+stopWatch.seconds(),timeTextX, timeTextY + 28);

    text(bombCount, timeTextX-370, timeTextY + 28);

    
}

public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
       width = 550/NUM_COLS;
        height = 550/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
      if(mouseButton == RIGHT && clicked==false && dead == false ) {
        stopWatch.unpause();
          if (bombCount > 0)
            flagged = !flagged;
          if (flagged && bombCount > 0)
            bombCount--;
          if (!flagged && bombCount > 0)
            bombCount++;      

        
      }
      if(mouseButton == LEFT && flagged==false && dead == false) {
        clicked = true;
        stopWatch.unpause();
      }
      
        //your code here
    }
    public void draw () 
    {   
     
        if (flagged){
            fill(255, 113, 113);
            //bombCount--;
            //fill(255);
           // image(flagWhite,x,y, 32, 32);
        }
        // else if( clicked && mines.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill(255);
        else 
            fill(170, 196, 255, 200);
        stroke(1);
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        if (flagged)
          image(flagWhite,x,y, 32, 32);
          
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}


//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
class Timer {
  int timerStart = 0;
  int offset;
  
  int mill;
  int minutes;
  int seconds;
  int hundredths;
  
  boolean stopped = true;
  boolean continued = false;
  
  Timer() {
    
  }
  
  void update() {
    if(!stopped) {
  mill=(millis()-timerStart);
  if(continued) mill += offset;
  
  seconds = mill / 1000;
  minutes = seconds / 60;
  seconds = seconds % 60;
  hundredths = mill / 10 % 100;
    }
  }
  
  void pause() { stopped = true; }
  
  void unpause() {
    stopped = false;
    continued = true;
    timerStart = millis();
    
    offset = mill;
  }
  
  void reset() {
    stopped = false;
    continued = true;
    timerStart = millis();
  }
  
  int minutes() { return minutes; }
  int seconds() { return seconds; }
  int hundredths() { return hundredths; }
  
  boolean isPaused() { if (stopped) return true; else return false; }
} 
