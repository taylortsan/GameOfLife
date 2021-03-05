import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c] = new Life(r,c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public void draw () {
  background(70,148,90);
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(countNeighbors(r,c) == 3)
      {
        buffer[r][c] = true;
      }
      else if(countNeighbors(r,c) == 2 && buttons[r][c].getLife() == true)
      {
        buffer[r][c] = true;
      }
      else{
      buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(buffer[r][c] == true)
      {
        buttons[r][c].setLife(true);
      }
      else if(buffer[r][c] == false)
      {
        buttons[r][c].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(buttons[r][c].getLife() == true)
      {
        buffer[r][c] = true;
      }
      else if(buttons[r][c].getLife() == false)
      {
        buffer[r][c] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if(r>=0 && c>=0 && r<NUM_ROWS && c<NUM_COLS)
  {
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for(int r = row-1; r <= row+1; r++){
    for(int c = col-1; c <= col+1; c++){
      if(isValid(r,c) && buttons[r][c].getLife() == true)
      {
        neighbors++;
      }
    }
  }
  if(buttons[row][col].getLife() == true)
  {
    neighbors--;
  }
  return neighbors;
   
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
    {
      noStroke();
      fill(70,148,90);
    }
    else 
    {
      stroke(70,148,90);
      fill(117,217,144);
    }
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
