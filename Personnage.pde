class Personnage

{
    float x;
    float y;

    
    
    Personnage (float nowX, float nowY) {
     x=nowX;
     y=nowY;

//     dbx =  taille;
//     dby =taille2; 
    }
    
    
    void dessinerp1() {
    //fill(couleur);
    ellipse(x, y, dbx1, dby1);
    }
    
    void dessinerp2() {
    //fill(couleur);
    ellipse(x, y, dbx2, dby2);
    }
    // Déplacement des joueurs 
    void bouge(float dX, float dY) {
          x=x+dX;
          y=y+dY;
    }
     // Permet l'interdiction de se déplacer le joueur 1 dans la deuxième partie de l'écran 
     void testecranp1(float dX, float dY)
     {
        if (x<dbx1/2 || x>1280/2-dbx1/2)
        {
           x=x-dX;
        }
        if (y<dby1/2 || y>height-dby1/2)
        {
           y=y-dY; 
        }
     }
     // Permet l'interdiction de se déplacer le joueur 2 dans la deuxième partie de l'écran 
     void testecranp2(float dX, float dY)
     {
      if (x<dbx2/2 || x<width/2+dbx2/2 || x>1280-dbx2/2)
        {
         x=x-dX;
        }
      if (y<dby2/2 || y>height-dby2/2)
        {
         y=y-dY; 
        }
     }
 
}
