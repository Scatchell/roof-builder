os.loadAPI("digSquareModule")
os.loadAPI("findMoreBlocksModule")
os.loadAPI("blockUtils")

local args = { ... }
if #args ~= 2 then
    print( "Usage: buildRoof <widest roof width> <up starting position>" )
    error()
end

print("building roof of height: ", args[1])

function slotItemIsBuildable(slot)
    if turtle.getItemDetail(slot) == nil then
        return false
    else
        local slotItemName = turtle.getItemDetail(slot)['name']
        return (blockUtils.isValidBlockType(slotItemName))
    end
end

function removeNonBuildableItems()
    for slot=1,16 do
        print('select slot ', slot)
        turtle.select(slot)
        if not slotItemIsBuildable(slot) then
            print('Slot ', slot, ' is not buildable, dropping')
            turtle.drop()
        end
    end

    turtle.select(1)
end

function selectNextSlot()
    nextSlot = 1
    turtle.select(1)
    while turtle.getItemCount(nextSlot) == 0 and nextSlot < 16 do
        nextSlot = nextSlot + 1
        turtle.select(nextSlot)
    end

    print('itemCount: ', turtle.getItemCount(nextSlot))
    print('currentSlot: ', nextSlot)

    return not (nextSlot == 16 and turtle.getItemCount(nextSlot) == 0)
end

function forward()
    if (turtle.getItemCount() == 0) then
        if selectNextSlot() then
            print("New slot of building materials selected")
        else
            print("No more building items available! Trying to go get blocks")
            turtle.select(1)

            findMoreBlocksModule.moveAway(widestLayer + 3)
            findMoreBlocksModule.findBlockBelow()
            digSquareModule.digSquare(6, 10)

            print('Got blocks, now returning...')
            findMoreBlocksModule.returnToOriginalPosition()

            removeNonBuildableItems()
        end
    end

    turtle.dig()
    turtle.forward()
    turtle.placeDown()
end

function buildOuterLayer(squareWidth)
    for i=1,squareWidth do
        forward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        forward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        forward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        forward()
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
        buildOuterLayer(currentLayer)
        currentLayer = currentLayer - 2
    end
end

--Make turtle check what type of block it's digging before starting to dig for new blocks?
--If turtle gets stopped when looking for blocks, DON'T increment movement hash

turtle.digUp()
for i=1,args[2] do
    turtle.up()
end

buildRoof(args[1])
