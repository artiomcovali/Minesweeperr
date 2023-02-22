//timer
PFont font;
PImage clock;
PImage flag;
PImage flagWhite;

import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;

final long SECOND_IN_MILLIS = 1000;
final long HOUR_IN_MILLIS = 36000000;

CountdownTimer timer;
int elapsedTime = 0;

String timeText = "";
final int timeTextX = 472, timeTextY = 550;  // upper left corner of displayed text
color timeTextColor = color(255, 0, 0);  // color of text (red: stopped, green: running)
int timeTextSeconds = 0, timeTextMinutes = 0; // the seconds and minutes to be displayed

//minesweeper

import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public boolean flagTemp = false;

void setup ()
{
    font = createFont("MyKidsHandwrittenBasic-gxxZY.ttf", 64);
    textFont(font);
    size(541, 615);
    textSize(64);
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
    
    
    timer = CountdownTimerService.getNewCountdownTimer(this).configure(SECOND_IN_MILLIS, HOUR_IN_MILLIS);
    updateTimeText();
    setMines();
    
}
public void setMines()
{
    //your code
}

public void draw ()
{
    background(229, 253, 209);
    fill(255,0,0);
    if(isWon() == true)
        displayWinningMessage();
     noStroke();
     
     fill(170, 196, 255,200);
     rect(360, 548, 178, 55, 150);
     
     image(clock,365,547, 55, 55);
     rect(4, 548, 178, 55, 150);
     image(flag,20,554, 45,45);
     fill(255);
    text(timeText, timeTextX, timeTextY + 24);
    
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
      if(mouseButton == RIGHT && clicked==false) {
        flagged = !flagged;
      }
      if(mouseButton == LEFT && flagged==false) {
        clicked = true;
        timer.start();
      }
      
        //your code here
    }
    public void draw () 
    {   
     
        if (flagged){
            fill(255, 113, 113);
            //fill(255);
            image(flagWhite,x,y, 32, 32);
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
//timer
void updateTimeText() {
  timeTextSeconds = elapsedTime % 60;
  timeTextMinutes = elapsedTime / 60;
  timeText = nf(timeTextMinutes, 2) + ':' + nf(timeTextSeconds, 2);
}

// this is called once per second when the timer is running
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  ++elapsedTime;
  updateTimeText();
}

// this will be called after the timer finishes running for an hour
void onFinishEvent(CountdownTimer t) {
  exit();
}
