class Tir extends Object 
{
    float x;
    float y;
    color couleur;
    
    
    Tir (float X, float Y, color nowcouleur) {
      x=X;
      y=Y;
      couleur=nowcouleur; 
    }
    
    void dessiner() {
    fill(couleur);
    rect(x,y,15,5);
    }
    // Déplacement Tir Joueur 1
    void bouge() {
          x=x+10;
    }
    
    // Déplacement Tir Joueur 2
    void bougeP2() {
          x=x-10;
    }
    
     // Détection de la sortie d'écran (missiles joueur 1)
    boolean detectionout() {
      boolean detection=false;
      if ( x>=width){
          detection=true;
      }
      return detection;
}


// Détection de la sortie d'écran (missiles joueur 2)
boolean detectionoutP2() {
  boolean detectionP2=false;
  if ( x<=0){
    
    detectionP2=true;
  }
  return detectionP2;
}





}
