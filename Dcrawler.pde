Dungeon dungeon;
int[] dungeon_map;

void setup()
{
  fullScreen();
  fill(0);
  dungeon = new Dungeon(80, 25, 0, 0, 100, 75, 25);
  dungeon.createDungeon(80, 25, 100);
  dungeon_map = dungeon.dungeon_map;
}


void draw()
{
  for(int i = 0; i < 80*25; ++i) {
    int x = (i/25)*40;
    int y = (i%25)*40;
    switch(dungeon_map[i]) {
      case 0: {
        PImage img;
        img = loadImage("DirtFloor.jpg");
        image(img, x, y, 40, 40);
        break;
      }
      case 1: {
        PImage img;
        img = loadImage("DirtWall.jpg");
        image(img, x, y, 40, 40);
        break;
      }
      case 2: {
        PImage img;
        img = loadImage("DirtFloor.jpg");
        image(img, x, y, 40, 40);
        break;
      }
      case 4: {
        PImage img;
        img = loadImage("DirtFloor.jpg");
        image(img, x, y, 40, 40);
        break;
      }
      case 3: {
         PImage img;
        img = loadImage("DirtWall.jpg");
        image(img, x, y, 40, 40);
        break;
      }
    }
  }
}
