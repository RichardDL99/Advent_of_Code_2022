// Elf Radio 

final boolean F = false;
final boolean T = true;


class anInstruction
{
  String instruction;
  int  value;
  
  anInstruction(String _i, int _v)
  {
    instruction = _i;
    value = _v;
  }
}

anInstruction theProg[];
int nofLines;

String fileLines[];


void loadData()
{
  String filename;
  int lineNo;
  
  filename = "Data_10_03.dat";
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
  String instruction;
  int value;

  char cHite;
  int hite;
  int ix, jx;

  
  nofLines = fileLines.length;
  println(String.format("Nof lines %d", nofLines));
  theProg = new anInstruction[nofLines];



  for (jx = 0; jx < nofLines; jx++){
    aLine = fileLines[jx];
    ary = split(aLine, " ");
    printArray(ary);
    
    instruction = ary[0];
    if (ary.length > 1) {value = Integer.parseInt(ary[1]);}
    else                 value = 0;
  
    theProg[jx] = new anInstruction(instruction, value);
    
    print(String.format("S %4d %s %2d",jx, theProg[jx].instruction, theProg[jx].value));
    println();
  }  
}

int totalStr = 0;

void testVal(int inNo, int rX, int cCnt)
{
  int strength;
  
  strength = cCnt * rX;
  if ((cCnt - 20) % 40 == 0)
  {
    println(String.format("IXC %4d  %3d  %4d  S %4d", inNo, cCnt, rX, strength));
    totalStr += strength;
  }
  int xChr, yChr;
  int iGX, iGY;
  int gScale = 10;
  
  xChr = (cCnt - 1) % 40;
  yChr = (cCnt - 1) / 40;
  iGX = gScale + xChr * gScale;
  iGY = gScale + yChr * gScale;
  
  fill(20);
  if (rX >= xChr - 1 && rX <= xChr + 1)
  {fill(0, 200, 0);}
  rect(iGX, iGY, gScale - 1, gScale - 1);
  
}



int regX;
int cyclCount;



void doCPU()
{
  int jx;

  regX = 1;
  cyclCount = 0;
  
  for (jx = 0; jx < nofLines; jx++){
    switch (theProg[jx].instruction){
      case "noop":
        cyclCount++;
        testVal(jx, regX, cyclCount);
        break;
      case "addx":
        cyclCount++;
        testVal(jx, regX, cyclCount);
        cyclCount++;
        testVal(jx, regX, cyclCount);
        regX += theProg[jx].value; 
        break;
    }
  }
}


void setup()    
{
  size(500, 300);
  frameRate(1);
  loadData();
  scanData();
  background(10);
  doCPU();
  println(String.format("Total str %10d", totalStr));
}

void draw()
{
}
