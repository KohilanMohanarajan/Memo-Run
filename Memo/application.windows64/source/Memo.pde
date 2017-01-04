import java.io.FileNotFoundException;
// A list containing all the files in the directory
ArrayList file_list = new ArrayList();
// The reader to read files
BufferedReader reader;
// The read line from the file
String line;
// A list containing the lines from the .txt file
ArrayList line_list = new ArrayList();
// Index of the line containing "EASY"
int easyindex;
// Index of the line containing "MEDIUM"
int mediumindex;
// Index of the line containing "HARD"
int hardindex;
// String containing the columns at the top of the .txt file
String [] col_list;
// Counter to establish what screen you're on
int menu = 0;
// Font used in the game
PFont f;
// Buffer to iterate through the list of displayed names
int menubuffer = 35;
// Used to check whether the cursor is hovering over a button or not
boolean hand_check = false;
// Used to check whether the file exists or not
boolean file_not_found_error = false;
// Used to check whether the player got the answer wrong
boolean hit_check = false;
// Used to check whether the player got the question correct
boolean corr_check = false;
// Timer to determine how long the File Not Found error text is displayed
int fnferror_countdown = 30;
// Timer to determine how long the hit animation is displayed
float hitcountdown = 15;
// Timer to determine how long the Correct Answer text is displayed
float corrcountdown = 15;
// Variable containing the player's score
int score = 0;
// Counter to show how many lives the player has left
int lifecount = 3;
// Y-position of the character unit
int charac_oscillate;
// X-position of the character unit when hit
int xhitpos = 540;
// Used to determine whether the character unit is moving up
boolean charac_up = false;
// Used to determine whether the character unit is moving left
boolean charac_left = false;
// Array of star objects to be displayed
Star [] stars = new Star[500];
// String containing elements of the question
String [] retstring = {};
// Character object to establish the player unit
Hero hero = new Hero();
// Boolean switch to determine whether or not to get a new question
boolean question_answered = false;
// The player's inputted response
String answer = "";
// Boolean switch to determine the right answer
boolean corr_ans = true;
// Variable to contain the String-formatted question elements
String [] liner;
// Used to check whether the file is empty
boolean file_empty = false;
// Used in the counter to determine if the File Is Empty error text is displayed
boolean file_is_empty_error;
// Timer to determine how long the File Is Empty error text is displayed
int fieerror_countdown = 30;
// String that contains the name of the file to be read
String filereader;
// The current version number
float version_num = 1.02;
// The amount the score increases by per correct answer
int scoreinc = 0;


void setup(){
    // Screen size of 1080 width by 720 height
    size(1080, 720);
    // Frame title
    surface.setTitle("Memo Run - Created by Kohilan Mohanarajan"); 
    // Determines the y-position of the character unit
    charac_oscillate = height-70;
    // Determines the framerate of the application
    frameRate(30);
    // Establishes font used in the application
    f = createFont("Helvetica", 30, true);
    // Get the directory to search through
    String path = sketchPath();
    // Create a list of all the files in the directory
    listFileNames(path);
    println(file_list);
    println(stars.length);
    println(stars[0]);
    // Create the positions of the stars thatare displayed
    for (int y = 0; y < 500; y++) {
        // A random x position is chosen
        float randx = random(0, 1080);
        // A random y position is chosen
        float randy = random(-720,720);
        // An individual star element is created
        stars[y] = new Star(randx,randy);
        println(stars[y]);
    }
    
}
void draw(){
    /*------------------------------------ The initial display screen -------------------------------------------*/
    if (menu == 0){
        // Create a black background
        background(0);
        // Change the cursor to a hand if hovering over a button
        if (hand_check == false){
          cursor(ARROW);
        } else{
          cursor(HAND);
        }
        // Establish the fill of the text
        fill(255);
        // Align the text to center
        textAlign(CENTER);
        // Determine the font and size of the text of the title
        textFont(f, 50);
        // The title
        text("Welcome to Memo Run!", width/2, height/4);
        // Determine the font and size of the text of the subtitle
        textFont(f, 25);
        // The subtitle
        text("Choose a file to read from:", width/2, (height/3)-15);
        // Align the file name text to the left
        textAlign(LEFT);
        // Define the thickness of the borders of the buttons
        strokeWeight(1);
        // Define the colour of the button borders
        stroke(255);
        // Define the colour of the button
        fill(0);
        // Align the button to be center-aligned
        rectMode(CENTER);
        // Draw the five buttons on the page
        rect(width/2,(height/3)+30,width/4,height/16, 8);
        rect(width/2,(height/3)+90,width/4,height/16, 8);
        rect(width/2,(height/3)+150,width/4,height/16, 8);
        rect(width/2,(height/3)+210,width/4,height/16, 8);
        rect(width/2,(height/3)+270,width/4,height/16, 8);
        // Toggle button highlight
        if (mouseX > 400 && mouseX < 680 && mouseY > 240 && mouseY < 295){
          // Toggle the button press option switch
          hand_check = true;
          // Thicken the borders of the button
          strokeWeight(5);
          stroke(255);
          fill(0);
          // Redraw the button
          rect(width/2,(height/3)+30,width/4,height/16, 8);
        } else if (mouseX > 400 && mouseX < 680 && mouseY > 305 && mouseY < 355){
          hand_check = true;
          strokeWeight(5);
          stroke(255);
          fill(0);
          rect(width/2,(height/3)+90,width/4,height/16, 8);
        } else if (mouseX > 400 && mouseX < 680 && mouseY > 365 && mouseY < 415){
          hand_check = true;
          strokeWeight(5);
          stroke(255);
          fill(0);
          rect(width/2,(height/3)+150,width/4,height/16, 8);
        } else if (mouseX > 400 && mouseX < 680 && mouseY > 425 && mouseY < 475){
          hand_check = true;
          strokeWeight(5);
          stroke(255);
          fill(0);
          rect(width/2,(height/3)+210,width/4,height/16, 8);
        } else if (mouseX > 400 && mouseX < 680 && mouseY > 485 && mouseY < 535){
          hand_check = true;
          strokeWeight(5);
          stroke(255);
          fill(0);
          rect(width/2,(height/3)+270,width/4,height/16, 8);
        } else{
          hand_check = false;
        }
        // Draw the labels for the buttons
        for (int i = 0; i < file_list.size(); i++){
          // Determine the colour of the text to be white
          fill(255);
          // With a limit of 5 buttons, draw out the text
          if (i < 5){
            // Iterate through the list of file names and draw them
            text(i+") "+file_list.get(i).toString(), (width/2)-110, (height/3)+menubuffer);
            // Move the next file name down the page
            menubuffer = menubuffer+60;
          }
        }
        // Reset the menu buffer to account for the draw loop
        menubuffer = 35;
        
        // Displays the "File Not Found!" error
        if (file_not_found_error == true && fnferror_countdown > 0){
          textAlign(CENTER);
          textFont(f, 60);
          fill(255,0,0);
          text("FILE NOT FOUND, TRY AGAIN", width/2, height/8);
          // Countdown the timer for this error to display
          fnferror_countdown--;
        } else{
          // Reset the error and its timer
          file_not_found_error = false;
          fnferror_countdown = 30;
        }
        // Displays the "File is empty!" error
        if (file_is_empty_error == true && fieerror_countdown > 0){
          textAlign(CENTER);
          textFont(f, 60);
          fill(255,0,0);
          text("FILE IS EMPTY, TRY AGAIN", width/2, height/8);
          // Countdown the timer for this error to display
          fieerror_countdown--;
        } else{
          // Reset the error and its timer
          file_is_empty_error = false;
          fieerror_countdown = 30;
        }
        textAlign(CENTER);
        textFont(f, 20);
        fill(255);
        text("© 2016 Kohilan Mohanarajan", width-170,height-40);
        text("Version "+version_num, width-980,height-675);
    }
    /*---------------------------------------- The gameplay screen ----------------------------------------------*/
    else if (menu == 1){
        // Set the blackground to be black
        background(0);
        cursor(ARROW);
        // Draw the stars in the background
        for (Star star : stars) {
          star.update();
        }
        // Draw the player character
        if (hit_check == true && hitcountdown > 0){
          // Display the hero hit animation
          hero.hit();
          hitcountdown--;
        } else{
          // Draw the regular hero animation
          hit_check = false;
          hero.update();
          // Reset the countdown timer for the hit animation
          hitcountdown = 15;
        }
        // Draw the Correct answer text
        if (corr_check == true && corrcountdown > 0){
          textAlign(CENTER);
          textFont(f, 60);
          text("CORRECT!", width/2, height/4);
          corrcountdown--;
        } else{
          corr_check = false;
          corrcountdown = 15;
        }
        // Get the elements of the question
        liner = get_question();
        textFont(f, 25);
        textAlign(LEFT);
        // Draw the Text displaying the unit in question
        text("UNIT: "+liner[0], 40, 640);
        // Draw the Text displaying the player's answer
        text("Your Answer: _________________", 40, 670);
        textFont(f, 20);
        text(answer, 200, 668);
        textFont(f, 40);
        textAlign(CENTER);
        // Display the question
        text("Q: "+liner[1], width/2, 340);
        // Display the score and the amount of lives left
        stroke(0);
        strokeWeight(1);
        textAlign(LEFT);
        textFont(f, 30);
        text("Score: "+score, 40, 50);
        text("Number of lives left: "+lifecount, 40, 80);
    }
    /*---------------------------------------- The game over screen ---------------------------------------------*/
    else if (menu == 2){
      // Red background
      background(255,0,0);
      // Draw the Game Over text
      textAlign(CENTER);
      fill(255);
      textFont(f, 60);
      text("GAME OVER", width/2, height/4);
      // Draw the final score text
      textFont(f, 40);
      text("Your Final Score: "+score, width/2, height/3);
      // Draw the "Try Again" button
      strokeWeight(1);
      stroke(255);
      fill(255,0,0);
      rectMode(CENTER);
      rect(width/2,(height/3)+210,width/4,height/16, 8);
      // Draw the button hover toggle
      if (mouseX > 400 && mouseX < 680 && mouseY > 425 && mouseY < 475){
        hand_check = true;
        strokeWeight(5);
        stroke(255);
        fill(255,0,0);
        rect(width/2,(height/3)+210,width/4,height/16, 8);
      }
      // Draw the label for the button
      fill(255);
      textFont(f, 20);
      text("TRY AGAIN?", (width/2), (height/3)+215);
    }
}
/*---------------------------------------- Mouse Press Functions ----------------------------------------------*/
void mousePressed(){
  // Button pressed on first page.  Read the file, change the screens
  if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 240 && mouseY < 295){
    try{
      // Get the file to be read
      filereader = file_list.get(0).toString();
      // Reads the file
      read_file(filereader);
      println(line_list);
      println(easyindex);
      println(mediumindex);
      println(hardindex);
      // If the read_file function worked, then move on to the next screen
      if (file_empty == false){
        menu = 1;
      }
    }
    // catch the Out of bounds error, that is to say, if the file doesn't exist
    catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      // Switch on the "File not found!" error
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 305 && mouseY < 355){
    try{
      filereader = file_list.get(1).toString();
      read_file(filereader);
      println(line_list);
      if (file_empty == false){
        menu = 1;
      }
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 365 && mouseY < 415){
    try{
      filereader = file_list.get(2).toString();
      read_file(filereader);
      println(line_list);
      if (file_empty == false){
        menu = 1;
      }
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 425 && mouseY < 475){
    try{
      filereader = file_list.get(3).toString();
      read_file(filereader);
      println(line_list);
      if (file_empty == false){
        menu = 1;
      }
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 485 && mouseY < 535){
    try{
      filereader = file_list.get(4).toString();
      read_file(filereader);
      println(line_list);
      if (file_empty == false){
        menu = 1;
      }
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
  }
  // Button to reset game is pressed on Game Over screen
  if (menu == 2 && mouseX > 400 && mouseX < 680 && mouseY > 425 && mouseY < 475){
    // Reset all the variables
    reset();
  }  
}
/*---------------------------------------- Key Press Functions ----------------------------------------------*/
void keyPressed() {
    // Read the user's answer input
    if(menu == 1 && key != ENTER && keyCode != SHIFT && key != BACKSPACE){
      // Add the inputted key onto the answer string
      answer = answer + key;
      println(answer+answer.length());
    }
    // Read a backspace input
    if(key == BACKSPACE && menu == 1){
      println("BACK "+answer.length());
      if (answer.length() > 0){
        answer= answer.substring(0, max(0, answer.length()-1));
      }
    }
    // Read an Enter input
    if(key == ENTER && menu == 1){
      // Check the answer
      corr_ans = check_answer(answer);
      if (corr_ans == true){
        // Add to the score
        
        //if (score < 30){
        score = score+scoreinc;
        /*} else if (score >=30 && score < 90){
          score = score+4;
        } else if (score >= 90){
          score = score+6;
        }*/
        if (score >= 100 && score <= 102){
          lifecount++;
        }
        // Toggle the Correct Answer text
        corr_check = true;
        // Get a new question
        question_answered = false;
      } else{
        // Take away a life
        lifecount--;
        // Toggle the hit animation
        hit_check = true;
        // Switch to the game over screen if the life count reaches 0
        if (lifecount == 0){
          menu = 2;
        }
      }
      // Reset the answer
      answer = "";
    }
}

// This function returns all the files in a directory as an array of Strings  
void listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String [] temp_list = file.list();
    for (int i=0; i < temp_list.length;i++){
      if (temp_list[i].endsWith(".txt") == true){
        file_list.add(temp_list[i]);
      }
    }
    println(file_list);
  } 
}

// Reset the variables, and ergo, the game
void reset(){
  file_list = new ArrayList();
  line_list = new ArrayList();
  menu = 0;
  menubuffer = 35;
  hand_check = false;
  file_not_found_error = false;
  hit_check = false;
  corr_check = false;
  fnferror_countdown = 30;
  hitcountdown = 15;
  corrcountdown = 15;
  score = 0;
  lifecount = 3;
  xhitpos = 540;
  charac_up = false;
  charac_left = false;
  stars = new Star[500];
  hero = new Hero();
  question_answered = false;
  answer = "";
  corr_ans = true;
  file_empty = false;
  fieerror_countdown = 30;
  setup();
}

// A function to get a question
String [] get_question(){
  // Gets a new question if the current question isn't answered
  if(question_answered == false){
    println("Question not answered");
    // Establish the range of difficulty
    int diffrange = 0;
    // The index in the list of lines in the .txt file
    int randindex = 0;
    // Determine the range of the difficulty of the questions to pick from
    if (score < 30){
      diffrange = 1;
    } else if (score >=30 && score < 90){
      diffrange = 2;
    } else if (score >= 90){
      diffrange = 3;
    }
    // Chooses the difficulty of the question.  1 = Easy, 2 = Medium, 3 = Hard
    int diffchoose = int(random(1, diffrange+1));
    // Get a random line from the list pertaining to the difficulty
    if (diffchoose == 1){
      randindex = int(random(1, mediumindex));
      scoreinc = 2;
    } else if (diffchoose == 2){
      randindex = int(random(mediumindex+1, hardindex));
      scoreinc = 4;
    } else if (diffchoose == 3){
      randindex = int(random(hardindex+1, line_list.size()));
      scoreinc = 6;
    }
    println(diffrange, randindex, line_list.size());
    // Cast the line to a string to process it
    String quest_line = line_list.get(randindex).toString();
    // Create an array of strings containing each element of the line
    retstring = quest_line.split("//");
    // Trims leading and trailing whitespace from the elements of the list
    for (int i = 0; i < retstring.length;i++){
      retstring[i] = retstring[i].trim();
    }
    // Toggle the switch so that a new question isn't chosen each frame
    question_answered = true;
  } 
  return retstring;
}

// A function to check the user's answer
boolean check_answer(String candidate){
  // Convert the two strings to lowercase to compare
  String base = liner[2].toLowerCase();
  String cand = candidate.toLowerCase();
  println(liner[2]);
  println(candidate);
  // Determine if the two answers are equal
  if (cand.equals(base)){
    return true;
  } else{
    return false;
  }
}

// A function to read the file
void read_file(String filename){
    println(filename);
    // Create a reader object to read the file
    reader = createReader(filename);
    // Read the first line in the file
    try {
      line = reader.readLine();
      line_list.add(line);
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    // Read the rest of the lines in the file
    while (line != null){
      try {
        // Read the line
        line = reader.readLine();
        if(line != null){
          // Add the line to the list of lines
          line_list.add(line);
        }
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
    }
    println(line_list.size());
    // Fill various variables using the information from the file
    if (line_list.size() > 1){
      println(line_list);
      // Get the line containing the columns of the .txt file
      String col_line = line_list.get(0).toString();
      // Split the elements of the line to get each element
      col_list = col_line.split(",");
      // Remove the first line from the line_list
      line_list.remove(0);
      // Determine the indexes of the headers for the easy, medium, and hard section
      easyindex = line_list.indexOf("EASY");
      mediumindex = line_list.indexOf("MEDIUM");
      hardindex = line_list.indexOf("HARD");
      file_empty = false;
    } else{
      file_empty = true;
      // Reset the line list
      line_list = new ArrayList();
      // Display the File not found error
      file_is_empty_error = true;
    }
}

// The class containing the Hero object
class Hero{
  int xpos = 540;
  Hero(){  
  }
  // Character animation
  void update(){
    if (charac_oscillate < height-60 && charac_up == false){
      charac_oscillate++;
    } else if(charac_oscillate == height-60 && charac_up == false){
      charac_up = true;
    } else if (charac_oscillate > height-80 && charac_up == true){
      charac_oscillate--;
    } else if(charac_oscillate == height-80 && charac_up == true){
      charac_up = false;
    }  
    fill(255);
    rectMode(CENTER);
    rect(xpos, charac_oscillate, 40, 40);
  }
  // Character hit animation
  void hit(){
    if (xhitpos < 540+4 && charac_left == false){
      xhitpos= xhitpos+2;
    } else if(xhitpos == 540+4 && charac_left == false){
      charac_left = true;
    } else if (xhitpos > 540-4 && charac_left == true){
      xhitpos= xhitpos-2;
    } else if(xhitpos == 540-4 && charac_left == true){
      charac_left = false;
    }
    fill(255,0,0);
    stroke(255,0,0);
    rectMode(CENTER);
    rect(xhitpos, 650, 40, 40);
  }
}
// The class containing the star object
class Star{
  float x_pos;
  float y_pos;
  Star(float xpos, float ypos){
    x_pos = xpos;
    y_pos = ypos;
    println(x_pos, y_pos);
    
  }
  // Move the star down the screen
  void update() {
    if (y_pos > 720){
      y_pos = y_pos-720;
    } else{
      y_pos++;
    }
    stroke(255);
    strokeWeight(1);
    point(x_pos, y_pos);
  }
}