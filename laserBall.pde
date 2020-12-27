class laserBall implements moveable {

  public double posX;
  public double posY;
  
  public double velX; 
  public double velY;
  
  public int health;
  
  
  public Boolean dead;
  
  public MoveTypes myType;
  
  
  //save this object's id number
  int idNum;
  
  
   public laserBall(int in_idNum, double initX, double initY, double angle)
  {
    posX = initX;
    posY = initY;
    velX = Math.cos((float)(angle/180)*PI)*3;
    velY = Math.sin((float)(angle/180)*PI)*3;

    
    myType = MoveTypes.LBALL;
    
    idNum = in_idNum;
    
    dead = false;
  }
  
  
  public void drawSelf(float scale)
  {
    fill(0,255,0);
    ellipse((float)posX,(float)posY,10,10);
  }
  
  //returns true if the shot needs to be deleted
  public void moveB()
  {
    posX += velX;
    posY += velY;
    
    if(posX > 620)
    {
      dead = true;
    }
    if(posX < -20)
    {
      dead = true;
    }

    if(posY > 620)
    {
      dead = true;
    }
    if(posY < -20)
    {
      dead = true;
    }
    
    
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
    return 15;
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
    if(hitBy.getMType() != MoveTypes.SPACESHIP)
    {
      dead = true;
    }
    
  }
  

} 
