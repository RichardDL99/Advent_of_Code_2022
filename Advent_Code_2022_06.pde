


// Elf 



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
  String filename;
  filename = "Data_06_06.dat";
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
  int ix;
  String aLine;
  boolean found;
  
  aLine = fileLines[0];
  println(aLine);
  for (ix = 0; ix < aLine.length(); ix++)
  {
    print(aLine.charAt(ix));
    if (ix >= 3)
    {
      if  ((aLine.charAt(ix - 0) != aLine.charAt(ix - 1))
       &&  (aLine.charAt(ix - 0) != aLine.charAt(ix - 2))
       &&  (aLine.charAt(ix - 0) != aLine.charAt(ix - 3))
       &&  (aLine.charAt(ix - 1) != aLine.charAt(ix - 2))
       &&  (aLine.charAt(ix - 1) != aLine.charAt(ix - 3))
       &&  (aLine.charAt(ix - 2) != aLine.charAt(ix - 3)))
       {
         found = T;
         ix++;
         break;
       }
    }
  }
  println();
  print(String.format("Found A at %3d", ix));
  println();
    
  int jx, kx;
  boolean chEql;
  int testLen = 4;
  
  testLen = 14;  
  for (ix = 0; ix < aLine.length(); ix++)
  {
    chEql = F;
    if (ix >= testLen)
    {
      for (jx = ix; jx > ix - testLen; jx--)
      {
        for (kx = jx - 1; kx > ix - testLen; kx--)
        {
          //println(String.format("KJ  %4d %4d", kx, jx));
          if (aLine.charAt(kx) == aLine.charAt(jx)) 
          {
            chEql = T;
            break;
          }
        }
        if (chEql) {break;}
      }
      if (!chEql) {ix++; break;}
    }
    //println();
  }
  println();
  print(String.format("Found B at %3d", ix));
  println();
}

void setup()
{
  size(300, 200);
  frameRate(10);
  loadData();
  scanData();
  exit();
}

boolean finished = F;

void draw()
{
  background(20);
  
}
