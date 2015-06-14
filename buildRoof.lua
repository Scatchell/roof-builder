os.loadAPI("digSquareModule")
os.loadAPI("findMoreBlocksModule")
os.loadAPI("blockUtils")

local args = { ... }
if #args ~= 2 then
    print( "Usage: buildRoof <widest roof width> <up starting position>" )
    error()
end

print("Building roof of height: ", args[1])

function selectNextSlot()
    nextSlot = 1
    turtle.select(1)
    while turtle.getItemCount(nextSlot) == 0 and nextSlot < 16 do
        nextSlot = nextSlot + 1
        turtle.select(nextSlot)
    end

    return not (nextSlot == 16 and turtle.getItemCount(nextSlot) == 0)
end

function buildForward()
    if (turtle.getItemCount() == 0) then
        if not selectNextSlot() then
            print("No more building items available! Trying to go get blocks")
            turtle.select(1)

            findMoreBlocksModule.moveAway(widestLayer + 3)
            findMoreBlocksModule.findBlockBelow()
            digSquareModule.digSquare(8, 16)

            print('Got blocks, now returning...')
            findMoreBlocksModule.returnToOriginalPosition()
        end
    end

    turtle.dig()
    turtle.forward()
    turtle.placeDown()
end

function buildOuterLayer(squareWidth)
    for i=1,squareWidth do
        buildForward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        buildForward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        buildForward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        buildForward()
    end
    turtle.back()
    turtle.turnRight()
end

function buildRoof(roofWidth)
    widestLayer = roofWidth
    local currentLayer = roofWidth

    while tonumber(currentLayer) > 0 do
        turtle.up()
        turtle.forward()
        blockUtils.removeNonBuildableItems()
        buildOuterLayer(currentLayer)
        currentLayer = currentLayer - 2
    end
end

--Make turtle check what type of block it's digging before starting to dig for new blocks?
--If turtle gets stopped when looking for blocks, DON'T increment movement hash

for i=1,args[2] do
    turtle.digUp()
    turtle.up()
end

buildRoof(args[1])
