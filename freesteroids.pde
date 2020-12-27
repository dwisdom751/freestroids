import java.util.Iterator;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.LinkedList;

spaceShip mainShip;

HashMap<Integer,asteroid> theAsteroids;

HashMap<Integer,moveable> everyThing;

HashMap<Integer,laserBall> theLaserBalls;


//saves the next aviable id
int nextId;

//saves how long since last shot to stop spawning hundreds of laserballs
int shotLimiter;

//every 600 frames spawn a new asteroid
int asteroidCount;

//save how many asteroids we've destoryed
int score;


//move all of the asteroids
//inputs:
//inAsts: an array of all asteroids which have their move function applied to them
//side effects:
//inAsts' elements will have their posX and posY variables changed
public void moveAllAsts(ArrayList<asteroid> inAsts)
{
  for(int drawAll = 0; drawAll < inAsts.size(); drawAll++)
  {
    inAsts.get(drawAll).moveAst();
  }
}

//move all laser balls
//input:
//inLs: a HashMap of all laserBalls
//side effects:
//inLs' elements will have their posX and posY vairables changed
public void moveLaserB(HashMap<Integer,laserBall> inLs)
{
  Iterator<laserBall> it = inLs.values().iterator();

  while(it.hasNext())
  {
    it.next().moveB();
  }
}

//delete all unneeded laser balls
//input: 
//inLs: a HashMap of all the laser balls in the scene
//inE: a HashMap of every moveable in the scene
//side effects:
//inLs: will have dead laser balls deleted from it
//inE: will have dead laser balls deleted from it
public void clearUpLaserBalls(HashMap<Integer,laserBall> inLs, HashMap<Integer, moveable> inE)
{
  Iterator<Integer> it = new CopyOnWriteArrayList(inLs.keySet()).iterator();

  while(it.hasNext())
  {
    int thisLB = it.next();
    
    if(inLs.get(thisLB).dead)
    {
      inE.remove(thisLB);
      inLs.remove(thisLB);
      
    }
    
  }  
}

//delete all unneeded asteroids
//input: 
//inAs: a HashMap of all the asteroids in the scene
//inE: a HashMap of every moveable in the scene
//side effects:
//inAs: will have dead asteroids deleted from it
//also, every dead asteroid will be replaced by two asteroids with less health in this hashmap
//inE: will have dead asteroids deleted from it
//also, every dead asteroid will be replaced by two asteroids with less health in this hashmap
public void clearUpLaserAST(HashMap<Integer,asteroid> inAs, HashMap<Integer, moveable> inE)
{
  Iterator<Integer> it = new CopyOnWriteArrayList(inAs.keySet()).iterator();
  
  LinkedList<Integer> deadIds = new LinkedList<Integer>();

  while(it.hasNext())
  {
    int thisLB = it.next();
    
    if(inAs.get(thisLB).dead)
    {
      int oldH = inAs.get(thisLB).health;
      

      
      deadIds.add(thisLB);

      
      if(oldH != 1)
      {
        score++;
        inAs.put(nextId, new asteroid(oldH-1,nextId,
                 inAs.get(thisLB).getXPos()+10*inAs.get(thisLB).health
                 ,inAs.get(thisLB).getYPos()+10*inAs.get(thisLB).health));
        inE.put(nextId, inAs.get(nextId));
        nextId++;
        inAs.put(nextId, new asteroid(oldH-1,nextId,
                 inAs.get(thisLB).getXPos()-10*inAs.get(thisLB).health
                 ,inAs.get(thisLB).getYPos()-10*inAs.get(thisLB).health));
        inE.put(nextId, inAs.get(nextId));        
        nextId++;
      }
    }
    
    Iterator<Integer> removeIt = deadIds.iterator();
    
    while(removeIt.hasNext())
    {
      int remNum = removeIt.next();
      inE.remove(remNum);
      inAs.remove(remNum);
    }
    
  }  
}


//collides everything with everything
//input:
//Objects: hashmap of every object in the scene
//side effects:
//Objects: every object that has a collison will call it's collison function
//with the object it collided with as input
public <T extends moveable> void collideMany(HashMap<Integer,moveable> Objects)
{
  ArrayList<moveable> allObs = new ArrayList<moveable>(Objects.values());

  //for each object tries to collide it with other objects
  for(int count = 0; count < allObs.size(); count++)
  {
    for(int inner = 0; inner < count; inner++)
    {
      float distX = (float)(allObs.get(count).getXPos() - allObs.get(inner).getXPos());
      float distY = (float)(allObs.get(count).getYPos() - allObs.get(inner).getYPos());
 
      float maxDist = (float)(allObs.get(count).getRad()+allObs.get(count).getRad());
      
 
      if(sqrt(distX*distX + distY*distY) <= maxDist)
      {
        allObs.get(inner).CollisonAction(allObs.get(count));
        allObs.get(count).CollisonAction(allObs.get(inner));

      }

    }
  }
}
//draws everything in the scene
//input: 
//Objects: all objects in the scene
public <T extends moveable> void drawMany(HashMap<Integer,moveable> Objects)
{
  Iterator<Integer> it = Objects.keySet().iterator();
  while(it.hasNext())
  {
    Objects.get(it.next()).drawSelf(1.0);
  }
}
//applies friction to a moveable
//input:
//target: the object which will have friction applied to it
//side effects:
//target: will have its velX and velY changed
public <T extends moveable> void applyFric(T target)
{
    if(target.getXVel() >= 0 )
    {
      target.setXVel(target.getXVel() - .016);
      if(target.getXVel() < 0)
      {
        target.setXVel(0);
      }    
    }
    else if(target.getXVel() < 0)
    {
      target.setXVel(target.getXVel() + .016);
      if(target.getXVel() > 0)
      {
        target.setXVel(0);
      }
    }

    if(target.getYVel() >= 0 )
    {
      target.setYVel(target.getYVel() - .016);
      if(target.getYVel() < 0)
      {
        target.setYVel(0);
      }    
    }
    else if(target.getYVel() < 0)
    {
      target.setXVel(target.getXVel() + .016);
      if(target.getYVel() > 0)
      {
        target.setYVel(0);
      }
    }
}




//sets everything up
void setup()
{
  shotLimiter = 30;
  asteroidCount = 0;
  score = 0;
  nextId = 0;
  mainShip = new spaceShip(nextId);
  nextId++;
  size(600,600);
  rectMode(CENTER);
  //set up everything map
  everyThing = new HashMap<Integer,moveable>();
  everyThing.put(mainShip.getId(),mainShip);
  
  //set up laser ball map
  theLaserBalls = new HashMap<Integer,laserBall>();
  
  //set up asteroids
  theAsteroids = new HashMap<Integer,asteroid>();
  for(int initAst = 0; initAst < 3; initAst++)
  {
    theAsteroids.put(nextId,new asteroid(initAst+1,nextId));
    everyThing.put(theAsteroids.get(nextId).getId(),theAsteroids.get(nextId));
    nextId++;
  }
  
  
}

//update loop
void draw()
{
  if(shotLimiter > 0)
  {
    shotLimiter--;
  }
  
  //ship's code
  background(255,255,255);
  
  asteroidCount++;
  
  if(asteroidCount >= 600)
  {
    asteroidCount = 0;
    theAsteroids.put(nextId,new asteroid((int)random(1,8),nextId,0,0));
    everyThing.put(nextId,theAsteroids.get(nextId));
    nextId++;
  }
  
  applyFric(mainShip);
  mainShip.applyVel();
  
  //move all the laser balls
  moveLaserB(theLaserBalls);
  
 

  
  //asteroid code
  moveAllAsts(new ArrayList<asteroid>(theAsteroids.values()));
  
  //collisons
  collideMany(everyThing);
  
  //draw everything
  drawMany(everyThing);

  //clear out all dead laser balls
  clearUpLaserBalls(theLaserBalls, everyThing);
  //clear out all dead asteroids
  clearUpLaserAST(theAsteroids, everyThing);
  
  if(mainShip.dead)
  {
    textSize(80);
    fill(0,229,237);
    text("YOU LOST :(", 0, 100); 
  }
  
  textSize(20);
  fill(0,0,0);
  text(String.format("YOUR SCORE: %d",score),0,550);
  
  if(keyPressed && (!mainShip.dead))
  {
    switch(key)
    {
      case('a'):
        mainShip.rotShip(-2.5);
        break;
     case('d'):
       mainShip.rotShip(2.5);
       break;
     case('k'):
        mainShip.rotShip(-6.5);
        break;
     case('l'):
        mainShip.rotShip(6.5);
        break;
     case('w'):
       mainShip.useThrust();
       break;
     case(' '):
       if(shotLimiter == 0)
       {
         //makes a laser ball and adds it to both laser balls and eveything
         theLaserBalls.put(nextId,new laserBall(nextId,mainShip.getXPos(),
                       mainShip.getYPos(),mainShip.angle
                       ));
         everyThing.put(nextId,theLaserBalls.get(nextId));
         nextId++;
         shotLimiter = 30;
       }
       break;
    }
  }
}
