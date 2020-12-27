//interface that allows all the game's different objects to be used in generic functions
interface moveable {
  public double getXPos();
  public double getXVel();
  public double getYPos();
  public double getYVel();
  public double getRad();
  public int getId();
  public MoveTypes getMType();

  public void setXPos(double inPos);
  public void setXVel(double inVel);
  public void setYPos(double inPos);
  public void setYVel(double inVel);
  
  public <T extends moveable> void CollisonAction(T hitBy);
 
  //calls the object's draw function
  public void drawSelf(float scale);

  
}

public enum MoveTypes {
  SPACESHIP, AST, LBALL;
}
