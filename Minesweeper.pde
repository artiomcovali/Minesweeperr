//timer
PFont font;
PImage clock;
PImage flag;
PImage flagWhite;
PImage bomb;

//Timer stopWatch = new Timer();
int timeTextX = 472, timeTextY = 550;

int timerStart = 0;
int offset;
boolean firstClick = true;
int mill;
int minutes;
int seconds;
int hundredths;

boolean stopped = true;
boolean continued = false;

//minesweeper

import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public boolean flagTemp = false;
int bombCount = 50;
int tileCount = 0;
boolean dead = false;

void setup ()
{
    font = createFont("Trebuchet MS", 50);
    textFont(font);
  size(553, 620);
    textSize(35);
    textAlign(CENTER,CENTER);
    clock = loadImage("clock.png");
    flag = loadImage("flag.png");
    flagWhite = loadImage("flagW.png");
    bomb = loadImage("bomb.png");
    
    
    
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r< NUM_ROWS; r++){
      for (int c = 0; c<NUM_COLS;c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    
    
   // setMines();
    
}
public void setMines()
{
      int rows = (int)(Math.random()*NUM_ROWS);
    int cols = (int)(Math.random()*NUM_COLS);
    int b = mines.size();
    while(b<bombCount)//your code
    {
        if(!mines.contains(buttons[rows][cols]))
            {
                mines.add(buttons[rows][cols]);
                rows = (int)(Math.random()*NUM_ROWS);
                cols = (int)(Math.random()*NUM_COLS);
                b++;
            }
        else
        {
            rows = (int)(Math.random()*NUM_ROWS);
            cols = (int)(Math.random()*NUM_COLS); 
        }    
    }
}
public void clearMines(int row, int col)
{
    for(int r=-1;r<2;r++)
    {
        for(int c=-1;c<2;c++)
        {
            mines.remove(buttons[row+r][col+c]);
        }
    }
}
public void draw ()
{
    background(229, 253, 209);
    if(!stopped) {
    mill=(millis()-timerStart);
    if(continued) mill += offset;
    
    seconds = mill / 1000;
    minutes = seconds / 60;
    seconds = seconds % 60;
    hundredths = mill / 10 % 100;
  }
    fill(255,0,0);
    if(isWon() == true)
        displayWinningMessage();
     noStroke();
     
     fill(170, 196, 255,200);
     rect(360, 552+5, 178, 55, 155+5);
     
     image(clock,365,552+5, 55, 55);
     rect(4, 552+5, 178, 55, 155);
     image(flag,20,556+5, 45,45);
     fill(255);
    //text(timeText, timeTextX, timeTextY + 24);
    text(nf(minutes,2)+":"+nf(seconds,2),timeTextX, timeTextY + 30);


    text(bombCount, timeTextX-370, timeTextY + 30);

    
}

public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
     for(int i=0;i<mines.size();i++)
        if(mines.get(i).isClicked()==false)
            mines.get(i).mousePressed();
    dead = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 550/NUM_COLS;
        height = 550/NUM_ROWS;
        
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed() 
    {
        if(firstClick == true&&mouseButton == LEFT && clicked == false && dead == false)
        {
            setMines();
             stopped = false;
            continued = true;
           timerStart = millis();
        offset = mill;
            if(mines.contains(buttons[r][c])||countBombs(r,c)>0)
            {
                clearMines(r,c);
                setMines();
            }
            firstClick = false;
            clearUseless();
            
            if(firstClick == false)
                mousePressed();
        }
      
         else if(mouseButton == RIGHT && clicked==false && dead == false ) {
       // stopWatch.unpause();
          if (bombCount > 0)
            marked = !marked;
          if (marked && bombCount > 0)
            bombCount--;
          if (!marked && bombCount > 0)
            bombCount++; 
            stopped = false;
            continued = true;
           timerStart = millis();
        offset = mill;

        
      }
        
        else if(mouseButton == LEFT && marked == false&&mines.contains(buttons[r][c])==true)
        {
            clicked = true;
            dead = true;
            stopped = true;
            continued = false;
            
            
        }
        else  if(mouseButton == LEFT && isMarked() == false && dead == false)
        {
            clicked=true;
            String myString = new String();
            if(countBombs(r,c)>0)
            {
                setLabel(myString + countBombs(r,c));//your code here
            }
            else
            {
                setLabel(myString); 
            }
            clearUseless();
        }
        else if(mouseButton == RIGHT && clicked == false && dead == false)
            marked = !marked;
        }
        public void clearUseless()
    {
             for(int a = -1; a<2; a++){
                for(int b = -1; b<2; b++){
                    if(isValid(r+a,c+b) && countBombs(r,c)==0 && buttons[r+a][c+b].marked==false){
                        if(buttons[r+a][c+b].isClicked() == false){
                            buttons[r+a][c+b].mousePressed();
                        }
                    }
                }
            }
            countCleared();
    }
    public void draw () 
    {    
         

      if(!stopped) {
    mill=(millis()-timerStart);
    if(continued) mill += offset;
    
    seconds = mill / 1000;
    minutes = seconds / 60;
    seconds = seconds % 60;
    hundredths = mill / 10 % 100;
  }
        if (marked)
            fill(203, 121, 247);
        else if(clicked && mines.contains(this)) {
           
            fill(255,0,0);
           
        }
        else if(clicked)
            fill(245, 244, 223);
        else 
            fill(170, 196, 255, 200);
        
        stroke(1);
        rect(x, y, width, height);
        fill(0);
         textSize(18);
        text(label,x+width/2,y+height/2);
          textSize(40);
        if (marked)
          image(flagWhite,x,y, 32, 32);
        if(dead == true)
        {
            displayLosingMessage();
            //image(bomb,x,y, 32, 32);
             if(clicked && mines.contains(this)) {
           
            image(bomb,x+3,y+1, 25, 25);
           
        }
        }
        
    }
    public void setLabel(String newLabel)
    {


        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS && c < NUM_COLS && r >=0 && c >=0)
            return true;//your code here
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i=-1;i<2;i++)
        {
            for(int j=-1;j<2;j++)
            {
                if(isValid(row+i,j+col)==true && mines.contains(buttons[row+i][col+j])==true)
                    numBombs++;
                }
            }   //your code here
        return numBombs;
    }
    public void countCleared()
    {
        int count = 0;
        for(int r=0;r<buttons.length;r++)
        {
            for(int c=0;c<buttons[r].length;c++)
                {
                    if(buttons[r][c].isClicked()==true)
                        count ++;
                }
        }
        if(count == ((NUM_COLS*NUM_ROWS)-bombCount))
            dead = true;
    }
}




//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
