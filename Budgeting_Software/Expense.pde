class Expense{
  //Fields
  StringList amount;
  float totalExpense;
  
  //Constructor, takes the array of amounts
  Expense(StringList a){
    this.amount = a;
  }
  
  //Adds all expenses in the array
  float addExpenses(){
    for(int i = 0; i<this.amount.size(); i++){
      totalExpense += float(this.amount.get(i));
    }
    return totalExpense;
  }
  
}
