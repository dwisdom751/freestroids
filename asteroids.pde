class asteroid implements moveable{

  public double posX;
  public double posY;
  
  public double velX; 
  public double velY;
  
  public int health;
  
  public MoveTypes myType;
  
  Boolean dead;
  
  //save this object's id number
  int idNum;
  
  public asteroid(int inHealth, int in_idNum)
  {
    posX = random(200);
    posY = random(200);
    
    velX = random(-2,2);
    velY = random(-2,2);


    dead = false;
    
    health = inHealth;
    
    myType = MoveTypes.AST;
    
    idNum = in_idNum;
  }
  
  public asteroid(int inHealth, int in_idNum, double inPosX, double inPosY)
  {
    posX = inPosX;
    posY = inPosY;
    
    velX = random(-2,2);
    velY = random(-2,2);


    dead = false;
    
    health = inHealth;
    
    myType = MoveTypes.AST;
    
    idNum = in_idNum;
  }
  
  
  public void drawSelf(float scale)
  {
    fill(255/health,0,0);
    ellipse((float)posX,(float)posY,15*scale*health,15*scale*health);
  }
  
  //moves the asteroids
  public void moveAst()
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
    return ((15/2)*health)*.85;
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
  
  //reverse course on collison
  public <T extends moveable> void CollisonAction(T hitBy)
  {
    if(hitBy.getMType() == MoveTypes.AST)
    {
      velX *= -1;
      velY *= -1;
    }
    else if(hitBy.getMType() == MoveTypes.LBALL)
    {
      dead = true;
    }
  }
  
}
