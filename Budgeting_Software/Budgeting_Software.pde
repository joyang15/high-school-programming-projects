import g4p_controls.*;

//Sets variables to draw the calendar grid
float padding = 100;
float cellSize;
float n = 8;
int cols = 6;
int rows = 7;

String[] dayOfWeekNames = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
int[] numDaysInMonth = new int[12]; //An array to keep track of how many days are in each month
int mI; //index of the month
String year = "2019"; //default year so that there won't be an error
ArrayList <Point2D> dateCoordinates = new ArrayList <Point2D>(); //will store the coordinates of each day of the month

//Stores user input from the various textfields in the revenue section (date, amount, description)
StringList rDescription = new StringList();
StringList rDate = new StringList();
StringList rAmount = new StringList();
String RevDescription;
String RevDate;
String RevAmount;

//Stores user input from the various textfields in the expense section (date, amount, description)
StringList eDescription = new StringList();
StringList eDate = new StringList();
StringList eAmount = new StringList();
String ExpDescription;
String ExpDate;
String ExpAmount;

boolean EnterRev = false; //Keeps track when the 'enter revenue' button is clicked
boolean EnterExp = false; //Keeps track when the 'enter expense' button is clicked
boolean showOnCal = false; //Keeps track when the 'show on calendar' button is clicked
boolean showNetWorth = false; //variable that makes sure the output of the net worth and amount left per day are being calculated once
boolean restarts = false; //will be true when restart is clicked

//int numTextInACell = 0;

//Sets initial values for the dates of the budget period
String f = "00000000"; 
String t = "00000000";

//Initialize varibles that will store amount left per day and net worth
float amtLeft = 0;
float incomeOrLoss = 0;

//Initialize revenue, expense, and wealth
Revenue r;
Expense e;
Wealth w;

void setup() {

  size(1300, 1000);
  background(66, 244, 185);
  createGUI();
  
  cellSize = (width-2*padding)/n; //size of each cell/block
  
  //fills the numDaysInMonth array with days of the month
  for (int i = 0; i<12; i++) {
    if (i==1) {
      numDaysInMonth[i] = 28;
    } else if (i==0||i==2||i==4||i==6||i==7||i==9||i==11) {
      numDaysInMonth[i] = 31;
    } else {
      numDaysInMonth[i] = 30;
    }
  }
  drawGrid(); //Sets up calendar grid

}

void draw() {

  drawGrid(); //draws calendar grid
  drawDates(); //draws the dates in the calendar
  drawRevAndExp(); //draws the revenue and expenses text that were entered by the user into the calendar
  dateCoordinates.clear();
  restart();

}

void drawGrid() {
  float y = padding + 70; 
  float yz = 120; //initial y value for days of week grid
  float xz = 0; //initial x value for days of week grid
  
  //Creates days of week at the top of the calendar
  textSize(12);
  for (int i=0; i<7; i++) { 
    xz = padding + i*cellSize;
    fill(255);
    rect(xz, yz, cellSize, 50);
    fill(0);
    
    if(i==3){
      text(dayOfWeekNames[i], xz+35, yz+30);
    }
    
    else if(i==4){
      text(dayOfWeekNames[i], xz+40, yz+30);
    }
    
    else if(i==5){
      text(dayOfWeekNames[i], xz+50, yz+30);
    }
    
    else{
      text(dayOfWeekNames[i], xz+45, yz+30);
    }
   
  }
  
  //Draws calendar grid
  fill(255);
  stroke(0);
  for (int i=0; i<cols; i++) { 
    for (int j=0; j<rows; j++) {
      float x = padding + j*cellSize; //the cells are drawn in a row
      rect(x, y, cellSize, cellSize);
    }
    y+=cellSize; //moves down to next row
  }

  fill(0);//(68, 85, 255); //draws title at side
  textSize(40);
  //text("B\nU\nD\nG\nE\nT\n \nC\nA\nL\nE\nN\nD\nA\nR", 1170, 250);
  text("BUDGET CALENDAR", 300, 70);
  //text("CALENDAR", 450, 70);
  textSize(12);

}

//draws dates in the calendar
void drawDates() {

  int day = 1; //default day
  float y = padding +100;

  Date date = new Date(mI, day, year);//gets the month, day, year

  day = 0; //resets day back to zero
  int wd = date.calculateDayOfWeek(); //calculates the day of the week of the date so the program knows which day the month starts on
  
  //if leap year, then Feb has 29 days
  if (int(textfieldYear.getText())%4 == 0) { 
    numDaysInMonth[1] = 29;
  }
  
  //Draws the days
  for (int i=0; i<cols; i++) {
    for (int j=wd; j<rows; j++) { //j starts at wd so the program can start drawing the day at the right day of the week position
      float x = padding + j*cellSize + 5;
      fill(0);
      day++;
      text(str(day), x, y); //draws the day
      Point2D coordinate = new Point2D (0, day, x, y); //keeps track or x,y coordinates of each date and how many texts there are on that date
      dateCoordinates.add(coordinate); //adds the coordinates into an arrayList
      
      //stops the loop
      if (day >= numDaysInMonth[mI]) {
        i = 10;
        j = 10;
      }
      
    }
    y+=cellSize;
    wd = 0; //resets wd back to 0 so it can start drawing at the beginning of the row if in the first row it started drawing somewhere else in the first row
  }
}

//draws the revenue and expenses the user enters
void drawRevAndExp() {
  int addOnToCoorX = 20;
  int addOnToCoorY = 20;
  
  //if 'show on calendar' is clicked
  if (showOnCal == true) {
    
    for (int i = 0; i<dateCoordinates.size(); i++) {

      for (int j = 0; j<rDate.size(); j++) {
        
        //gets the revenue month, day, year in the array
        int mRev = int(rDate.get(j).substring(0, 2));
        int dRev = int(rDate.get(j).substring(2, 4));
        String yRev =  rDate.get(j).substring(4);

        //If the day, month, year the user entered in the revenue section matches the day, month, year the loop is currently on
        if ( dRev == dateCoordinates.get(i).d && mRev == mI+1 && int(yRev) == int(year) ) { 
          fill(0, 200, 0);
          
          //If there is more than one entry in a cell
          if(dateCoordinates.get(i).numTextInACell>=1){
            text(rDescription.get(j)+ ": $" + rAmount.get(j), dateCoordinates.get(i).x + addOnToCoorX, dateCoordinates.get(i).y + addOnToCoorY*(dateCoordinates.get(i).numTextInACell) ); //show description text on screen
            dateCoordinates.get(i).numTextInACell++;
          }
          
          //If it's the first entry in the cell
          else{
            text(rDescription.get(j)+ ": $" + rAmount.get(j), dateCoordinates.get(i).x + addOnToCoorX, dateCoordinates.get(i).y); //show description text on screen
            dateCoordinates.get(i).numTextInACell++;
          }

        }
        
      }
      
      for (int k = 0; k<eDate.size(); k++){
        
        //gets the expense month, day, year in the array
        int mExp = int(eDate.get(k).substring(0, 2));
        int dExp = int(eDate.get(k).substring(2, 4));
        String yExp =  eDate.get(k).substring(4);
        
        //If the day, month, year the user entered in the expense section matches the day, month, year the loop is currently on
        if ( dExp == dateCoordinates.get(i).d && mExp == mI+1 && int(yExp) == int(year) ) { //If the day, month, year entered matches the day, month, year the loop is currently on
          fill(200, 0, 0);
          if(dateCoordinates.get(i).numTextInACell>=1){
            text(eDescription.get(k)+ ": $" + eAmount.get(k), dateCoordinates.get(i).x + addOnToCoorX, dateCoordinates.get(i).y + addOnToCoorY*(dateCoordinates.get(i).numTextInACell) ); //show description text on screen
            dateCoordinates.get(i).numTextInACell++;
          }
          
          else{
            text(eDescription.get(k)+ ": $" + eAmount.get(k), dateCoordinates.get(i).x + addOnToCoorX, dateCoordinates.get(i).y); //show description text on screen
            dateCoordinates.get(i).numTextInACell++;
          }

        } 
        
      }
      EnterRev = false; //reset
      EnterExp = false; //reset
    }
    //if 'show calendar' is clicked and haven't calculated net worth and money left over per day yet:
    if (showNetWorth){
      
      //Makes sure the calculations aren't written on top of another when it outputs to the screen
      fill(66, 244, 185);
      stroke(66, 244, 185);
      rect(1070, 300, 200, 400);
      
      //gets revene and expense arrays
      Revenue r = new Revenue(rAmount);
      Expense e = new Expense(eAmount);
      
      //finds total revenue and expenses
      float rTotal = r.addRevenues();
      float eTotal = e.addExpenses();
      
      Wealth w = new Wealth(rTotal, eTotal); //takes in total revenue and total expense
      amtLeft = roundAny(w.getExtraMoneyPerDay(),2); //calculates how much money is left per day for the desired budget period
      incomeOrLoss = roundAny(w.getIncomeOrLoss(),2); //calculates how much in total is left over in the budget period
      showNetWorth = false; //sets to false to make sure it won't be calculated again
    }
    
    //if net worth and money left over is already calculated, then output to the screen the data
    else if (!showNetWorth){
      fill(0);
      textSize(15);
      text("For the budget period \n" + f.substring(0,2) + "/" + f.substring(2,4) + "/" + f.substring(4) + " - " + t.substring(0,2) + "/" + t.substring(2,4) + "/" + t.substring(4) , 1070, 400 );
      text("Amount left per day:\n$" + str(amtLeft), 1070, 500 );
      text("Total net income or loss:\n$" + str(incomeOrLoss), 1070, 550);

    }

  }

}

//rounds numbers to any number of decimal places
float roundAny(float x, int d){
  float whole = x*pow(10, d);
  int roundWhole = round(whole);
  float roundedValue = roundWhole/pow(10, d);
  return roundedValue;
  
}

void restart(){
  
  //if restart is clicked
  if (restarts){
    showOnCal = false;
    
    //clear all the StringList values
    rDescription.clear();
    rDate.clear();
    rAmount.clear();
    eDescription.clear();
    eDate.clear();
    eAmount.clear();
    clear();
    
    //reset screen for the calendar
    size(1300, 1000);
    background(66, 244, 185);
    drawGrid();

  }
  restarts = false; //reset is set back to false
}

//Gets the folder that the user selects to save the picture to
void folderSelected(File selection) {
  if (selection == null) {
    //catches if the choose folder window is closed or cancel is pressed
  } 
  
  else {
    String dir = selection.getPath() + "\\";
    save(dir + monthList.getSelectedText() + "-" + year  +".jpeg");
  }
  
}
