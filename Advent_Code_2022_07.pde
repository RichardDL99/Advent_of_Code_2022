// Elf Filing System 

final boolean F = false;
final boolean T = true;

thing fileSystem;

String fileLines[];       // need file available as we work through the moves
int lineNo;               // nof line we're going to use next

void loadData()
{
  String filename;
  filename = "Data_07_02.dat";
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
  boolean found;
  fileSystem = new thing(null, "/" , 'D', 0);

  int ix;
  int lineNo;
  int fileSize;
  
  String ary[];
  String fileName;
  thing thg;
  thing cwd;
  
  cwd = fileSystem;
  
  for (lineNo = 0 ; lineNo < fileLines.length; lineNo++)
  {
    aLine = fileLines[lineNo];
    ary = aLine.split(" ");
    if (!(ary[0].equals("dir") || (ary[0].equals("$") && ary[1].equals("ls"))))
    {
      /* What remains is one of 2 structures
      size 2, file-size, filename
      size 3, $ cd name
      We can simply use the size to determine!
      */
      
      //print(String.format("S %4d: %s", lineNo, fileLines[lineNo])); println();
      printArray(ary);
      println();
      
      switch (ary.length)
      {
        case 2:  // new file
          fileName = ary[1];
          fileSize = Integer.parseInt(ary[0]);
          thg = new thing(cwd, fileName, 'F', fileSize);
          cwd.files.add(thg);
          break;
        
        case 3:  // change directory
          if (ary[0].equals("$") && ary[1].equals("cd"))
          {
            fileName = ary[2];
            if (!fileName.equals("/")) // they only use / once at the top
            {
              if (fileName.equals(".."))
              {
                // back up 1 (let's trust them not to go off the top)
                cwd = cwd.parent;  
              }
              else
              {
                thg = new thing(cwd, fileName, 'D', 0);
                cwd.files.add(thg);
                // what if they change twice to same dir? check for that
                cwd = thg;
              }
            }
          }
          else
          {
            println("PANIC 2");
            exit();
            break;
          }
          break;
        
        default:
          println("PANIC 1");
          exit();
          break;
      }
    }
  }
  //println(aLine);
  //print(String.format("Found B at %3d", ix));
  //println();
}

void review(thing cwd, int depth)
{
  int ix;
  int bx;
  thing thg;
  for (ix = 0; ix < cwd.files.size(); ix++)
  {
    thg = cwd.files.get(ix);
    for (bx = 0; bx < depth; bx++) {print("  ");}
    println(String.format("%-10s, %s, %10d", thg.name, thg.type, thg.size));
    if (thg.type == 'D')
    {
      review(thg, depth + 1);
    }
  }
}

int assess(thing cwd, int depth)
{
  int ix;
  int bx;
  thing thg;
  int mySize = 0;
  
  for (ix = 0; ix < cwd.files.size(); ix++)
  {
    thg = cwd.files.get(ix);
    print("Aa ");
    for (bx = 0; bx < depth; bx++) {print("  ");}
    println(String.format("%-10s, %s, %10d", thg.name, thg.type, thg.size));
    if (thg.type == 'F')
    {
      cwd.size += thg.size;
    }
    if (thg.type == 'D')
    {
      assess(thg, depth + 1);
      cwd.size += thg.size;
      print("Ad ");
      for (bx = 0; bx < depth; bx++) {print("  ");}
      println(String.format("%-10s, %s, %10d", thg.name, thg.type, thg.size));
    }
  }
  //cwd.size = mySize;
  return mySize;
}

int totalSize = 0;

int countAdd(thing cwd, int depth)
{
  int ix;
  int bx;
  thing thg;
  int mySize = 0;
  
  for (ix = 0; ix < cwd.files.size(); ix++)
  {
    thg = cwd.files.get(ix);
    //print("Ca ");
    //for (bx = 0; bx < depth; bx++) {print("  ");}
    //println(String.format("%-10s, %s, %10d", thg.name, thg.type, thg.size));
    if (thg.type == 'F')
    {
    }
    if (thg.type == 'D')
    {
      mySize += countAdd(thg, depth + 1);
      print("Cd ");
      for (bx = 0; bx < depth; bx++) {print("  ");}
      println(String.format("%-10s, %s, %10d", thg.name, thg.type, thg.size));
      //if (thg.size <= 10000) {mySize += thg.size;}
      if (thg.size <= 100000) {totalSize += thg.size;}
    }
  }
  return mySize;
}

void setup()
{
  int size;
  
  int diskSize = 70000000;
  int freeSpac;
  int reqdSpac = 30000000;
  int reqDelet;
  
  size(300, 200);
  frameRate(10);
  loadData();
  scanData();
  review(fileSystem, 0);
  assess(fileSystem, 0);  // sum the file and directory sizes into the directory sizes
  println();
  size = countAdd(fileSystem, 0);
  //println(String.format("Tot size %12d", size));
  println();
  println(String.format("Tot size limited %12d", totalSize));
  println(String.format("Tot size         %12d", fileSystem.size));
  
  freeSpac = diskSize - fileSystem.size;
  
  println(String.format("Free space       %12d", freeSpac));
  reqDelet = reqdSpac - freeSpac;  
  println(String.format("ReqDel space     %12d", reqDelet));
  exit();
}

void draw()
{
  background(20);  
}
