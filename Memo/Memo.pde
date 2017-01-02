import java.io.FileNotFoundException;
ArrayList file_list = new ArrayList();
BufferedReader reader;
String [] lister;
String line;
ArrayList line_list = new ArrayList();
int easyindex;
int mediumindex;
int hardindex;
String [] col_list;
int menu = 0;
PFont f;
int menubuffer = 35;
boolean hand_check = false;
boolean file_not_found_error = false;
boolean hit_check = false;
int fnferror_countdown = 30;
float hitcountdown = 15;
int score = 0;
int skipcount = 3;
int charac_oscillate;
int xhitpos = 540;
boolean charac_up = false;
boolean charac_left = false;
Star [] stars = new Star[500];
String [] retstring = {};
Hero hero = new Hero();
boolean question_answered = false;
String answer;

void setup(){
    size(1080, 720);
    charac_oscillate = height-70;
    frameRate(30);
    f = createFont("Helvetica", 30, true);
    //Get a list of all the .csv files in the directory
    String path = sketchPath();
    listFileNames(path);
    println(file_list);
    println(stars.length);
    println(stars[0]);
    for (int y = 0; y < 500; y++) {
        float randx = random(0, 1080);
        float randy = random(-720,720);
        stars[y] = new Star(randx,randy);
        println(stars[y]);
    }
    
}
void draw(){
    if (menu == 0){
        println(mouseX, mouseY);
        background(0);
        if (hand_check == false){
          cursor(ARROW);
        } else{
          cursor(HAND);
        }
        fill(255);
        textAlign(CENTER);
        textFont(f);
        text("Welcome to the game!", width/2, height/4);
        textFont(f, 25);
        text("Choose a file to read from:", width/2, (height/3)-15);
        textAlign(LEFT);
        strokeWeight(1);
        stroke(255);
        fill(0);
        rectMode(CENTER);
        rect(width/2,(height/3)+30,width/4,height/16, 8);
        rect(width/2,(height/3)+90,width/4,height/16, 8);
        rect(width/2,(height/3)+150,width/4,height/16, 8);
        rect(width/2,(height/3)+210,width/4,height/16, 8);
        rect(width/2,(height/3)+270,width/4,height/16, 8);
        if (mouseX > 400 && mouseX < 680 && mouseY > 240 && mouseY < 295){
          hand_check = true;
          strokeWeight(5);
          stroke(255);
          fill(0);
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
        for (int i = 0; i < file_list.size(); i++){
          fill(255);
          text(i+") "+file_list.get(i).toString(), (width/2)-60, (height/3)+menubuffer);
          menubuffer = menubuffer+60;
        }
        menubuffer = 35;
        
        if (file_not_found_error == true && fnferror_countdown > 0){
          textAlign(CENTER);
          textFont(f, 60);
          fill(255,0,0);
          text("FILE NOT FOUND, TRY AGAIN", width/2, height/8);
          fnferror_countdown--;
        } else{
          file_not_found_error = false;
          fnferror_countdown = 30;
        }
    }
    else if (menu == 1){
        background(0);
        noStroke();
        cursor(ARROW);
        if (hit_check == true && hitcountdown > 0){
          hero.hit();
          hitcountdown--;
        } else{
          hero.update();
          hitcountdown = 15;
        }
        for (Star star : stars) {
          star.update();
        }
        String [] liner = get_question();
        textFont(f, 25);
        text("UNIT: "+liner[0], 40, 640);
        text("Your Answer: _________________", 40, 670);
        textFont(f, 50);
        textAlign(CENTER);
        text("Q: "+liner[1], width/2, 340);
        
        stroke(0);
        strokeWeight(1);
        textAlign(LEFT);
        textFont(f, 25);
        text("Score: "+score, 50, 40);
        text("Number of skips left: "+skipcount, 50, 70);
    }
}

void mousePressed(){
  if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 240 && mouseY < 295){
    try{
      String filereader = file_list.get(0).toString();
      read_file(filereader);
      println(line_list);
      println(easyindex);
      println(mediumindex);
      println(hardindex);
      menu = 1;
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 305 && mouseY < 355){
    try{
      String filereader = file_list.get(1).toString();
      read_file(filereader);
      println(line_list);
      menu = 1;
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 365 && mouseY < 415){
    try{
      String filereader = file_list.get(2).toString();
      read_file(filereader);
      println(line_list);
      menu = 1;
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 425 && mouseY < 475){
    try{
      String filereader = file_list.get(3).toString();
      read_file(filereader);
      println(line_list);
      menu = 1;
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
  } else if (menu == 0 && mouseX > 400 && mouseX < 680 && mouseY > 485 && mouseY < 535){
    try{
      String filereader = file_list.get(4).toString();
      read_file(filereader);
      println(line_list);
      menu = 1;
    } catch (IndexOutOfBoundsException e){
      e.printStackTrace();
      file_not_found_error = true;
    }
    
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

String [] get_question(){
  if(question_answered == false){
    if (score < 30){
      int randindex = int(random(1, mediumindex));
      String quest_line = line_list.get(randindex).toString();
      retstring = quest_line.split(",");
    }
    question_answered = true;
  }
  return retstring;
}

//String check_answer(){
//}

void read_file(String filename){
    println(filename);
    reader = createReader(filename);
    //Create list of lines in the file
    try {
      line = reader.readLine();
      line_list.add(line);
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    while (line != null){
      try {
        line = reader.readLine();
        if(line != null){
          line_list.add(line);
        }
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
    }
    String col_line = line_list.get(0).toString();
    col_list = col_line.split(",");
    line_list.remove(0);
    easyindex = line_list.indexOf("EASY");
    mediumindex = line_list.indexOf("MEDIUM");
    hardindex = line_list.indexOf("HARD");
}
class Hero{
  int xpos = 540;
  Hero(){  
  }
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
    fill(255);
    rectMode(CENTER);
    rect(xhitpos, 650, 40, 40);
  }
}
class Star{
  float x_pos;
  float y_pos;
  Star(float xpos, float ypos){
    x_pos = xpos;
    y_pos = ypos;
    println(x_pos, y_pos);
    
  }
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