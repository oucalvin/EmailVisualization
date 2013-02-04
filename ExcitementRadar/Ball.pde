class Ball
{
  // This is an email thread on the radar.
  ArrayList<Email> emails;
  float angle;
  int x,y,diameter,heat_level, excitement_level, thread_id; // heat_level: (cold) 1-10 (hot)
  boolean isSelected;
  Ball(float angle, int thread_id)
  {
    this.angle = angle;
    this.heat_level = 3; // default
    this.excitement_level = 0;
    emails = new ArrayList();
    this.thread_id = thread_id;
    this.x = 0; // used for mouseclicks only
    this.y = 0; // used for mouseclicks only
    this.diameter = 0; // used for mouseclicks only
    this.isSelected = false;
  }
  void select()
  {
     this.isSelected = true; 
  }
  void deselect()
  {
     this.isSelected = false; 
  }
  int getSize()
  {
     // Returns the size based on total char number in email body  
     
     int size = 0;
     for(int i=0; i<this.emails.size(); i++)
     {
       Email e = (Email)this.emails.get(i);
       String body = e.getBody(); 
       size += body.length();
     }
     
     
     return size;
  }
  
  void update()
  {
      // decrease excitement
      this.excitement_level--;
      if(this.excitement_level < 0)
        this.excitement_level = 0;
      
      
      // decrement heat_level
      this.heat_level--;
      if(this.heat_level < 1)
        this.heat_level = 1;
  }
  
  void fillColor()
  {
    if(this.isSelected)
    {
        fill(0, 0, 255); // Change to blue if selected
        return;
    }
    switch(this.heat_level)
    {
       case 1:
          fill(255, 245, 0);          
          break;
       case 2:
          fill(255, 225, 0);      
          break;
       case 3:
          fill(255, 205, 0);      
          break;
       case 4:
          fill(255, 185, 0);      
          break;
       case 5:
          fill(255, 165, 0);
          break;
       case 6:
          fill(255, 145, 0);
          break;
       case 7:
          fill(255, 125, 0);
          break;
       case 8:
          fill(255, 105, 0);      
          break;
       case 9:
          fill(255, 125, 0);      
          break;
       case 10:
          fill(255, 115, 0);      
          break;   
       default:
           ;
    }
     
  }
  String getEmailThread()
  {
    // Want latest first
    String result = "";
     for( int i = this.emails.size() -1; i >= 0 ; i--)
     {
         Email e = this.emails.get(i);
         result += "Sender: " + e.getSender() + "\n";
         result += "Date: " + e.getDatetime()+ "\n";
         result += "Keywords: " + e.getKeyword() + "\n";
         result += "Subject: " + e.getSubject() + "\n";
         result +=  e.getBody() + "\n";
         result += "------------------------------------------------------------------------------------\n";
     }
     return result;
  }
  void addEmail(Email e)
  {
     // increase excitement (x,y)
     emails.add(e);
     
     this.excitement_level += e.getExcitementLevel();
      if(this.excitement_level > 10)
        this.excitement_level = 10;
        
    // change heat
     this.heat_level += 3; // Increase by 3, but decrease by 1, so nett is 2. A nett 2 allows for more lag between emails
     if(this.heat_level >10)
      this.heat_level = 10; 
    
   
  }
  // doUpdate: true if we want to update, false if we just want to redraw
  void drawMe()
  {
    
    // Draws the ball on the radar (with x,y,angle, size, color)
    
     fillColor(); // sets the fill based on heat_level
     
     // Size of email thread
     int size = this.getSize();
     int downsize = size / 10; // upgrade one size only every 100 char // TODO: testing
     if(downsize <= 0)
       downsize = 1;
     int this_diameter = downsize * 20; // TODO: testing
     if (this_diameter > 100)
      this_diameter = 100; 
     
     
     // Draw angular displacement
     // excitement level = this.excitement_level;
    int this_radius = radius - this.excitement_level * 30; // Magnify the distance
    if(this_radius < 10)
      this_radius = 10; // minimum of 10 px for clarity
    
    int x = (int) Math.round( dotx + this_radius * sin(this.angle));
    int y = (int) Math.round(doty - this_radius * cos(this.angle));     
    
     // Draw the ball
     ellipse(x,y,this_diameter,this_diameter);
     
     this.x = x;
     this.y = y;
     this.diameter = this_diameter;
     // show keyword continuously for now
     textAlign(CENTER, CENTER);
     int textSize = downsize + 5; // min : 6
     if(textSize > 32)
       textSize = 32;
      fill(0);
     textFont(g_font, textSize);
     Email e = (Email) emails.get(emails.size() -1);
     String keyword = e.getKeyword();
     text(keyword, x, y, this_diameter);
     
      
  }
  int getX()
  {
     return this.x; 
  }
  int getY()
  {
     return this.y; 
  }
  int getDiameter()
  {
     return this.diameter; 
  }
}