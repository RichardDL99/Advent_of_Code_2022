// Elf Filing System 

final boolean F = false;
final boolean T = true;


String fileLines[];       // need file available as we work through the moves
int lineNo;               // nof line we're going to use next

int treesPerRow;
int trees[][];
boolean visibles[][];
boolean visibleW[][];
boolean visibleE[][];
boolean visibleN[][];
boolean visibleS[][];
void loadData()
{
  String filename;
  filename = "Data_08_02.dat";
  fileLines = loadStrings(filename);
  println("No of lines" + fileLines.length);

  // print the data
  for (lineNo = 0 ; lineNo < fileLines.length; lineNo++) 
  {
    print(String.format("L %4d: %s", lineNo, fileLines[lineNo]));
    println();
  }
}

void scanData()
{
  String aLine;
  char cHite;
  int hite;
  int ix, jx;
  treesPerRow = fileLines.length;
  
  trees    = new     int[treesPerRow][treesPerRow];
  visibles = new boolean[treesPerRow][treesPerRow];
  visibleW = new boolean[treesPerRow][treesPerRow];
  visibleE = new boolean[treesPerRow][treesPerRow];
  visibleN = new boolean[treesPerRow][treesPerRow];
  visibleS = new boolean[treesPerRow][treesPerRow];
  
  for (jx = 0; jx < treesPerRow; jx++){
    aLine = fileLines[jx];
    for (ix = 0; ix < treesPerRow; ix++){
      cHite = aLine.charAt(ix);
      //print(cHite);
      hite = (int) cHite - 48;
      print(hite);
      trees[jx][ix] = hite;
    }
    println();
  }
}

void SetVis()
{
  int myHite;
  int otHite;
  int jx, ix;
  int jz, iz;
  boolean isVisible = F;
  boolean visE, visW, visN, visS;
  
  for (jx = 0; jx < treesPerRow; jx++){
    for (ix = 0; ix < treesPerRow; ix++){

      myHite = trees[jx][ix];
      isVisible = F;
      if (ix == 0 || ix == treesPerRow - 1 || jx == 0 || jx == treesPerRow - 1) {isVisible = T;}
      else {
      
      
        // consider vis in 4 directions
        // any one tree as tall as me makes it not vis.
        visW = T;
        for (iz = 0; iz < ix; iz++){
          otHite = trees[jx][iz];
          if (otHite >= myHite) {visW = F; break;}
        }
        visibleW[jx][ix] = visW;
        
        visE = T;
        for (iz = ix + 1; iz < treesPerRow; iz++){
          otHite = trees[jx][iz];
          if (otHite >= myHite) {visE = F; break;}
        }
        visibleE[jx][ix] = visE;
        
        visN = T;
        for (jz = 0; jz < jx; jz++){
          otHite = trees[jz][ix];
          if (otHite >= myHite) {visN = F; break;}
        }
        visibleN[jx][ix] = visN;
        
        visS = T;
        for (jz = jx + 1; jz < treesPerRow; jz++){
          otHite = trees[jz][ix];
          if (otHite >= myHite) {visS = F; break;}
        }
        visibleS[jx][ix] = visS;
                
        isVisible = visE || visW || visN || visS;
      }
      visibles[jx][ix] = isVisible;
    }
  }
}


int count()
{
  int myHite;
  int otHite;
  int jx, ix;
  int jz, iz;
  boolean isVisible = F;
  boolean visE, visW, visN, visS;
  int tCount;
  
  tCount = 0;
  for (jx = 0; jx < treesPerRow; jx++){
    for (ix = 0; ix < treesPerRow; ix++){
      if (visibles[jx][ix]) {tCount++;}
    }
  }
  return tCount;
}
      
int scenic()
{
  int jx, ix;
  int jz, iz;
  int myHite;
  int otHite;
  int score;
  int viewW, viewE, viewN, viewS;
  int mxScre = 0;
  
  for (jx = 0; jx < treesPerRow; jx++){
    for (ix = 0; ix < treesPerRow; ix++){

      myHite = trees[jx][ix];

      if (ix == 0 || ix == treesPerRow - 1 || jx == 0 || jx == treesPerRow - 1) {score = 0;}
      else {
      
      
        // consider vis in 4 directions
        // any one tree as tall as me makes it not vis.
        viewW = 0;
        for (iz = ix - 1; iz >= 0; iz--){
          otHite = trees[jx][iz];
          viewW++;
          if (otHite >= myHite) {break;}
        }
        
        viewE = 0;
        for (iz = ix + 1; iz < treesPerRow; iz++){
          otHite = trees[jx][iz];
          viewE++;
          if (otHite >= myHite) {break;}
        }
        
        viewN = 0;
        for (jz = jx - 1; jz >= 0; jz--){
          otHite = trees[jz][ix];
          viewN++;
          if (otHite >= myHite) {break;}
        }
        
        viewS = 0;
        for (jz = jx + 1; jz < treesPerRow; jz++){
          otHite = trees[jz][ix];
          viewS++;
          if (otHite >= myHite) {break;}
        }
        
        score = viewW * viewE * viewN * viewS;
        mxScre = max(score, mxScre);

        //print(String.format("S %2d %2d  %d   %2d %2d %2d %2d   %10d", jx,  ix, myHite, viewW, viewE, viewN, viewS, score));
       
      }
      println();
    }
  }
  return mxScre;
}



void setup()    
{
  
  int diskSize = 70000000;
  int freeSpac;
  int reqdSpac = 30000000;
  int reqDelet;
  int nofTVis;
  int maxScenic;
  
  size(300, 300);
  frameRate(1);
  loadData();
  scanData();
  SetVis();
  nofTVis =  count();
  println(String.format("Tot Vis %12d", nofTVis));
  
  maxScenic = scenic();
  
  println(String.format("Max scenic %12d", maxScenic));
}

void draw()
{
  background(20);
  int ix, jx;
  int iGX, iGY;

  textSize(24);
  for (jx = 0; jx < treesPerRow; jx++){
    iGY = 24 + 30 * jx;
    for (ix = 0; ix < treesPerRow; ix++){
      noStroke();
      fill(0, 255, 0); // gre
      if (visibles[jx][ix]) {fill(255, 0, 0);}
      iGX = 10 + 30 * ix;
      text(trees[jx][ix], iGX, iGY);
      //text(visibles[jx][ix] ? "T" : ".", iGX, iGY);
      
      if (!(ix == 0 || ix == treesPerRow - 1 || jx == 0 || jx == treesPerRow - 1)) {
        
        fill(0, 255, 0); // gre
        if (visibleW[jx][ix]) {fill(255, 0, 0);}
        rect(iGX - 3, iGY - 24 + 6, 2, 24 - 4);
         
        fill(0, 255, 0); // gre
        if (visibleE[jx][ix]) {fill(255, 0, 0);}
        rect(iGX - 3 + 24 - 6, iGY - 24 + 6, 2, 24 - 4);

        fill(0, 255, 0); // gre
        if (visibleN[jx][ix]) {fill(255, 0, 0);}
        rect(iGX - 3 - 6 + 6, iGY - 24 + 6, 24 - 8, 2);

        fill(0, 255, 0); // gre
        if (visibleS[jx][ix]) {fill(255, 0, 0);}
        rect(iGX - 3 - 6 + 6, iGY  + 6 - 2, 24 - 8, 2);

    
  


    }
       

      
    }
  }

  
}
