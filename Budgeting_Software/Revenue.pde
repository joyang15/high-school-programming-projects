class Revenue{
  
  //Fields
  StringList amount;
  float totalRevenue;
  
  //Constructor, takes the array of amounts
  Revenue(StringList a){
    this.amount = a;
  }
  
  //Adds all revenues in the array
  float addRevenues(){
    for(int i = 0; i<this.amount.size(); i++){
      totalRevenue += float(this.amount.get(i));
    }
    return totalRevenue;
  }
}
