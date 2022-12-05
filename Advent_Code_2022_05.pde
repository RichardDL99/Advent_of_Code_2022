

// Elf Stacks of Crates

final boolean F = false;
final boolean T = true;

int nofStacks  = 10;               // Stacks 1 to 9, ignore 0
int nofCrPerSt = 50;                // GUESS, WILL CRASH IF WRONG
char stacks[][] = new char[nofStacks][nofCrPerSt];
int nofCratesInSt[] = new int [nofCrPerSt];

String fileLines[];       // need file available as we work through the moves
int lineNo;               // nof line we're going to use next
int highestCrate;         // 0..n


void loadData()
{
  int stackIx;
  int crateIx;
  int ix;
  String aLine;
  char cLabel;
  
  // initialise the stacks
  for (stackIx = 1; stackIx < nofStacks; stackIx++)
  {
    for (crateIx = 0; crateIx < nofCrPerSt; crateIx++)
    {
      stacks[stackIx][crateIx] = ' ';
    }
    nofCratesInSt[stackIx] = 0;
  }

  fileLines = loadStrings("Data_05_02.dat");
  println("No of lines" + fileLines.length);

  // print the data
  for (lineNo = 0 ; lineNo < fileLines.length; lineNo++) 
  {
    print(String.format("L %4d: %s", lineNo, fileLines[lineNo]));
    ix = fileLines[lineNo].indexOf('[');
    print(String.format("      ix %2d", ix));
    println();
  }
  
  
  // find the highest crate
  for (lineNo = 0 ; lineNo < fileLines.length; lineNo++) 
  {
    aLine = fileLines[lineNo];
    print(String.format("L %4d: %s", lineNo, aLine));
    ix = aLine.indexOf('[');
    print(String.format("      ix %2d", ix));
    if (ix < 0) {println(); break;}
    //aLine = aLine.replace(" ", "");
    //aLine = aLine.replace("[", "");
    //aLine = aLine.replace("]", "");
    //print(String.format(" ~%s~ ", aLine));
    println();    
  }
  highestCrate = lineNo - 1;
  println(String.format("HC %2s", highestCrate));

  // load the stack data
  crateIx = highestCrate; 
  for (lineNo = 0 ; lineNo < fileLines.length; lineNo++) 
  {
    aLine = fileLines[lineNo];
    print(String.format("L %4d: %s", lineNo, aLine));
    ix = aLine.indexOf('[');
    if (ix < 0) {println(); break;}

    for (stackIx = 1; stackIx < nofStacks; stackIx++)
    {
      ix = 1 + (stackIx - 1)* 4;
      if (ix < aLine.length() - 1)
      {
        cLabel = aLine.charAt(ix);
        print(cLabel);
        if (!(cLabel == ' '))
        {
          stacks[stackIx][crateIx] = cLabel;
          if (nofCratesInSt[stackIx] == 0) {nofCratesInSt[stackIx] = crateIx + 1;}
        }
      }
    }
    println();
    crateIx--;
  }
}

void move1Crate(int stackS, int stackE)
{
  char cLabel;
  int crateIx; 
  println(String.format("  MoveC %2d %2d", stackS, stackE));

  // Let's trust that we're not going below zero
  // From
  crateIx = nofCratesInSt[stackS] - 1;
  cLabel = stacks[stackS][crateIx];
  stacks[stackS][crateIx] = ' ';
  nofCratesInSt[stackS]--;
  // To
  nofCratesInSt[stackE]++;
  crateIx = nofCratesInSt[stackE] - 1;
  stacks[stackE][crateIx] = cLabel;
}

void moveNCrate(int nofMov, int stackS, int stackE)
{
  char cLabel;
  int crateIx; 
  int moveNo;
  for (moveNo = 0; moveNo < nofMov; moveNo++)
  {
    // Move them 1 at a time, would not work for real, but here alright
    // Moving top of source first.
    // Let's trust that we're not going below zero
    // From
    crateIx = nofCratesInSt[stackS] - 1;
    cLabel = stacks[stackS][crateIx];
    stacks[stackS][crateIx] = ' ';
    nofCratesInSt[stackS]--;
    
    // To
    crateIx = nofCratesInSt[stackE] - 1 + nofMov - moveNo;
    stacks[stackE][crateIx] = cLabel;

    
  }
  nofCratesInSt[stackE] += nofMov;
}


boolean do1Move(int opt) //actually 1 move instruction
{
  boolean retVal = F;
  String aLine;
  int nofMov;
  int stackS;
  int stackE;
  String Ary[];
  int moveNo;
  
  if (lineNo < fileLines.length)
  {
    //retVal = F;
    aLine = fileLines[lineNo];
    if (aLine.length() > 0 && aLine.charAt(0) == 'm')
    {
      print(String.format("ML %4d: %s", lineNo, fileLines[lineNo]));
      //print(aLine.charAt(0));
      println();
      Ary = aLine.split(" ");
      //printArray(Ary);
      
      nofMov = Integer.parseInt(Ary[1]);
      stackS = Integer.parseInt(Ary[3]);
      stackE = Integer.parseInt(Ary[5]);
      //println(String.format("MSE %2d %2d %2d", nofMov, stackS, stackE));

      if (opt == 0)
      {
        for (moveNo = 0; moveNo < nofMov; moveNo++)
        {
          move1Crate(stackS, stackE);
        }
      }
      if (opt == 1)
      {
        moveNCrate(nofMov, stackS, stackE);
      }
    }
    lineNo++;
  }
  else {retVal = T;}
  
  return retVal;
}

void setup()
{
  size(300, 800);
  frameRate(10);
  loadData();
}

boolean finished = F;

void draw()
{
  int stackIx;
  int crateIx;
  int ix;
  int iGX, iGY;
  char cLabel;
  
  background(20);
  
  textSize(16);
  // draw the stacks
  for (stackIx = 1; stackIx < nofStacks; stackIx++)
  {
    iGX = 50 + 20 * stackIx; 
    for (crateIx = 0; crateIx < nofCrPerSt; crateIx++)
    {
      iGY = height - 20 - 15 * crateIx;
      // = ' ';
      fill(20, 20, 20);
      rect(iGX, iGY, 12, 12);
      if (crateIx < nofCratesInSt[stackIx]) {cLabel = stacks[stackIx][crateIx];}
      else                                    cLabel = '-';
      fill( 0, 200,  0);
      text(cLabel, iGX + 1, iGY + 12);
    }
  }
  if (frameCount > 2 && !finished)
  {
    finished = do1Move(1);
  }
  //if (finished) {exit();}
}
