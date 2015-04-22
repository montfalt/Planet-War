//*********** IMPORTATION DES BIBLIOTHEQUES *************

import processing.opengl.*;
import processing.serial.*;
import ddf.minim.*; // importation musique
import processing.video.*; // importation video

// ******* DECLARATION DES VARIABLES *********
Movie movie;
Serial port;

PImage imggameover1;
PImage imggameover2;
PImage earth;
PImage mars;
PImage space;
// position en x et y de la manette 1
float x1value;
float y1value;
// position en x et y de la manette 2
float x2value;
float y2value;

int fire = 0; // Etat du tir joueur 1 
int fireP2 = 0; // Etat du tur joueur 2

int debut;
int fin;
// taille du joueur 1
int dbx1=100;
int dby1=100;
// taille du joueur 2
int dbx2=100;
int dby2=100;

// taille de l'Array list
int maxsize=5;

ArrayList<Tir> tirsArrayList;
ArrayList<Tir> tirsP2ArrayList;

boolean feu=false; // gestion des tirs joueur 1
boolean feuP2=false; // gestion des tirs joueur 2
boolean touchep1 = false; // gérer les collisions de joueur 1
boolean touchep2 = false; // gérer les collisions de joueur 2
boolean gameover1= false; // gérer la fin du jeu 
boolean gameover2= false; // gérer la fin du jeu 
boolean intro=true; // gestion intro jeu
boolean jeu=false;
boolean firstblood=false;
boolean restart=false;

Tir tir; // Array list tir de la Classe Tir
Personnage montruc = new Personnage(100,500); // perso 1
Personnage montruc1 = new Personnage(700,200); // perso 2


//*** Pour LA MUSIQUE ***
Minim minim;
AudioPlayer music1; // Si musique
AudioSnippet son1; // Si bruitage
AudioPlayer spaceodysse;
AudioPlayer fight;


void setup() {
  // Chargement de la musique 
  minim = new Minim(this);
  music1 = minim.loadFile("Welcome to the Jungle 8-Bit Remix.mp3");
  spaceodysse = minim.loadFile("space-odysse.mp3");
  fight = minim.loadFile("fight.mp3");

    // Load and play the video in a loop
    movie = new Movie(this, "intro-game.mov");
    movie.loop();
  
  
    size(1280, 750); //CrÃ©e une fenÃªtre vierge de 1000*1000 en Open GL
    println(Serial.list());   //Affiche dans la console la liste des ports sÃ©rie disponibles

    String usbPort = Serial.list()[4];
    port = new Serial(this, usbPort, 9600); //On initialise la communication sÃ©rie en 9600bps

    port.bufferUntil('\n'); //Attendre arrivÃ©e d'un saut de ligne pour gÃ©nÃ©rer Ã©vÃ¨nement sÃ©rie

    //port.write(65);
    
    tirsArrayList = new ArrayList();
    tirsP2ArrayList = new ArrayList();
    
    imggameover1 = loadImage("gameover-1.png");
    imggameover2 = loadImage("gameover-2.png");
    earth = loadImage("earth.png");
    mars = loadImage("mars.png");
    space = loadImage("space.png");
 
}
void movieEvent(Movie m) {
  m.read();
}
  
      void draw() 
{     
      if ( intro == true ) { 
      image(movie, 0, 0, width, height);
      spaceodysse.play();
      if ( debut == 1) {
            jeu=true;
             }
      

      } if( jeu==true)
   {    

          if(!music1.isPlaying()) {
                spaceodysse.pause();
                fight.play();
                music1.rewind();
                music1.play();
           }
            
          intro=false;
          background(space);
          noStroke();
          
          // Création des tirs 
          if(fire==1 && tirsArrayList.size()<maxsize) 
          {
            tir = new Tir(montruc.x,montruc.y,color(226,62,62));
            tirsArrayList.add(tir);
            firstblood=true;
            delay(50);
           
            
            
          }
          
             // ****** Gestion des tirs et de ces conséquence du joueur 1 *****
          if ( fire == 1 && !feu) {
            feu=true;
            
          }

         for ( int i =0 ; i < tirsArrayList.size() ; i++ ) 
         {
            tir = (Tir) tirsArrayList.get(i);

            if(!tir.detectionout() && firstblood==true)
            {

                tir.dessiner();
                tir.bouge();
                tir.detectionout();
                detectionToucheP1(montruc1.x,montruc1.y, tir.x, tir.y);
      
                if(tir.detectionout()==true)
                {
                  feu=false;
                  tirsArrayList.remove(tir);
                  println("dedans");
                }
                
                if( touchep2 ==true) {
                    tirsArrayList.remove(tir);
                    dbx2= dbx2-10; 
                    dby2=dby2-10; 
                    println(dbx2);
                  
                }
            }
          }
          
          
          // ****** Gestion des tirs et de ces conséquence du joueur 2 *****
          
          if(fireP2==1 && tirsP2ArrayList.size()<maxsize) 
          {
            tir = new Tir(montruc1.x,montruc1.y,color(62,241,66));
            tirsP2ArrayList.add(tir);
            delay(50);
          }
          
          
          if ( fireP2 == 1 && !feuP2) {
            feuP2=true;
          }
      
         for ( int i =0 ; i < tirsP2ArrayList.size() ; i++ ) 
         {
            tir = (Tir) tirsP2ArrayList.get(i);
            if(!tir.detectionoutP2())
            {  
                tir.dessiner();
                tir.bougeP2();
                tir.detectionoutP2();
                detectionToucheP2(montruc.x,montruc.y, tir.x, tir.y);
             
                if(tir.detectionoutP2()==true)
                {
                  feuP2=false;
                  tirsP2ArrayList.remove(tir);
                  println("dedans");
                }
                if( touchep1==true) { 
                
                      tirsP2ArrayList.remove(tir);
                      
                      dbx1= dbx1-10; 
                      dby1=dby1-10;
                      

                  }
            }
          }
          
          // Appel des fonction complémentaires 
          
          image(earth, montruc.x-dbx1/2, montruc.y-dbx1/2, dbx1, dbx1 );
          image(mars, montruc1.x-dbx2/2, montruc1.y-dbx2/2, dbx2, dbx2 );
          montruc.bouge(x1value,y1value);
          montruc1.bouge(x2value,y2value);
          montruc.testecranp1(x1value,y1value);
          montruc1.testecranp2(x2value,y2value);
          //montruc.dessinerp1();
          //montruc1.dessinerp2();
          
           if (  findeJeu1()== true ) {
             jeu=false;
           background(imggameover1);
           music1.pause();
           
           }
           
           

           
           
          
          if (  findeJeu2()== true ) {
            jeu=false;
           background(imggameover2);
           music1.pause();
           
          }
             

          
  }


} // Fin du draw()


 // Récupération des données des cartes ARDUINO
void serialEvent(Serial port) 

  {

    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);

    int values[] = int(split(serialStr, ','));

        if( values.length == 10 ) 
        {

            x1value =calculate( values[1], 333 );
            y1value =-calculate( values[0], 340 );
            x2value =calculate( values[6], 333 );
            y2value =-calculate( values[5], 340 );
            fire=(values[3]);
            debut=(values[3]); 
            fin=(values[8]);    
            fireP2=(values[8]);       
        }
}

float calculate( float returnValue, float baseValue )

{
  
    float diff=returnValue-baseValue;
    float result=(diff/8);
    return result;

}

// Détection des collisions entre missiles et joueur 1

boolean detectionToucheP1(float px, float py, float tx, float ty ) 

{
  
    if (dist (px,py,tx,ty) <= dbx2/2)
    {
        
        println("colliion");
        touchep2 = true;
    }
  
    else {
      touchep2 = false;
      
    }
  return touchep2;
}


// Détection des collisions entre missiles et joueur 2
boolean detectionToucheP2(float px, float py, float tx, float ty ) 

{
  
    if (dist (px,py,tx,ty) <= dbx1/2)
    {
        
        println("colliion");
        touchep1 = true;
    }
  
    else {
      touchep1 = false;
      
    }
  return touchep1;
}
// Détection de la fin du Jeu 


boolean findeJeu1()
{
  if (dbx1 <= 0 )
  {
    gameover1=true;
    println("gameover");
  }
  else {
    gameover1=false;
  }
  
  return gameover1;
}

boolean findeJeu2()
{
  if (dbx2 <= 0)
  {
    gameover2=true;
    println("gameover");
  }
  else {
    gameover2=false;
  }
  
  return gameover2;
}





