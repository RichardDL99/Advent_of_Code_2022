// Elf Filing System 

final boolean F = false;
final boolean T = true;

int planSizX = 500;
int planSizY = 14  00;
boolean plane[][] = new boolean[planSizY][planSizX];
int minX, minY, maxX, maxY;
int myScale = 16;

int posStart[] = new int[2];  // x, y
int posHead[] = new int[2];
int posTail[] = new int[2];

int nofKnots = 10;
int knots[][] = new int[nofKnots][2];




class aMoveSpec
{
  char direction;
  int  nof;
  
  aMoveSpec(char _c, int _n)
  {
    direction = _c;
    nof = _n;
  }
}

aMoveSpec moveSpecs[];
int nofMoveSpecs;
int moveNo;
int subMNo;

String fileLines[];


void loadData()
{
  String filename;
  int lineNo;
  
  filename = "Data_09_02.dat";
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
  String ary[];
  char cHite;
  int hite;
  int ix, jx;

  
  nofMoveSpecs = fileLines.length;
  println(nofMoveSpecs);
  moveSpecs = new aMoveSpec[nofMoveSpecs];

  for (jx = 0; jx < nofMoveSpecs; jx++){
    aLine = fileLines[jx];
    ary = split(aLine, " ");
      //printArray(ary);
    moveSpecs[jx] = new aMoveSpec(ary[0].charAt(0), Integer.parseInt(ary[1]));
    //moveSpecs[jx].direction = 'x'; //ary[0].charAt(0);
    // moveSpecs[jx].nof = Integer.parseInt(ary[1]);
    print(String.format("S %4d %s %2d",jx, moveSpecs[jx].direction, moveSpecs[jx].nof ));
    println();
  }  
}


void  do1Move0()
{
  // this was original, when had H and T
  int nofSMovs;
  int diffX;
  int diffY;
  int abDfX;
  int abDfY;
  int movX;
  int movY;
  
  
  if (moveNo < nofMoveSpecs)
  {
    if (subMNo == 0) {print(String.format("Move no. %4d  ", moveNo));}  
    print(moveSpecs[moveNo].direction);
    switch (moveSpecs[moveNo].direction)
    {
      case 'L':
        posHead[0]--;
        break;
      case 'R':
        posHead[0]++;
        break;
      case 'U':
        posHead[1]++;
        break;
      case 'D':
        posHead[1]--;  
        break;
    }    
    nofSMovs = moveSpecs[moveNo].nof;
    subMNo++;
    if (subMNo < nofSMovs) {}
    else
    {
      println();
      moveNo++;  
      subMNo = 0;
    }
  }
  // think about the tail
  diffX = posHead[0] - posTail[0];
  diffY = posHead[1] - posTail[1];
  abDfX = abs(diffX);
  abDfY = abs(diffY);
  
  if (abDfX > 1 || abDfY > 1)
  {
    // have to move tail.
    // 2 types of move, single direction or diagonal
    
    movX = 0;
    if (diffX > 0) {movX =   1;}
    if (diffX < 0) {movX =  -1;}
    
    movY = 0;
    if (diffY > 0) {movY =   1;}
    if (diffY < 0) {movY =  -1;}
    
    if (diffX != 0 && diffY == 0) {
      // X move only
      posTail[0] += movX;
    }
    else if (diffX == 0 && diffY != 0) {
      // Y move only
      posTail[1] += movY;
    }

    else if (abDfX == 2 || abDfY == 2) {
      posTail[0] += movX;
      posTail[1] += movY;
    }
    
    
  }
}

void  do1Move1()
{
  // now with 10 knots
  int nofSMovs;
  int diffX;
  int diffY;
  int abDfX;
  int abDfY;
  int movX;
  int movY;
  int kix;
    
  if (moveNo < nofMoveSpecs)
  {
    if (subMNo == 0) {print(String.format("Move no. %4d  ", moveNo));}  
    print(moveSpecs[moveNo].direction);
    switch (moveSpecs[moveNo].direction)
    {
      case 'L':
        knots[0][0]--;
        break;
      case 'R':
        knots[0][0]++;
        break;
      case 'U':
        knots[0][1]++;
        break;
      case 'D':
        knots[0][1]--;  
        break;
    }    
    nofSMovs = moveSpecs[moveNo].nof;
    subMNo++;
    if (subMNo < nofSMovs) {}
    else
    {
      println();
      moveNo++;  
      subMNo = 0;
    }
  }
  // nofKnots
  for (kix = 1; kix < nofKnots ; kix++)
  {
    diffX = knots[kix - 1][0] - knots[kix][0];
    diffY = knots[kix - 1][1] - knots[kix][1];
    abDfX = abs(diffX);
    abDfY = abs(diffY);
    
    if (abDfX > 1 || abDfY > 1)
    {
      // have to move tail.
      // 2 types of move, single direction or diagonal
      
      movX = 0;
      if (diffX > 0) {movX =   1;}
      if (diffX < 0) {movX =  -1;}
      
      movY = 0;
      if (diffY > 0) {movY =   1;}
      if (diffY < 0) {movY =  -1;}
      
      if (diffX != 0 && diffY == 0) {
        // X move only
        knots[kix][0] += movX;
      }
      else if (diffX == 0 && diffY != 0) {
        // Y move only
        knots[kix][1] += movY;
      }  
      else if (abDfX == 2 || abDfY == 2) {
        knots[kix][0] += movX;
        knots[kix][1] += movY;
      }
    }
  }
}

void trace0()
{
  if (posTail[0] >= 0 && posTail[0] < planSizX
   && posTail[1] >= 0 && posTail[1] < planSizY) 
  { 
    plane[posTail[1]][posTail[0]] = T;
    
    if (posTail[0] < minX)
    {
      minX = posTail[0];
    }
    if (posTail[1] < minY)
    {
      minY = posTail[1];
    }
    
    if (posTail[0] > maxX)
    {
      maxX = posTail[0];
      println(String.format("MaxX %4d", maxX));
      //delay(250);
    }
    if (posTail[1] > maxY)
    {
      maxY = posTail[1];
      println(String.format("    MaxY %4d", maxY));
      //delay(250);
    }
    
    myScale = min(width / (1 + maxX - minX), height / (1 + maxY - minY), 20);
   
  }
  else {
    println(String.format("Out of dimension M XY %4d  %4d %4d", moveNo, posTail[0], posTail[1]));
    delay(5000);
  }
  
}



void trace1()
{
  int kix;
  kix = nofKnots - 1;
  // are we within the set grid?
  if (knots[kix][0] >= 0 && knots[kix][0] < planSizX
   && knots[kix][1] >= 0 && knots[kix][1] < planSizY) 
  { 
    // yes, track the position
    plane[knots[kix][1]][knots[kix][0]] = T;
    
    if (knots[kix][0] < minX)
    {
      minX = knots[kix][0];
    }
    if (knots[kix][1] < minY)
    {
      minY = knots[kix][1];
    }
    
    
    if (knots[kix][0] > maxX)
    {
      maxX = knots[kix][0];
      println(String.format("MaxX %4d", maxX));
      //delay(250);
    }
    if (knots[kix][1] > maxY)
    {
      maxY = knots[kix][1];
      println(String.format("    MaxY %4d", maxY));
      //delay(250);
    }
    
    myScale = min(width / (1 + maxX - minX), height / (1 + maxY - minY), 20);
    myScale = myScale * 6 / 10;
   
  }
  else {
  println(String.format("Out of dimension M XY %4d  %4d %4d", moveNo, knots[kix][0], knots[kix][1]));
  delay(50000);
}
  
}


void count()
{
  int nofSqVisit;
  int jx, ix;
  nofSqVisit = 0;
  
  for (jx = 0; jx < planSizY; jx++) for (ix = 0; ix < planSizX; ix++){
    if (plane[jx][ix]) nofSqVisit++; 
  }
  println(String.format("Nof Sq Visit %6d", nofSqVisit));
}

void setup()    
{
  
  int diskSize = 70000000;
  int freeSpac;
  int reqdSpac = 30000000;
  int reqDelet;
  int nofTVis;
  int maxScenic;
  int startX;
  int startY;
  int kix;
  
  
  size(900, 800);
  frameRate(30);
  loadData();
  scanData();

  startX = planSizX / 2;
  startY = planSizY / 2;

  if (T) {
    // Offsets for part 2
    startX += 20;
    startY -= 30 + 30 - 20 - 20 - 10 - 30 - 30 - 5 - 15 - 15 - 10 - 20 - 30;
  }
  
  
  posStart[0]  = startX;
  posStart[1]  = startY;
  
  posHead[0]  = startX;
  posHead[1]  = startY;
  
  posTail[0]  = startX;
  posTail[1]  = startY;
  
  for (kix = 0; kix < nofKnots; kix++) {
    knots[kix][0] = startX;
    knots[kix][1] = startY;
  }
  
  //trace0();
  trace1();


  moveNo = 0;
  subMNo = 0;
  minX = startX;
  minY = startY;
  maxX = startX;
  maxY = startY;
}

void draw()
{
  int ix, jx;
  int iGX, iGY;
  int offsX;
  int offsY;
  int kix;

  offsX = 0 + width  /  2 - (planSizX * myScale) * 17 / 32;
  offsY = 0 - height / 2  + (planSizY * myScale) * 17 / 32;

  if (frameCount % 50 == 0){
    background(20);
    textSize(myScale + 2);
    for (jx = 0; jx < planSizY; jx++){
      iGY = offsY + height - (5 + myScale + (myScale + 1) * jx);
      for (ix = 0; ix < planSizX; ix++){
        noStroke();
        fill(40, 40, 40); // gry
        if (plane[jx][ix]) {fill(0, 0, 200);}
        if (jx == 0 && ix == 0) {fill(120);}
        if (jx == posStart[1] && ix == posStart[0]) {fill(100);}
        iGX = offsX + myScale + (myScale + 1) * ix;
        //text(trees[jx][ix], iGX, iGY);
        //text(visibles[jx][ix] ? "T" : ".", iGX, iGY);
        rect(iGX, iGY, myScale, myScale);
      }
    }
  
    textAlign(LEFT, TOP);
    fill(255);
    
    // Draw the original 2 knots
    if (F) {
      ix = posHead[0];
      jx = posHead[1];
      iGY = offsY + height - (5 + myScale + (myScale + 1) * jx) - 4;
      iGX = offsX + myScale + (myScale + 1) * ix + 2;
      text("H", iGX, iGY);
    
      ix = posTail[0];
      jx = posTail[1];
      iGY = offsY + height - (5 + myScale + (myScale + 1) * jx) - 4;
      iGX = offsX + myScale + (myScale + 1) * ix + 2;
      text("T", iGX, iGY);
    }
    
    // Draw the 10 knots.
    
    for (kix = 0;kix < nofKnots; kix++) {
      ix = knots[kix][0];
      jx = knots[kix][1];
      iGY = offsY + height - (5 + myScale + (myScale + 1) * jx) - 4;
      iGX = offsX + myScale + (myScale + 1) * ix + 2;
      text(kix, iGX, iGY);
    }
  
  }

  //do1Move0();
  do1Move1();
  //trace0();
  trace1();
  
  if (moveNo == nofMoveSpecs)
  {
    count();
    moveNo++;  // VERY SORRY
  }
  
}
