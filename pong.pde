/*

Pong?!

A Processing Game by Lee Mahoney.

Programming Fundamentals Assignment 1.

*/


boolean gameRunning            = false;

float   ballX                  = 150, 
        ballY                  = 150,
        ballSpeedX             = 3, // The speed of the ball going along the x coord.
        ballSpeedY             = 3, // The speed of the ball going along the y coord.
        ballDiameter           = 20;

int     wallColor              = color(255, 255, 255),
        platformColor          = color(255, 255, 255),
        platformSize           = 150,
        highScore              = 0,
        score                  = 0,
        screen                 = 1; // 1 = start, 2 = game, 3 = game over

int     backgroundColor        = color(0, 190, 0), // Like traffic lights, green = safe, amber = tempting, red = hard
        backgroundStrokeColor  = color(0, 140, 0);
      
PImage  logo;


void setup() {

  size(500, 500);
  noStroke();
  smooth();
  
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  
  // Load in the Pong?! Logo for later use.
  logo = loadImage("pongLogo.png");
  
}

/* Main draw() loop, runs continuously until processing is stopped. */
void draw() {

  if (screen == 1) { // Show the start screen (default)
    startScreen();
  } else if (screen == 2) { // Show the actual game screen.
    gameScreen();
  } else if (screen == 3) { // Show the game over screen.
   gameOverScreen(); 
  }
  
}

/* Start Screen (Intro, also default when you open program) */
void startScreen() {
  
  fill(255); // Set a fill for the text.
  
  background(0, 0, 0);
  
  // Place the image on the screen
  image(logo, width / 2, height / 2 - 140);
  
  textSize(56);
  text("Pong?!", width / 2, height / 2);
  
  textSize(20);
  text("Click to Play", width / 2, height / 2 + 80);
  
  textSize(12);
  text("If you need to pause throughout the game, simply click your mouse.", width / 2, height / 2 + 120);
  
  textSize(11);
  fill(255, 0, 0);
  text("Warning: Please refrain from playing if you suffer from epilepsy.", width / 2, height / 2 + 160);
  
}

/* The main game screen */
void gameScreen() {

  /* The background changes color based on the users score. The more the user scores,
     the harder the game gets. The background works based on traffic lights.
     Green  = Easy, the way is clear.
     Amber  = Taking a risk, starting to get hard.
     Red    = Danger zone, difficulty is certain.
     Trippy = Not necissary but makes the ball harder to see and the game harder to play.
  */
  updateBackgroundColor();
  
  // Generate the actual background using the colors generated above.
  drawBackground();
  
  
  noStroke(); // The background color function gives a stroke so, lets get rid of it.
  
  // Draw scoreboard
  fill(0);
  rect(0, 0, width, 30);
  
  fill(255);
  textSize(13);
  text("Score: " + score, width / 2 - 60, 13);
  text("High Score: " + highScore, width / 2 + 60, 13);
  
  // Draw the first ping pong ball. ballX and ballY are defined above and changed below.
  fill(255, 255, 255);
  ellipse(ballX, ballY, ballDiameter, ballDiameter);
  
  // Draw the top wall
  fill(wallColor);
  rect(0, 30, width, 20);
  
  // Draw the platform, as you notice it's position on the Y axis is based on that of the mouses Y position.
  fill(platformColor);
  rect(mouseX - platformSize / 2, height - 30, platformSize, 10);
  
  /* Okay, so the user can pause the game when playing, if they do
     then gameRunning is set to false, which halts the animation of the ball.
     Otherwise, it's set to true and the ball is animated
  */
  if (gameRunning) {
  
    // The ball's x and y coords are based on existing coords + the speed values.
    ballX += ballSpeedX;
    ballY += ballSpeedY;
    
    // If the ball hits the platform, invert it's Y direction  (make it bounce).
    if (ballY > height - 30 && ballY < height - 20 && ballX > mouseX - platformSize / 2 && ballX < mouseX + platformSize / 2) {
      
      // Update the ball's speed and then set it's Y position based on that.
      ballSpeedY *= -1;
      ballY += ballSpeedY;
      // Make the platform go red when the ball hit off it.
      platformColor = color(255, 0, 0);
      
      // Give the user +10 on their score.
      score += 10;
      
      // Check if the highScore is greater than the users score before adding to it.
      if (highScore < score) {
        highScore += 10;
      }
      
      // Let's make the game slightly harder, shrink the platform by 10px when the ball hits it.
      platformSize -= 10;
      /* I quite like the constrain() function.
         Basically, it prevents the platform from growing bigger than 150px and less than 10px.
         So no matter how far the player gets, the smallest the platform will get is 10px. (Which is not easy!)
      */
      platformSize = constrain(platformSize, 50, 150);
      
    }  else if (ballY < 30) { // If the ball hits the top wall
      ballSpeedY *= -1.1; // Again change the ball's speed
      ballY += ballSpeedY; // And then add it to the ball's Y coord.
      wallColor = color(255, 0, 0); // Change the wall color to red to show the ball hit it.
    } else {
      platformColor = color(255, 255, 255); 
      wallColor = color(255, 255, 255);
    }
    
    // If ball goes beyond platform, game over.
    if (ballY > height) {
      // Reset some values (not score as we need it for the game over screen).
      gameRunning = false; // Stop running the animation.
      ballX = 150;
      ballY = 150;
      ballSpeedX = 3; // The speed of the ball going along the x coord.
      ballSpeedY = 3; // The speed of the ball going along the y coord.
      platformSize = 150;
      screen = 3; // Change to the Game Over Screen.
    }
    
    // If ball hits the left or right side of the screen, invert direction of X
    if (ballX > width || ballX < 0) {
      ballSpeedX *= -1;
      ballX += ballSpeedX;
    }
    
  }
  
}

/* Game over screen, shown if ball goes beyond the platform. */
void gameOverScreen() {
  
  fill(255);
  background(0, 0, 0);
  
  image(logo, width / 2, height / 2 - 140);
  
  textSize(48);
  text("Dang! Game Over!", width / 2, height / 2);
  
  textSize(20);
  text("Your score was: " + score, width / 2, height / 2 + 80);
  text("Your High Score so far is: " + highScore, width / 2, height / 2 + 120);
  
  textSize(12);
  text("Want to play again? Click your mouse now!", width / 2, height / 2 + 160);

}

/* Mouse Events */
void mousePressed() {
  
  if (screen == 1) { // If the mouse is clicked and the screen is the start screen (screen 1)
    
    screen = 2; // Change to the game screen
    gameRunning = true; // Run the game
    
  } else if (screen == 2) { // If the mouse is clicked and the screen is the game screen (screen 2)
    
    gameRunning = !gameRunning; // Pause the game.
    
  } else if (screen == 3) { // If the mouse is clicked and the screen is the game over screen (screen 3)
    
    score = 0; // Reset the users score
    screen = 1; // Change to the start screen.
    
  }
}

/* Basically as said above this function updates the background based on the users score */
void updateBackgroundColor() {

  if (score < 30) { // If the users score is under 30.
  
    // Set color to green
    backgroundColor = color(0, 190, 0);
    backgroundStrokeColor = color(0, 140, 0);
  
  } else if (score < 60) { // If the users score is less than 60 

    // Set color to amber (orange)
     backgroundColor = color(255, 160, 0);
     backgroundStrokeColor = color(255, 140, 0);
     
  } else if (score < 90) { // If the users score is less than 90
    
    // Set color to red
    backgroundColor = color(200, 0, 0);
    backgroundStrokeColor = color(170, 0, 0);
  
  } else { // If the user scores over 90, give them a headache (evil laugh.)
     
     // Let's get trippy!
     backgroundColor = color(random(0, 255), random(0, 255), random(0, 255));
     backgroundStrokeColor = color(random(0, 255), random(0, 255), random(0, 255));
  
  }
  
}

/* Draw the actual background use a nested loop */
void drawBackground() {
  
  // Set the actual background layer to the same color as the stroke (let it blend).
  background(backgroundStrokeColor);
  
  for (int x = 0; x <= 500; x += 20) { // Generate the x coord for each circle
     for (int y = 0; y <= 500; y += 20) { // Generate the y coord for each circle
       
       // Set the circles stroke color
       stroke(backgroundStrokeColor);
       
       // Set the circles color
       fill(backgroundColor);
       
       // Draw the circle.
       ellipse(x, y, 20, 20);
       
     }
  }
  
}