class Wealth{
  
  //Fields
  float revTotal;
  float expTotal;
  
  int monthF;
  int dayF;
  String yearF;
  
  int monthT;
  int dayT;
  String yearT;
  
  float amtLeft;
  float ans;
  int budgetPeriodNumDays;
  
  //Constructor, takes in total revenue and total expenses
  Wealth(float r, float e){
    this.revTotal = r;
    this.expTotal = e;
  }
  
  //gets net income or loss for the budget period
  float getIncomeOrLoss(){
    ans = revTotal - expTotal;
    return ans;
  }
  
  //Caculates how much extra money there is per day
  float getExtraMoneyPerDay(){
    
    //gets month, day, year of 'From' date
    monthF = int(f.substring(0,2));
    dayF = int(f.substring(2,4));
    yearF = f.substring(4);
    
    //gets month, day, year of 'To' date
    monthT = int(t.substring(0,2));
    dayT = int(t.substring(2,4));
    yearT = t.substring(4);
    
    Date dateF = new Date(monthF, dayF, yearF);
    Date dateT = new Date(monthT, dayT, yearT);
    
    //Calculates the number of days between the 'From' and 'To' dates
    budgetPeriodNumDays = dateF.calculateDaysBetween(dateT);
    
    //Finds the amount left over per day
    amtLeft = ( revTotal - expTotal ) / budgetPeriodNumDays;
    
    return amtLeft;
  }
  
  
}
