//Global Variables
int[][] cellsNow;
int[][] cellsNext;

//0 = teeth
//1 = plaque
//2 = food
//3 = cavity
//4 = toothpaste

int n = 100; //Number of squares per row and column
float cellSize;
float padding = 10;
float blinksPerSecond = 0.5;

//Plaque colour
int rPlaque = 255;
int gPlaque = 255;
int bPlaque = 147;

int generation = 0;
boolean brush = true; //Can set whether a person brushes their teeth or not

void setup(){
  size(1000,1000);
  cellSize = (width-2*padding)/n;
  
  //Set array size for cellsNow and cellsNext
  cellsNow = new int[n][n];
  cellsNext = new int[n][n];
  
  set1stGenValues(); //Set the first generation
  frameRate( blinksPerSecond );
}

void draw() {  
  background(255,255,0);
  float y = padding;

  for(int i=0; i<n; i++) {
    
    for(int j=0; j<n; j++){
      
      float x = padding + j*cellSize;
    
       if (cellsNow[i][j]==0) //Fills the cell white, representing the healthy parts of teeth
         fill(255);
      
      else if(cellsNow[i][j]==1) //Fills the cell yellow, representing plaque
         fill(rPlaque, gPlaque, bPlaque);
      
      else if(cellsNow[i][j]==2) //Fills the cell green, representing food
         fill(0, 255, 0);
      
      else if(cellsNow[i][j]==3) //Fills the cell black, representing cavities
         fill(0);
      
      else if(cellsNow[i][j]==4) //Fills the cell blue, representing toothpaste
         fill(0,0,255);
      
      rect(x, y, cellSize, cellSize); //Draws the cell

    }
  
    y+=cellSize;
    
  }
  setNextValues(); //Sets the next values for next generations
  generation++; //Keeps track of the generation number
}

//Sets first generation
void set1stGenValues() {
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++){
      int x = round(random(0,1000)); //generates random number for probablity of a cell becoming green
     
     //10% chance of becoming food
      if (x<10)
        cellsNow[i][j] = 2;
      
     //Otherwise, it will become a healthy part of teeth
      else
        cellsNow[i][j] = 0;
    }
  }
}

//Number of neighbouring healthy cells
int countHealthyTeeth(int i, int j ){
  int countHealthy = 0;
  
  for(int a = -1; a<=1;a++){
    for(int b = -1; b<=1;b++){
      try{
      if(cellsNow[i + a][j + b] == 0 &&(b !=0 || a !=0)){
        countHealthy++;
      }

    }
    catch(IndexOutOfBoundsException e){
    }
    }
  }
  return countHealthy;
}

//Number of neighbouring plaque cells
int countSurroundingPlaque(int i, int j ){
  int countPlaque = 0;
  
  for(int a = -1; a<=1;a++){
    for(int b = -1; b<=1;b++){
      try{
      if(cellsNow[i + a][j + b] == 1 &&(b !=0 || a !=0)){
        countPlaque++;
      }

    }
    catch(IndexOutOfBoundsException e){
    }
    }
  }
  return countPlaque;
}

//Number of neighbouring food cells
int countSurroundingFood(int i, int j ){
  int countFood = 0;
  
  for(int a = -1; a<=1;a++){
    for(int b = -1; b<=1;b++){
      try{
      if(cellsNow[i + a][j + b] == 2 &&(b !=0 || a !=0)){
        countFood++;
      }
      //else{
      //  count=count;
      //}
    }
    catch(IndexOutOfBoundsException e){
    }
    }
  }
  return countFood;
}

//Number of neighbouring cavity cells
int countSurroundingCavities(int i, int j ){
  int countCavities = 0;
  
  for(int a = -1; a<=1;a++){
    for(int b = -1; b<=1;b++){
      try{
      if(cellsNow[i + a][j + b] == 3 &&(b !=0 || a !=0)){
        countCavities++;
      }

    }
    catch(IndexOutOfBoundsException e){
    }
    }
  }
  return countCavities;
}

//Number of neighbouring toothpaste cells
int countSurroundingToothpaste(int i, int j ){
  int countToothpaste = 0;
  
  for(int a = -1; a<=1;a++){
    for(int b = -1; b<=1;b++){
      try{
      if(cellsNow[i + a][j + b] == 4 &&(b !=0 || a !=0)){
        countToothpaste++;
      }
      //else{
      //  count=count;
      //}
    }
    catch(IndexOutOfBoundsException e){
    }
    }
  }
  return countToothpaste;
}

//Sets values for the next generations
void setNextValues(){
  for(int i = 0; i<n-1; i++){
    for(int j = 0; j<n-1;j++){
      
      int plaqueNeighbours = countSurroundingPlaque(i,j); //number of surrounding plaque cells
      int foodNeighbours = countSurroundingFood(i,j); //number of surrounding food cells
      
      int x = round(random(0,100)); //Generates random number for probability of creating cavity and toothpaste cell
      int y = round(random(0,1000)); ////Generates random number for probability of creating food cell
      
      //If current cell is healthy
      if (cellsNow[i][j]==0){
        
        //If there is more than one surrounding food cells or there is more than two surrounding plaque cells
        if(foodNeighbours>=1||plaqueNeighbours>=2){
          cellsNext[i][j] = 1; //Then this current cell in the next generation will be plaque
        }
        
        //Every five generations and if y is less then or equal to 2
        else if(generation%5==0 && y<=2){
          cellsNext[i][j] = 2; //Then create food cell
        }
        
        //Otherwise create healthy cell
        else{
          cellsNext[i][j] = 0;
        }

      }
      //If the current cell is plaque
      else if (cellsNow[i][j]==1){ 
        //Every 11th generation and if x is less then or equal to 2
        if(generation%11==0 && x<=2){
          cellsNext[i][j] = 3; //Then create cavity cell
          
        }

        else{
          cellsNext[i][j]=1;
        }
     
        }
        
     //If the current cell is food
      else if (cellsNow[i][j]==2){
        if(plaqueNeighbours>=4){ //If the surrounding plaque cells are greater then or equal to 4
          cellsNext[i][j] = 1; //Then create plaque cell
      }
        //Otherwise create food cell
        else{
          cellsNext[i][j]=2;
        }
        
      }
      
      //If the current cell is toothpaste
      else if (cellsNow[i][j]==4){
        cellsNext[i][j]=0;//Then next cell is healthy

      }
      //If brush is true, x is less then or equal to 90, the next cell is not a cavity, and only every 3rd generation
      if (brush && x<=90 && cellsNext[i][j] != 3 && generation%3 == 0){
         cellsNext[i][j]=4; //Create toothpaste cell
      }

    }
  }
  //Moves numbers from cellNext to cellNow to draw the next generation
 for(int i=0; i<n; i++){ 
  for(int j=0; j<n; j++) {
    cellsNow[i][j] = cellsNext[i][j];
  }
     
 }

  }
