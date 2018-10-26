import java.util.Random;

class Dungeon {
    private int xmax, ymax, xsize, ysize, objects, chanceRoom, chanceCorridor;
    public int[] dungeon_map;

    private Random rand = new Random();

    private final int UNUSED = 0, DIRTWALL = 1, DIRTFLOOR = 2, STONEWALL = 3, CORRIDOR = 4, DOOR = 5, UPSTAIRS = 6, DOWNSTAIRS = 7, CHEST = 8;

    public Dungeon(int xmax, int ymax, int xsize, int ysize, int objects, int chanceRoom, int chanceCorridor) {
        this.xmax = xmax;
        this.ymax = ymax;
        this.xsize = xsize;
        this.ysize = ysize;
        this.objects = objects;
        this.chanceRoom = chanceRoom;
        this.chanceCorridor = chanceCorridor;
    }

    private void setCell(int x, int y, int cellType)
    {
        dungeon_map[x + xsize * y] = cellType;
    }

    private int getCell(int x, int y)
    {
        return dungeon_map[x + xsize * y];
    }

    private boolean makeCorridor(int x, int y, int length, int direction)
    {
        int len = rand.nextInt(length - 1) + 2;
        int floor = CORRIDOR;
        int dir = 0;
        if(direction > 0 && direction < 4)
            dir = direction;
        int xtemp = 0;
        int ytemp = 0;
        switch(dir) {
            case 0: {
                if (x < 0 || x > xsize)
                    return false;
                else
                    xtemp = x;
                for (ytemp = y; ytemp > (y - len); --ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    if (getCell(xtemp, ytemp) != UNUSED)
                        return false;
                }
                for (ytemp = y; ytemp > (y - len); --ytemp) {
                    setCell(xtemp, ytemp, floor);
                }
                break;
            }
            case 1: {
                if(y < 0 || y > ysize)
                    return false;
                else
                    ytemp = y;
                for(xtemp = x; xtemp < (x + len); ++xtemp) {
                    if (xtemp < 0 || xtemp > xsize)
                        return false;
                    if (getCell(xtemp, ytemp) != UNUSED)
                        return false;
                }
                for (xtemp = x; xtemp < (x + len); ++xtemp) {
                    setCell(xtemp, ytemp, floor);
                }
                break;
            }
            case 2: {
                if (x < 0 || x > xsize)
                    return false;
                else
                    xtemp = x;
                for (ytemp = y; ytemp < (y + len); ++ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    if (getCell(xtemp, ytemp) != UNUSED)
                        return false;
                }
                for (ytemp = y; ytemp < (y + len); ++ytemp) {
                    setCell(xtemp, ytemp, floor);
                }
                break;
            }
            case 3: {
                if (ytemp < 0 || ytemp > ysize)
                    return false;
                else
                    ytemp = y;
                for (xtemp = x; xtemp > (x-len); --xtemp) {
                    if (xtemp < 0 || xtemp > xsize)
                        return false;
                    if (getCell(xtemp, ytemp) != UNUSED)
                        return false;
                }
                for (xtemp = x; xtemp > (x-len); --xtemp){
                    setCell(xtemp, ytemp, floor);
                }
                break;
            }
        }
        return true;
    }

    private boolean makeRoom(int x, int y, int xlength, int ylength, int direction) {
        int xlen = rand.nextInt(xlength - 3) + 4;
        int ylen = rand.nextInt(ylength - 3) + 4;
        int floor = DIRTFLOOR;
        int wall = DIRTWALL;
        int dir = 0;
        if (direction > 0 && direction < 4)
            dir = direction;
        switch (dir) {
            case 0: {
                for (int ytemp = y; ytemp > (y - ylen); --ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    for (int xtemp = (x - xlen / 2); xtemp < (x + (xlen + 1) / 2); ++xtemp) {
                        if (xtemp < 0 || xtemp > xsize)
                            return false;
                        if (getCell(xtemp, ytemp) != UNUSED)
                            return false;
                    }
                }
                for (int ytemp = y; ytemp > (y - ylen); --ytemp) {
                    for (int xtemp = (x - xlen / 2); xtemp < (x + (xlen + 1) / 2); ++xtemp) {
                        if (xtemp == (x - xlen / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (xtemp == (x + (xlen - 1) / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == y)
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y - ylen + 1))
                            setCell(xtemp, ytemp, wall);
                        else
                            setCell(xtemp, ytemp, floor);
                    }
                }
                break;
            }
            case 1: {
                //east
                for (int ytemp = (y - ylen / 2); ytemp < (y + (ylen + 1) / 2); ++ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    for (int xtemp = x; xtemp < (x + xlen); ++xtemp) {
                        if (xtemp < 0 || xtemp > xsize)
                            return false;
                        if (getCell(xtemp, ytemp) != UNUSED)
                            return false;
                    }
                }
                for (int ytemp = (y - ylen / 2); ytemp < (y + (ylen + 1) / 2); ++ytemp) {
                    for (int xtemp = x; xtemp < (x + xlen); ++xtemp) {

                        if (xtemp == x) setCell(xtemp, ytemp, wall);
                        else if (xtemp == (x + xlen - 1))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y - ylen / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y + (ylen - 1) / 2))
                            setCell(xtemp, ytemp, wall);
                        else
                            setCell(xtemp, ytemp, floor);
                    }
                }
                break;
            }
            case 2: {
                //south
                for (int ytemp = y; ytemp < (y + ylen); ++ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    for (int xtemp = (x - xlen / 2); xtemp < (x + (xlen + 1) / 2); ++xtemp) {
                        if (xtemp < 0 || xtemp > xsize)
                            return false;
                        if (getCell(xtemp, ytemp) != UNUSED)
                            return false;
                    }
                }
                for (int ytemp = y; ytemp < (y + ylen); ++ytemp) {
                    for (int xtemp = (x - xlen / 2); xtemp < (x + (xlen + 1) / 2); ++xtemp) {
                        if (xtemp == (x - xlen / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (xtemp == (x + (xlen - 1) / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == y)
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y + ylen - 1))
                            setCell(xtemp, ytemp, wall);
                        else setCell(xtemp, ytemp, floor);
                    }
                }
                break;
            }
            case 3: {
                //west
                for (int ytemp = (y - ylen / 2); ytemp < (y + (ylen + 1) / 2); ++ytemp) {
                    if (ytemp < 0 || ytemp > ysize)
                        return false;
                    for (int xtemp = x; xtemp > (x - xlen); --xtemp) {
                        if (xtemp < 0 || xtemp > xsize)
                            return false;
                        if (getCell(xtemp, ytemp) != UNUSED)
                            return false;
                    }
                }

                for (int ytemp = (y - ylen / 2); ytemp < (y + (ylen + 1) / 2); ++ytemp) {
                    for (int xtemp = x; xtemp > (x - xlen); --xtemp) {
                        if (xtemp == x)
                            setCell(xtemp, ytemp, wall);
                        else if (xtemp == (x - xlen + 1))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y - ylen / 2))
                            setCell(xtemp, ytemp, wall);
                        else if (ytemp == (y + (ylen - 1) / 2))
                            setCell(xtemp, ytemp, wall);
                        else
                            setCell(xtemp, ytemp, floor);
                    }
                }
                break;
            }
        }
        return true;
    }

    private boolean createDungeon(int inx, int iny, int inobj) {
        if (inobj < 1)
            objects = 10;
        else
            objects = inobj;
        if (inx < 3)
            xsize = 3;
        else if (inx > xmax)
            xsize = xmax;
        else
            xsize = inx;
        if (iny < 3)
            ysize = 3;
        else if (iny > ymax)
            ysize = ymax;
        else
            ysize = iny;
        dungeon_map = new int[(xsize + 1) * (ysize + 1)];
        for (int y = 0; y < ysize; ++y) {
            for (int x = 0; x < xsize; ++x) {
                if (y == 0)
                    setCell(x, y, STONEWALL);
                else if (y == ysize - 1)
                    setCell(x, y, STONEWALL);
                else if (x == 0)
                    setCell(x, y, STONEWALL);
                else if (x == xsize - 1)
                    setCell(x, y, STONEWALL);
                else
                    setCell(x, y, UNUSED);
            }
        }
        makeRoom(xsize / 2, ysize / 2, 8, 6, rand.nextInt(4));
        int currentFeatures = 1;
        for (int countingTries = 0; countingTries < 1000; ++countingTries) {
            if (currentFeatures == objects) {
                break;
            }
            int newx = 0;
            int xmod = 0;
            int newy = 0;
            int ymod = 0;
            int validTile = -1;
            for (int testing = 0; testing < 1000; ++testing) {
                newx = rand.nextInt(xsize - 1) + 1;
                newy = rand.nextInt(ysize - 1) + 1;
                validTile = -1;
                if (getCell(newx, newy) == DIRTWALL || getCell(newx, newy + 1) == CORRIDOR) {
                    if (getCell(newx, newy + 1) == DIRTFLOOR || getCell(newx, newy + 1) == CORRIDOR) {
                        validTile = 0;
                        xmod = 0;
                        ymod = -1;
                    } else if (getCell(newx - 1, newy) == DIRTFLOOR || getCell(newx - 1, newy) == CORRIDOR) {
                        validTile = 1;
                        xmod = 1;
                        ymod = 0;
                    } else if (getCell(newx, newy - 1) == DIRTFLOOR || getCell(newx, newy - 1) == CORRIDOR) {
                        validTile = 2;
                        xmod = 0;
                        ymod = 1;
                    } else if (getCell(newx + 1, newy) == DIRTFLOOR || getCell(newx + 1, newy) == CORRIDOR) {
                        validTile = 3;
                        xmod = -1;
                        ymod = 0;
                    }
                    if (validTile > -1) {
                        if (getCell(newx, newy + 1) == DOOR)
                            validTile = -1;
                        else if (getCell(newx - 1, newy) == DOOR)
                            validTile = -1;
                        else if (getCell(newx, newy - 1) == DOOR)
                            validTile = -1;
                        else if (getCell(newx + 1, newy) == DOOR)
                            validTile = -1;
                    }
                    if (validTile > -1)
                        break;
                }
            }
            if (validTile > -1) {
                int feature = rand.nextInt(101);
                if (feature <= chanceRoom) {
                    if (makeRoom((newx + xmod), (newy + ymod), 8, 6, validTile)) {
                        ++currentFeatures;
                        setCell(newx, newy, DOOR);
                        setCell((newx + xmod), (newy + ymod), DIRTFLOOR);
                    }
                } else if (feature >= chanceRoom) {
                    if (makeCorridor((newx + xmod), (newy + ymod), 6, validTile)) {
                        ++currentFeatures;
                        setCell(newx, newy, DOOR);
                    }
                }
            }
        }
        int newx = 0;
        int newy = 0;
        int ways = 0;
        int state = 0;
        while (state != 10) {
            for (int testing = 0; testing < 1000; ++testing) {
                newx = rand.nextInt(xsize - 1) + 1;
                newy = rand.nextInt(ysize - 2) + 1;
                ways = 4;
                if (getCell(newx, newy + 1) == DIRTFLOOR || getCell(newx, newy + 1) == CORRIDOR) {
                    if (getCell(newx, newy + 1) != DOOR)
                        --ways;
                }
                if (getCell(newx - 1, newy) == DIRTFLOOR || getCell(newx - 1, newy) == CORRIDOR) {
                    if (getCell(newx - 1, newy) != DOOR)
                        --ways;
                }
                if (getCell(newx, newy - 1) == DIRTFLOOR || getCell(newx, newy - 1) == CORRIDOR) {
                    if (getCell(newx, newy - 1) != DOOR)
                        --ways;
                }
                if (getCell(newx + 1, newy) == DIRTFLOOR || getCell(newx + 1, newy) == CORRIDOR) {
                    if (getCell(newx + 1, newy) != DOOR)
                        --ways;
                }
                if (state == 0) {
                    if (ways == 0) {
                        setCell(newx, newy, UPSTAIRS);
                        state = 1;
                        break;
                    }
                }
                else if (state == 1) {
                    if (ways == 0) {
                        setCell(newx, newy, DOWNSTAIRS);
                        state = 10;
                        break;
                    }
                }
            }
        }
        return true;
    }

}
