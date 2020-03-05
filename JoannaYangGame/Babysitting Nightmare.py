from tkinter import *
from math import *
from time import *
from random import *

###### BABYSITTING NIGHTMARE ######
#SPECIAL THANKS TO DREAMWORKS FOR CREATING BOSS BABY

root = Tk()
s = Canvas(root, width=1000, height=700, background="white")
s.pack()

#Sets the values for the game
def setInitialValues():
    global xMouse, yMouse, mouseDown
    global xSponge, ySponge, spongeImage, sponge, spongeBeingMoved, spongeWiped
    global xSplat, ySplat, splatImage, splat, numSplats, splatSpeed
    global xSplatHealth, ySplatHealth, splatHealth, numSplatLives
    global qPressed, running, pastBoundary
    global gamePoints, score
    global heartImage
    global waterBarEnd, waterMove, w, warning

    xSponge = 800
    ySponge = 600
    sponge = 0
    spongeWiped = "none"

    xSplat = []
    ySplat = []
    splat = []
    splatSpeed = []

    #Sets different number of splats for each level
    if level == "easy":
        numSplats = 30
    if level == "medium":
        numSplats = 50
    if level == "hard":
        numSplats = 90
        
    gamePoints = 0
    score = 0
    numS = 0

    splatHealth = [0, 0, 0]
    xSplatHealth = [160, 200, 240]
    ySplatHealth = [40, 40, 40]
    numSplatLives = 3

    waterBarEnd = 400
    waterMove = 10
    w = 0
    warning = 0

    #Fills the arrays with random numers
    for i in range(0, numSplats):
        xSplat.append(randint(20, 980))
        ySplat.append(randint(-1000, -100))
        splat.append(0)

        #Sets different speeds depending on the level
        if level == "easy":
            splatSpeed.append(randint(1, 2))
        if level == "medium":
            splatSpeed.append(randint(1, 4))
        if level == "hard":
            splatSpeed.append(randint(1, 10))

    #Imports images needed for playing the game    
    spongeImage = PhotoImage(file = "sponge1.gif")
    splatImage = PhotoImage(file = "orangesplat veryverysmall1.gif")
    heartImage = PhotoImage(file = "heart1.gif")

    spongeBeingMoved = False
    mouseDown = False
    qPressed = False
    running = True
    pastBoundary = False
    
    xMouse = 800
    yMouse = 600

#A function that returns the distance between to objects
def distFormula(x1, y1, x2, y2):
    return sqrt((x2-x1)**2 + (y2-y1)**2)

#Draws the sponge used for cleaning splats
def drawSponge():
    global sponge
    s.delete(sponge)
    sponge = s.create_image(xSponge, ySponge, image = spongeImage, anchor = CENTER)
    s.update()

#Draws the splats by using arrays
def drawSplat():
    global splat
    for i in range(numSplats):
        splat[i] = s.create_image(xSplat[i], ySplat[i], image = splatImage, anchor = CENTER)
    s.update()

#Update the position of the splat to get it to move down the screen
def updateSplatPosition():
    for i in range(0, len(splat)):
        ySplat[i] = ySplat[i] + splatSpeed[i]

#Deletes the splat as it is moving down the screen so it doesn't leave a streak behind
def deleteMovingSplat():
    for i in range(0, len(splat)):
        s.delete(splat[i])

#Deletes the splat when the distance between sponge and splat is less than 50 pixles
def deleteSplat(i):
    global xSplat, ySplat, gamePoints, waterBarEnd
    if distFormula(xSponge, ySponge, xSplat[i], ySplat[i])<50:
        s.delete(splat[i])
        
        #The game points go up by 10 and the end of the water bar moves to the left to decrease the amount of water in the sponge
        gamePoints = gamePoints + 10
        waterBarEnd = waterBarEnd - waterMove

#Calculates the distance between sponge and mouse, if distance less than 50 pixles, then return TRUE
def mouseInsideSponge():
    distBetweenSpongeAndMouse = distFormula(xSponge, ySponge, xMouse, yMouse)

    if distBetweenSpongeAndMouse<50:
        return True
    else:
        return False

#Gets the distance between sponge and a splat in the array, if the distance between sponge and splat is less than 10, then return the index of the splat, otherwise return NONE
def detectSpongeOnSplat():

    for splati in range(numSplats):
        distBetweenSpongeAndSplat = distFormula(xSponge, ySponge, xSplat[splati], ySplat[splati])

        if distBetweenSpongeAndSplat <10:
            return splati

    return "none"

#Draws the hearts for life stats        
def drawSplatHealth():
    global xSplatHealth, ySplatHealth, splatHealth
    for i in range(3):
        splatHealth[i] = s.create_image(xSplatHealth[i], ySplatHealth[i], image = heartImage, anchor = CENTER)

#If the number of lives is 0, the game stops running
def updateSplatHealth():
    global running
    if numSplatLives == 0:
        running = False

#Deletes a heart 
def deleteSplatHealth():
    global pastBoundary, numSplatLives, splat, numSplats
    pastBoundary = indexOfSplatPastBoundary()
    
    if pastBoundary == True and numSplatLives>=1: #Only deletes it when the splat is past the boundary and the number of lives is greater than or equal to 1
        i = (len(splatHealth))-1
        s.delete(splatHealth[i])#Deletes the actual heart image
        splatHealth.remove(splatHealth[i])#Removes image from array
        xSplatHealth.remove(xSplatHealth[i])#Removes x coordinate of image from array
        ySplatHealth.remove(ySplatHealth[i])#Removes y coordinate of image from array
        numSplatLives = numSplatLives - 1 #Subtracts a life
        pastBoundary = False
    else:
        pastBoundary = False

#Finds the index of the splat close to the bottom of the screen and returns TRUE or FALSE
def indexOfSplatPastBoundary():
    global numSplats
    for splati in range(len(splat)):
        distBetweenSplatAndBottom = distFormula(xSplat[splati], 710, xSplat[splati], ySplat[splati])
        if 11>distBetweenSplatAndBottom>-1: #If distance between splat and bottom is between 11 and -1 pixles
            s.delete(splat[splati]) #Delete splat image
            splat.remove(splat[splati])#Removes splat image from array
            xSplat.remove(xSplat[splati])#Removes x coordinate of splat from array
            ySplat.remove(ySplat[splati])#Removes y coordinate of splat from array
            numSplats = numSplats - 1
            return True

    return False

#Outputs current score on screen
def updateScore():
    global score
    score = s.create_text(800,40,text = str(gamePoints), font = "Arial 18", fill = "red")

#Deletes previous score on screen
def deleteScore():
    s.delete(score)

#Outputs the number of splats on the screen
def updateNumSplats():
    global numS
    numS = s.create_text(800,80,text = str(numSplats), font = "Arial 18", fill = "red")

#Deletes the number of splats on the screen
def deleteNumSplats():
    s.delete(numS)

#Outputs warning text on the screen
def warningText():
    global warning
    s.delete(warning)
    warning = s.create_text(500,230,text = "Clean the sponge in the water bucket!", font = "Arial 14", fill = "red")

#Deletes warning text on the screen
def deleteWarningText():
    global warning
    s.delete(warning)

#Draws the current state of the water bar
def drawWaterBarLeft():
    global w
    s.delete(w)
    w = s.create_rectangle(150, 60, waterBarEnd, 90, fill = "blue", outline = "blue")

#Checks the distance between sponge and water bucket
def checkSpongeOverWater():
    global waterBarEnd, distBetweenSpongeAndWater
    distBetweenSpongeAndWater = distFormula(xSponge, ySponge, 800, 500)
    if distBetweenSpongeAndWater<=20: #If distance between sponge and water bucket is less than 20 pixles, then the water bar becomes full again
        waterBarEnd = 400

#Determing mouse click during actual game play
def mouseClickHandler(event):
    global xMouse, yMouse, spongeBeingMoved, mouseDown

    xMouse = event.x
    yMouse = event.y

    mouseDown = True #The mouse is clicked down

    if mouseInsideSponge() == True: #If mouse is inside sponge, then sponge is being moved
        spongeBeingMoved = True

#Determing mouse motion during actual game play
def mouseMotionHandler(event):
    global xMouse, yMouse, xSponge, ySponge, mouseDown, spongeWiped
    xMouse = event.x
    yMouse = event.y

    if mouseDown == True and spongeBeingMoved == True: #Only run if mouse is clicked down and sponge is being moved
        xSponge = xMouse #Set xSponge to xMouse
        ySponge = yMouse #Set ySponge to yMouse
        drawSponge()#Calls drawSponge procedure to draw sponge

        spongeWiped = detectSpongeOnSplat()#The index of the splat the sponged wipe is assigned to spongeWiped

#When mouse is released, mouse is not clicked down and sponge is not being moved
def mouseReleaseHandler(event):
    global mouseDown, spongeBeingMoved

    mouseDown = False
    spongeBeingMoved = False

#If q or Q is pressed, then stop the game    
def keyDownHandler(event):
    global qPressed, running
        
    if event.keysym == "q" or event.keysym == "Q":
        running = False

#Creates introduction screen
def introScreen():
    global page, intro, firstScreen
    page = 1
    intro = PhotoImage(file = "Babysitting Nightmare Intro.gif")
    firstScreen = s.create_image(0, 0, image = intro, anchor = NW)
    s.bind("<Button-1>", mouseClickHandler2)

#If play button is pressed, then show difficulty screen
def playButtonPressed():
    global page, difficulty, difficultySelect

    page = 2

    difficulty = PhotoImage(file = "Babysitting Nightmare Difficulty.gif")
    difficultySelect = s.create_image(0,0, image = difficulty, anchor = NW)

    s.bind("<Button-1>", mouseClickHandler3)

#If instructions button is pressed, then show instructions screen
def instructionsButtonPressed():
    global page, instruct, instructions
    page = 3
    instruct = PhotoImage(file = "Babysitting Nightmare Instructions.gif")
    instructions = s.create_image(0,0, image = instruct, anchor = NW)
    s.bind("<Button-1>", mouseClickHandler2)

#Responsible for mouse clicks in intro screen and instructions screen
#NOTE: event.x and event.y were set to different variables then mouseclickHandler(4) to ensure no buttons that work on these pages work during game play and on the other screens
def mouseClickHandler2(event):
    global xMouseC, yMouseC, level, page

    xMouseC = event.x
    yMouseC = event.y

    if page == 1: #Determines which button the mouse clicks on the intro screen
        if 420 <= xMouseC <=560 and 270 <= yMouseC <= 340:
            playButtonPressed()#Go to difficulty screen
        if 320 <= xMouseC <=650 and 380 <= yMouseC <= 460:
            instructionsButtonPressed()#Go to instructions screen

    if page == 3: #Determines which button the mouse clicks on the instructions screen
        if 640 <= xMouseC <= 940 and 565 <= yMouseC <= 665:
            s.delete(firstScreen, instructions)
            introScreen()#Go to intro screen

#Responsible for mouse clicks in difficulty screen
#NOTE: event.x and event.y were set to different variables then mouseclickHandler(4) to ensure no buttons that work on these pages work during game play and on the other screens
def mouseClickHandler3(event):
    global xMouseC, yMouseC, level, page
    xMouseC = event.x
    yMouseC = event.y
    if page == 2: #Determines which button the mouse clicks on the difficulty screen and sets the level
        if 350 <= xMouseC <= 650 and 200 <= yMouseC <= 250:
            level = "easy"
            s.delete(firstScreen,difficultySelect)
            runGame()
        if 350 <= xMouseC <= 650 and 310 <= yMouseC <= 390:
            level = "medium"
            s.delete(firstScreen,difficultySelect)
            runGame()
        if 350 <= xMouseC <= 650 and 425 <= yMouseC <= 505:
            level = "hard"
            s.delete(firstScreen,difficultySelect)
            runGame()
            
#Responsible for mouse clicks in win screen and lose screen
#NOTE: event.x and event.y were set to different variables then mouseclickHandler(2)(3) to ensure no buttons that work on these pages work during game play and on the other screens
def mouseClickHandler4(event):
    global xMouseE, yMouseE, page
    xMouseE = event.x
    yMouseE = event.y
    if page == 4:#Determines which button the mouse clicks on the win screen
        if 635 <= xMouseE <= 940 and 525 <= yMouseE <= 600: 
            root.destroy()
        if 65 <= xMouseE <= 370 and 525 <= yMouseE <= 600:
            playButtonPressed()
    if page == 5:#Determines which button the mouse clicks on the lose screen
        if 630 <= xMouseE <= 915 and 480 <= yMouseE <= 560:
            root.destroy()
        if 60 <= xMouseE <= 365 and 480 <= yMouseE <= 560:
            playButtonPressed()

#Called when the game is over/ player loses
def gameOver():
    global winScreen, loseScreen, page
    if numSplats == 0: #If number of splats is 0, then output win screen
        page = 4
        winScreen = PhotoImage(file = "Babysitting Nightmare Win.gif")
        winS = s.create_image(0, 0, image = winScreen, anchor = NW)
        s.bind("<Button-1>", mouseClickHandler4)
        print("Win!")

    elif numSplatLives == 0: #If lives is 0, then output lose screen
        page = 5
        loseScreen = PhotoImage(file = "Babysitting Nightmare Lose.gif")
        loseS = s.create_image(0, 0, image = loseScreen, anchor = NW)
        s.bind("<Button-1>", mouseClickHandler4)
        print("Lose")

    else: #If the user quits, then completely end the game
        print("Quit")
        root.destroy()

#Draws the kitchen background + baby, text, water bar background and bucket
def kitchen():
    global sinkImage, faucetImage, babyImage, waterImage, gamePoints
    global cabinet
    sinkImage = PhotoImage(file = "kitchensink1.gif")
    faucetImage = PhotoImage(file = "faucet1.gif")
    babyImage = PhotoImage(file = "baby1.gif")
    waterImage = PhotoImage(file = "water1.gif")
    
    #Wall
    s.create_rectangle(0, 0, 1000, 700, fill = "light goldenrod", outline = "light goldenrod")
    
    #Cabinets
    xCabinet = 240
    yCabinet = 100
    w = 100
    h = 100
    for f in range(6):
        cabinet = s.create_rectangle(xCabinet, yCabinet, xCabinet+w, yCabinet+h, fill = "beige", outline = "black")
        xCabinet = xCabinet + w

    #Cabinet Knobs
    xCKnob = 320
    yCKnob = 180
    CKnobWidth = 10
    CApart = [25, 180, 20, 180, 20, 100]
    for f in range(6):
        CKnob = s.create_oval(xCKnob, yCKnob, xCKnob + CKnobWidth, yCKnob + CKnobWidth, fill = "gray43", outline = "black")
        xCKnob = xCKnob + CApart[f]

    #Drawers
    xDrawer = 240
    yDrawer = 360
    w = [100, 130, 160, 110, 100]
    h = 150
    for f in range(5):
        drawer = s.create_rectangle(xDrawer, yDrawer, xDrawer+w[f], yDrawer+h, fill = "beige", outline = "black")
        xDrawer = xDrawer + w[f]

    s.create_line(240, 400, 470, 400, fill = "black")
    s.create_line(280, 380, 300, 380, fill = "black", width = 3)
    s.create_line(390, 380, 420, 380, fill = "black", width = 3)

    s.create_line(630, 400, 840, 400, fill = "black")
    s.create_line(670, 380, 700, 380, fill = "black", width = 3)
    s.create_line(780, 380, 800, 380, fill = "black", width = 3)

    #Floor
    floor = s.create_polygon(0, 510, 0, 700, 1000, 1000, 1000, 600, 840, 510, fill = "gray87", outline = "black")
    xHorizontal = 0
    yHorizontal = 510
    lHorizontal = 1000
    apart = 6
    
    for f in range(6):
        horizontalLines = s.create_line(xHorizontal, yHorizontal, xHorizontal + lHorizontal, yHorizontal, fill = "black")
        yHorizontal = yHorizontal + apart*(f+5)

    xVertical = 840
    yVertical = 510
        
    xVertical2 = 1800
    yVertical2 = 1050
    m = (yVertical2 - yVertical)/(xVertical2 - xVertical)
    lVertical = 300
    width = 70
    apart = 20
    
    for f in range(16):
        verticalLines = s.create_line(xVertical, yVertical, xVertical2, yVertical2, fill = "black")
        xVertical = xVertical - width
        xVertical2 = xVertical2 - width

    counterTop = s.create_polygon(280, 320, 240, 360, 840, 360, 840, 320, fill = "gray87", outline = "black")

    rightWall = s.create_polygon(840, 100, 1000, 150, 1000, 600, 840, 510, fill = "beige", outline = "black")

    door = s.create_rectangle(0, 100, 220, 510, fill = "sandy brown", outline = "black")
    knob = s.create_oval(180, 320, 200, 340, fill = "yellow", outline = "black")

    #Stove
    stovetop = s.create_polygon(470, 360, 630, 360, 650, 320, 500, 320, fill = "gray66")
    stove1 = s.create_oval(500, 325, 550, 355, fill = "black")
    stove2 = s.create_oval(570, 325, 620, 355, fill = "black")

    #Oven
    s.create_rectangle(470, 360, 630, 510, fill = "gray66")
    s.create_line(480, 380, 540, 390, 620, 380, fill = "black", width = 4, smooth = "true")
    s.create_rectangle(480, 400, 620, 480, fill = "gray87", outline = "gray87")

    sink = s.create_image(380, 360, image=sinkImage, anchor=CENTER)

    faucet = s.create_image(380, 300, image = faucetImage, anchor = CENTER)

    #Baby
    s.create_image(580, 106, image = babyImage, anchor = SE)

    #Score text
    s.create_text(750,40,text = "Score: ", font = "Arial 14", fill = "black")

    #Number of splats left
    s.create_text(700,80,text = "Splotches to clean: ", font = "Arial 14", fill = "black")

    #Lives text
    s.create_text(100,40,text = "Lives: ", font = "Arial 14", fill = "black")

    #Water text
    s.create_text(100,75,text = "Water Left: ", font = "Arial 14", fill = "black")

    #Water bar background
    s.create_rectangle(150, 60, 400, 90, fill = "navy blue", outline = "navy blue")

    #Water bucket
    bucket = s.create_image(800, 500, image = waterImage, anchor = N)

#Runs the game play   
def runGame():
    global numSplats, spongeWiped, pastBoundary, running, page
    page = 0
    
    #Sets the initial values that the game needs to start
    kitchen()
    setInitialValues()
    drawSponge()
    drawSplatHealth()
    updateScore()
    updateNumSplats()

    #Keeps running while the player has not won or lost
    while running:

        #If the water bar is empty, run these procedures (basically doesn't allow the player to clean a splat until water is refilled in the sponge)
        if waterBarEnd<=150: 
            drawSplat()
            updateSplatPosition()
            updateSplatHealth()
            sleep(0.05)
            deleteMovingSplat()
            deleteSplatHealth()
            warningText()
            checkSpongeOverWater()
            if distBetweenSpongeAndWater<=20: #If the sponge is hovering over the water bucket, then delete the warning text
                deleteWarningText()

        #If the sponge has not wiped a splat, then just keep moving the splats and delete lives if necessary
        elif spongeWiped == "none":
            drawWaterBarLeft()
            drawSplat()
            updateSplatPosition()
            updateSplatHealth()
            sleep(0.05)
            deleteMovingSplat()
            deleteSplatHealth()
            checkSpongeOverWater()

        #If the sponge has wiped a splat and the water bar is not empty, then delete splat and update score
        elif spongeWiped!="none" and waterBarEnd!=150:
            deleteScore()
            deleteNumSplats()
            deleteSplat(spongeWiped)
            splat.remove(splat[spongeWiped])
            xSplat.remove(xSplat[spongeWiped])
            ySplat.remove(ySplat[spongeWiped])
            numSplats = numSplats - 1
            updateScore()
            updateNumSplats()
            drawWaterBarLeft()
            spongeWiped = "none" #Sets the spongeWiped back to none to make the game not delete splats when the sponge isn't over a splat

        #BINDS THE PROCEDURE mouseClickHandler TO MOUSE-DOWN EVENTS DURING GAME PLAY
        s.bind("<Button-1>", mouseClickHandler)

        #BINDS THE PROCEDURE mouseReleaseHandler TO ALL MOUSE-MOTION EVENTS
        s.bind("<Motion>", mouseMotionHandler)

        #BINDS THE PROCEDURE mouseReleaseHandler TO ALL MOUSE-UP EVENTS
        s.bind("<ButtonRelease-1>", mouseReleaseHandler)

        #BINDS THE PROCEDURE keyDownHandler TO ALL KEY-DOWN EVENTS
        s.bind("<Key>", keyDownHandler)
        
        #If there are no more splats, then stop the game play
        if numSplats == 0:
            running = False

    #Calls the gameOver procedure when game play stops
    gameOver()

#Starts program at introScreen procedure
root.after(0, introScreen)

s.pack()
s.focus_set()
root.mainloop()
