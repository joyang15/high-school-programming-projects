class Date {
  int monthI; //The month index
  int day;
  String year; 
  
  int[] monthLength = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}; //day lengths of each month
  
  //Variables for calculating the day of the week
  int m;
  int d;
  String y;
  int c;
  int ylastint;
  int monthG;
  int dayOfWeekInt = 0;
  int s;
  
  //Variables to calculate the number of days between two dates
  int intDayA;
  int intDayB;
  int intMonthA;
  int intMonthB;
  int intYearA;
  int intYearB;
  int yearDiff;
  int yearInDays;
  int extraLeapDays;
  int checkYear;
  int endYear;
  int b;
  int n;
  int sumOfA;
  int sumOfB;
  
  //Date constructor, takes in the month index, day , and string of year
  Date(int m, int d, String y) {
    this.monthI = m;
    this.day = d;
    this.year = y;
  }

  //found the formula to calculate the day of the week on this website: https://cs.uwaterloo.ca/~alopez-o/math-faq/node73.html
  int calculateDayOfWeek() { 
    m = monthI+1; //the month is the index of the month+1
    d = day; 
    y = year; 
    c = int(y.substring(0, 2)); //takes the first two digits of the year
    ylastint = int(y.substring(2)); //takes the last two digits of the year
    monthG = m-2; //the formula needed uses the georgian calendar months, so march = 1, april = 2...jan = 11, so take the month and subtract two

    //if monthG is -1 (becuase of the calculation above), then the month is Jan, in the georgian calendar is 11
    if (monthG == -1) {
      monthG = 11;
      ylastint--; //treat Jan as part of the previous year, formula requirement
    }

    //if monthG is 0 (becuase of the calculation above), then the month is Feb, in the georgian calendar is 12
    if (monthG == 0) {
      monthG = 12;
      ylastint--; //treat Feb as part of the previous year, formula requirement
    }

    if (ylastint == -1) { //if like 2000, go back to 1999
      ylastint = 99;
      c--;
    }

    s = d + int(2.6*monthG - 0.2) - 2*c + ylastint + int(ylastint/4) + int(c/4); //part of the formula to calculate the day of the week

    if (monthG == 7 || monthG == 12) { //if statement to catch the weird thing int does on int(2.6*monthG - 0.2) for 7 and 12, which is the answer is one less than it's supposed to be
      s++;
    }

    dayOfWeekInt = s % 7; //the remainder will tell what day of the week the date is on (0 = Sunday...6 = Saturday)

    //if (yint % 4 == 0 && (monthG == 11 || monthG == 12)) { //If leap year but not Jan or Feb
    //  //dayOfWeekInt--;
    //}

    //if statements to check if the result of the modulo is negative, convert it back to the positive modulo
    if (dayOfWeekInt < 0) {

      if (dayOfWeekInt==-1) {
        dayOfWeekInt = 6;
      } else if (dayOfWeekInt==-2) {
        dayOfWeekInt = 5;
      } else if (dayOfWeekInt==-3) {
        dayOfWeekInt = 4;
      } else if (dayOfWeekInt==-4) {
        dayOfWeekInt = 3;
      } else if (dayOfWeekInt==-5) {
        dayOfWeekInt = 2;
      } else if (dayOfWeekInt==-6) {
        dayOfWeekInt = 1;
      }
    }
    return dayOfWeekInt;
  }

  int calculateDaysBetween(Date other) {

    //Gets the month, year, day of two dates
    intDayA = this.day;
    intDayB = other.day;
    intMonthA = int(this.monthI);
    intMonthB = int(other.monthI);
    intYearA = int(this.year);
    intYearB = int(other.year);
    yearDiff = intYearB - intYearA;

    //If the first date is jan on a leap year and the second date is on a leap year but not jan or feb or the first date is feb on a leap year and the second date is on a leap year but not jan or feb
    if ( (intYearA%4 == 0 && intMonthA == 1 && intYearB%4 == 0 && (intMonthB!=1 && intMonthA!=2)) || (intYearA%4 == 0 && intMonthA == 2 && intYearB%4 == 0 && (intMonthB != 1 && intMonthB != 2))) {
      yearDiff = intYearB-intYearA;
      yearInDays = (yearDiff*365) + 2;
      
      //If both dates in the same year, then don't add 2 days
      if (intYearA==intYearB) {
        yearInDays-=2;
      }
    }

    //if the first date is january on a leap year or the first date is febuary on a leap year
    else if (intYearA%4 == 0 && intMonthA == 1 || intYearA%4 == 0 && intMonthA == 2) {
      yearDiff = intYearB-intYearA;
      yearInDays = (yearDiff*365) + 1;

      //If both dates in the same year, then don't add a day
      if (intYearA==intYearB) {
        yearInDays--;
      }
    }

    //if the second date is not jan and not feb and on a leap year
    else if (intYearB%4 == 0 && (intMonthB != 1 && intMonthB != 2)) {
      yearDiff = intYearB-intYearA;
      yearInDays = (yearDiff*365) + 1;

      //If both dates in the same year, then don't add a day
      if (intYearA==intYearB) {
        yearInDays--;
      }
    } 
    
    else {
      yearDiff = intYearB-intYearA;
      yearInDays = yearDiff*365;

    }

    extraLeapDays = 0;
    checkYear = intYearA;
    endYear = intYearB;

    if (intYearA != intYearB) { //If the dates aren't on the same year
      
      if(checkYear%4 == 0){
        checkYear++;
      }
      
      if(endYear%4 == 0){
        endYear--;
      }
      
      //checks if any years in between the years are leap years
      for (int i = 0; i<endYear-intYearA-1; i++) {
        checkYear++;
        
        //if there are leap years in between the years then add a day to extraLeapDays
        if (checkYear%4 == 0 && checkYear != intYearB) {
          extraLeapDays++;
        }
      }
      yearInDays+=extraLeapDays; //Adds any extra leap year days to the year in days
    }
    
    //if the first and second year are the same and on a leap year
    else if(intYearA == intYearB && intYearA%4==0 ){
      
      //if the first month is jan or feb and the second month is march or later, then add a day
      if((intMonthA == 1||intMonthA == 2) && intMonthB>=3){
        yearInDays++;
      }
    }

    b = 0;
    n = 0;

    //adds the days of the months up to the first date month
    for (int i = 0; i<intMonthA-1; i++) {
      b += monthLength[i];
    }

    //adds the days of the months up to the second date month
    for (int i = 0; i<intMonthB-1; i++) {
      n += monthLength[i];
    }

    sumOfA = int(b) + int(intDayA); //adds the first date day to the sum of all the months up to the first date month
    sumOfB = int(n) + int(intDayB); //adds the second date day to the sum of all the months up to the second date month

    return sumOfB - sumOfA + yearInDays + 1; //final number of days
  }
}
