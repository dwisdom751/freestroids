class spaceShip implements moveable{
  public double posX;
  public double posY;
  
  public double velX; 
  public double velY;

  //the direction the ship is facing
  public double angle;
  
  public MoveTypes myType;

  //save this object's id number
  int idNum;
  
  public Boolean tailOn;

  public PImage decal;

  //if the main ship has been killed
  public Boolean dead;

  public spaceShip(int in_idNum)
  {
    posX = 300;
    posY = 300;
    velX = 0;
    velY = 0;
    angle = 90;
    tailOn = false;
    dead = false;
    decal = loadImage("decal.png");
    
    myType = MoveTypes.SPACESHIP;
    
    idNum = in_idNum;
  }
  
  
  
  //applies velocity
  public void applyVel()
  {
    posX += velX;
    posY += velY;
    
    if(posX > 620)
    {
      posX = 0;
    }
    if(posX < -20)
    {
      posX = 600;
    }

    if(posY > 620)
    {
      posY = 0;
    }
    if(posY < -20)
    {
      posY = 600;
    }
    
  }
  
  //rotates left and right
  public void rotShip(double changeAmount)
  {
    angle += changeAmount;
    angle %= 360;
  }
  
  //draw the ship rotated correctly and to the desired scale
  public void drawSelf(float scale)
  {
    fill(255,255,255);
    pushMatrix();
    translate((float)posX,(float)posY);
    rotate((float)((angle-90)/180)*PI);
    ellipse(0,10*scale,20*scale,30*scale);
    rect(0,0,20*scale,30*scale);
    image(decal,-10*scale,-10*scale,20*scale,20*scale);
    drawTail(scale);
    popMatrix();
  }
  
  //fly ship in the correct direction
  public void useThrust()
  {
    velX += Math.cos((float)(angle/180)*PI)*.1;
    velY += Math.sin((float)(angle/180)*PI)*.1;
    tailOn = true;
  }
  
  public void drawTail(float scale)
  {
    if(tailOn)
    {
     fill(255,0,0);
     triangle(0,-15*scale,-10*scale,-30*scale,10*scale,-30*scale);
     fill(255,255,255);
    }
    tailOn = false;
  }
  
  //all the getters and setters needed to allow generics to be usefull 
  public double getXPos()
  {
    return posX;
  }
  public double getXVel()
  {
    return velX;
  }
  
  public double getYPos()
  {
    return posY;
  }
  public double getYVel()
  {
    return velY;
  }
  public double getRad()
  {
    return 25;
  }
  public int getId()
  {
    return idNum;
  }
  public MoveTypes getMType()
  {
    return myType;
  }

  
  //all the getters and setters needed to allow generics to be usefull 
  public void setXPos(double inPos)
  {
    posX = inPos;
  }
  public void setXVel(double inVel)
  {
    velX = inVel;
  }
  
  public void setYPos(double inPos)
  {
    posY = inPos;
  }
  public void setYVel(double inVel)
  {
    velY = inVel;
  }
  
  //handles collisons
  public <T extends moveable> void CollisonAction(T hitBy)
  {
    if(hitBy.getMType() != MoveTypes.LBALL)
    {
      velX *= -1;
      velY *= -1;
    }
    if(hitBy.getMType() == MoveTypes.AST)
    {
      dead = true;
    }
  }
  
}
