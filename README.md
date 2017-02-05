# pong
Programming Fundamentals Assignment 1 - WIT

**Description of the animation achieved:**
Pong?! is your generic pong game with a twist. The game itself starts off as a casual game of Pong but get's very tricky very fast.
The game starts off with the ball going an average speed and the platform (you could think of it as the paddle) rather large (150px).

However the higher your score goes, the smaller the platform gets and the faster the ball starts to move.

You know you are doing well as the background of the game changes based on your score.

* Green = Oh Please, Easy as pie.
* Amber = Okay.. You're getting there now.
* Red   = You're starting to hit the danger zone. Keep it up.
* Trippy = Well, that's just me being cruel. It's incredibly hard to see the ball and the already very small platform. Can you keep it up?

So as you can see, the platform get's incredibly small (50px) and the background, well.. I'll let you see how that later affects you!

This game includes a number of if () {} else if () {} statements. It also includes a lot of variables as they are crucial to the running of the game.

The game also used a nested for loop to generate the cool (I think) background.

The sequence of this game is crucial, from generating the background first then generating the elements. Checking the scores and listening for mouse events.

**Known bugs/problems:**

Three slight bugs, they don't impact the game.

1. The ball can be sluggish at times, not sure if its my computer or the game itself, 
   maybe the code could be written slightly better so that not so much calls are being made?
   Again, not crucial to the running of the game, may only be a problem with my computer.
   
2. The ball, when it hits the top wall, it goes past the wall and creeps up slightly on the
   scoreboard for a second before bouncing and coming back down. Tried adjusting the Y values
   but no luck, make the ball not hit the wall at all.
   
3. After playing for a couple of minutes, the ball speeds up as it's supposed to. However,
   the ball is hitting the platform but still going through it and rendering the game over.
   The only way you can prevent this is if the ball hits the platform perfectly center, but
   if it hits the edges when going at such a speed, it just goes through the platform.
   Again, this only happens when the ball is going fairly fast. But it can impace gameplay.
