/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void dropListMonth_click1(GDropList source, GEvent event) { //_CODE_:monthList:480925:
  mI = monthList.getSelectedIndex();
  
  //Covers the droplist when something is selected and the list is still down
  fill(66, 244, 185);
  stroke(66, 244, 185);
  rect(910, 60, 150, 100);

} //_CODE_:monthList:480925:

public void textfieldYear_change1(GTextField source, GEvent event) { //_CODE_:textfieldYear:416794:
  if (textfieldYear.getText().length() == 4){
    year = textfieldYear.getText();
  }
} //_CODE_:textfieldYear:416794:

public void buttonSavePic_click1(GButton source, GEvent event) { //_CODE_:buttonSavePic:472969:
  selectFolder("Select a folder to save image:", "folderSelected"); //Saves the pic in a folder

} //_CODE_:buttonSavePic:472969:

synchronized public void win_draw4(PApplet appc, GWinData data) { //_CODE_:revAndExpWindow:569562:
  appc.background(230);
} //_CODE_:revAndExpWindow:569562:

public void textfieldExpAmount_event(GTextField source, GEvent event) { //_CODE_:textfieldExpAmount:782231:
  //Lets the user type in an expense amount, the program will get the text when "Enter Expense" is clicked
} //_CODE_:textfieldExpAmount:782231:

public void textfieldRevAmount_event(GTextField source, GEvent event) { //_CODE_:textfieldRevAmount:361125:
//Lets the user type in a revenue amount, the program will get the text when "Enter Revenue" is clicked
} //_CODE_:textfieldRevAmount:361125:

public void textareaRevDescription_event(GTextArea source, GEvent event) { //_CODE_:textareaRevDescription:372782:
//Lets the user type in a description of the revenue, the program will get the text when "Enter Revenue" is clicked
} //_CODE_:textareaRevDescription:372782:

public void textareaExpDescription_event(GTextArea source, GEvent event) { //_CODE_:textareaExpDescription:707831:
  //Lets the user type in a description of the expense, the program will get the text when "Enter Expense" is clicked
} //_CODE_:textareaExpDescription:707831:

public void buttonEnterRev_event(GButton source, GEvent event) { //_CODE_:enterRev:596153:
  EnterRev = true; //enter revenue is clicked
  
  //Get the text entered in the revenue description, date, and amount boxes
  RevDescription = textareaRevDescription.getText();
  RevDate = textfieldDateRev.getText();
  RevAmount = textfieldRevAmount.getText();
  
  //Add the information from the text boxes for storage into StringLists
  rDescription.append(RevDescription);
  rDate.append(RevDate);
  rAmount.append(RevAmount);

  drawRevAndExp(); //will draw the information from the arrays into the calendar
  
  EnterRev = false; //reset enter revenue back to false
  
  //Set the text boxes to empty strings
  textareaRevDescription.setText("");
  textfieldDateRev.setText("");
  textfieldRevAmount.setText("");
  
} //_CODE_:enterRev:596153:

public void buttonEnterExp_event(GButton source, GEvent event) { //_CODE_:enterExp:686435:
  EnterExp = true; //enter expense is clicked
  
  //Get the text entered in the expense description, date, and amount boxes
  ExpDescription = textareaExpDescription.getText();
  ExpDate = textfieldDateExp.getText();
  ExpAmount = textfieldExpAmount.getText();
  
  //Add the information from the text boxes for storage into StringLists
  eDescription.append(ExpDescription);
  eDate.append(ExpDate);
  eAmount.append(ExpAmount);
  
  drawRevAndExp(); //will draw the information from the arrays into the calendar
  
  EnterExp = false; //reset enter expense back to false
  
  //Set the text boxes to empty strings
  textareaExpDescription.setText("");
  textfieldDateExp.setText("");
  textfieldExpAmount.setText("");
  
} //_CODE_:enterExp:686435:

public void textfieldDateRev_event(GTextField source, GEvent event) { //_CODE_:textfieldDateRev:861826:
  //Lets the user type in the date the revenue comes in, the program will get the text when "Enter Revenue" is clicked

} //_CODE_:textfieldDateRev:861826:

public void textfieldDateExp_event(GTextField source, GEvent event) { //_CODE_:textfieldDateExp:290131:
  //Lets the user type in the date the expense is paid, the program will get the text when "Enter Expense" is clicked

} //_CODE_:textfieldDateExp:290131:

public void showOnCal_click1(GButton source, GEvent event) { //_CODE_:buttonShowOnCal:819295:
  showOnCal = true;
  showNetWorth = true;
} //_CODE_:buttonShowOnCal:819295:

public void textfieldFromDate_change1(GTextField source, GEvent event) { //_CODE_:textfieldFromDate:344093:
  //Only get the text from the 'From' textbox when there's 8 numbers in it
  if(textfieldFromDate.getText().length() == 8){
    f = textfieldFromDate.getText();
  }
} //_CODE_:textfieldFromDate:344093:

public void textfieldToDate_change1(GTextField source, GEvent event) { //_CODE_:textfieldToDate:703121:
  //Only get the text from the 'To' textbox when there's 8 numbers in it
  if(textfieldToDate.getText().length() == 8){
    t = textfieldToDate.getText();
  }
} //_CODE_:textfieldToDate:703121:

public void buttonRestart_click1(GButton source, GEvent event) { //_CODE_:buttonRestart:598892:
  restarts = true; //restart is clicked
} //_CODE_:buttonRestart:598892:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  monthList = new GDropList(this, 912, 37, 141, 144, 5);
  monthList.setItems(loadStrings("list_480925"), 0);
  monthList.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  monthList.addEventHandler(this, "dropListMonth_click1");
  monthlabel = new GLabel(this, 822, 38, 80, 20);
  monthlabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  monthlabel.setText("Month:");
  monthlabel.setOpaque(false);
  textfieldYear = new GTextField(this, 1146, 35, 95, 24, G4P.SCROLLBARS_NONE);
  textfieldYear.setText("2019");
  textfieldYear.setPromptText("Type in year");
  textfieldYear.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  textfieldYear.setOpaque(true);
  textfieldYear.addEventHandler(this, "textfieldYear_change1");
  yearLabel = new GLabel(this, 1060, 38, 80, 20);
  yearLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  yearLabel.setText("Year:");
  yearLabel.setOpaque(false);
  buttonSavePic = new GButton(this, 1189, 950, 80, 30);
  buttonSavePic.setText("Save Picture");
  buttonSavePic.addEventHandler(this, "buttonSavePic_click1");
  revAndExpWindow = GWindow.getWindow(this, "Revenue and Expenses", 0, 0, 550, 950, JAVA2D);
  revAndExpWindow.noLoop();
  revAndExpWindow.addDrawHandler(this, "win_draw4");
  label2 = new GLabel(revAndExpWindow, 32, 184, 80, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Revenue");
  label2.setTextBold();
  label2.setOpaque(false);
  label3 = new GLabel(revAndExpWindow, 29, 459, 80, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Expenses");
  label3.setTextBold();
  label3.setOpaque(false);
  label4 = new GLabel(revAndExpWindow, 29, 547, 80, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Amount");
  label4.setOpaque(false);
  textfieldExpAmount = new GTextField(revAndExpWindow, 120, 545, 131, 27, G4P.SCROLLBARS_NONE);
  textfieldExpAmount.setPromptText("number only");
  textfieldExpAmount.setOpaque(true);
  textfieldExpAmount.addEventHandler(this, "textfieldExpAmount_event");
  revAmount = new GLabel(revAndExpWindow, 31, 266, 80, 20);
  revAmount.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  revAmount.setText("Amount");
  revAmount.setOpaque(false);
  textfieldRevAmount = new GTextField(revAndExpWindow, 125, 263, 131, 27, G4P.SCROLLBARS_NONE);
  textfieldRevAmount.setPromptText("number only");
  textfieldRevAmount.setOpaque(true);
  textfieldRevAmount.addEventHandler(this, "textfieldRevAmount_event");
  revDescription = new GLabel(revAndExpWindow, 31, 311, 80, 20);
  revDescription.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  revDescription.setText("Description");
  revDescription.setOpaque(false);
  textareaRevDescription = new GTextArea(revAndExpWindow, 125, 311, 160, 80, G4P.SCROLLBARS_NONE);
  textareaRevDescription.setPromptText("Type in the description of revenue");
  textareaRevDescription.setOpaque(true);
  textareaRevDescription.addEventHandler(this, "textareaRevDescription_event");
  expDescription = new GLabel(revAndExpWindow, 30, 591, 80, 20);
  expDescription.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  expDescription.setText("Description");
  expDescription.setOpaque(false);
  textareaExpDescription = new GTextArea(revAndExpWindow, 120, 593, 160, 80, G4P.SCROLLBARS_NONE);
  textareaExpDescription.setPromptText("Type in the description of expense");
  textareaExpDescription.setOpaque(false);
  textareaExpDescription.addEventHandler(this, "textareaExpDescription_event");
  enterRev = new GButton(revAndExpWindow, 208, 407, 80, 30);
  enterRev.setText("Enter revenue");
  enterRev.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  enterRev.addEventHandler(this, "buttonEnterRev_event");
  enterExp = new GButton(revAndExpWindow, 200, 700, 80, 30);
  enterExp.setText("Enter expense");
  enterExp.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  enterExp.addEventHandler(this, "buttonEnterExp_event");
  labelDateRev = new GLabel(revAndExpWindow, 32, 221, 80, 20);
  labelDateRev.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelDateRev.setText("Date");
  labelDateRev.setOpaque(false);
  labelDateExp = new GLabel(revAndExpWindow, 30, 505, 80, 20);
  labelDateExp.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelDateExp.setText("Date");
  labelDateExp.setOpaque(false);
  textfieldDateRev = new GTextField(revAndExpWindow, 126, 219, 131, 27, G4P.SCROLLBARS_NONE);
  textfieldDateRev.setPromptText("MMDDYYYY");
  textfieldDateRev.setOpaque(true);
  textfieldDateRev.addEventHandler(this, "textfieldDateRev_event");
  textfieldDateExp = new GTextField(revAndExpWindow, 121, 502, 131, 27, G4P.SCROLLBARS_NONE);
  textfieldDateExp.setPromptText("MMDDYYYY");
  textfieldDateExp.setOpaque(true);
  textfieldDateExp.addEventHandler(this, "textfieldDateExp_event");
  buttonShowOnCal = new GButton(revAndExpWindow, 351, 768, 116, 33);
  buttonShowOnCal.setText("Show On Calendar");
  buttonShowOnCal.setTextBold();
  buttonShowOnCal.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  buttonShowOnCal.addEventHandler(this, "showOnCal_click1");
  labelBudgetPeriod = new GLabel(revAndExpWindow, 25, 58, 102, 20);
  labelBudgetPeriod.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelBudgetPeriod.setText("Budget Period");
  labelBudgetPeriod.setTextBold();
  labelBudgetPeriod.setOpaque(false);
  labelFrom = new GLabel(revAndExpWindow, 27, 99, 58, 19);
  labelFrom.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelFrom.setText("From:");
  labelFrom.setOpaque(false);
  textfieldFromDate = new GTextField(revAndExpWindow, 75, 98, 133, 27, G4P.SCROLLBARS_NONE);
  textfieldFromDate.setPromptText("MMDDYYYY");
  textfieldFromDate.setOpaque(true);
  textfieldFromDate.addEventHandler(this, "textfieldFromDate_change1");
  textfieldToDate = new GTextField(revAndExpWindow, 266, 98, 133, 27, G4P.SCROLLBARS_NONE);
  textfieldToDate.setPromptText("MMDDYYYY");
  textfieldToDate.setOpaque(true);
  textfieldToDate.addEventHandler(this, "textfieldToDate_change1");
  labelTo = new GLabel(revAndExpWindow, 227, 99, 51, 20);
  labelTo.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelTo.setText("To:");
  labelTo.setOpaque(false);
  buttonRestart = new GButton(revAndExpWindow, 350, 816, 116, 30);
  buttonRestart.setText("Restart");
  buttonRestart.setTextBold();
  buttonRestart.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  buttonRestart.addEventHandler(this, "buttonRestart_click1");
  label1 = new GLabel(revAndExpWindow, 52, 888, 432, 43);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("NOTE: Keep the descriptions short to assure it will display properly on the calendar");
  label1.setOpaque(false);
  revAndExpWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GDropList monthList; 
GLabel monthlabel; 
GTextField textfieldYear; 
GLabel yearLabel; 
GButton buttonSavePic; 
GWindow revAndExpWindow;
GLabel label2; 
GLabel label3; 
GLabel label4; 
GTextField textfieldExpAmount; 
GLabel revAmount; 
GTextField textfieldRevAmount; 
GLabel revDescription; 
GTextArea textareaRevDescription; 
GLabel expDescription; 
GTextArea textareaExpDescription; 
GButton enterRev; 
GButton enterExp; 
GLabel labelDateRev; 
GLabel labelDateExp; 
GTextField textfieldDateRev; 
GTextField textfieldDateExp; 
GButton buttonShowOnCal; 
GLabel labelBudgetPeriod; 
GLabel labelFrom; 
GTextField textfieldFromDate; 
GTextField textfieldToDate; 
GLabel labelTo; 
GButton buttonRestart; 
GLabel label1; 
