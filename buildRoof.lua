local args = { ... }
if #args ~= 1 then
    print( "Usage: buildRoof <roof height>" )
    error()
end

print("building roof of height: ", args[1])

function selectNextSlot()
    nextSlot = 1
    print('itemCount: ', turtle.getItemCount(nextSlot))
    print('nextSlot: ', nextSlot)
    turtle.select(1)
    while turtle.getItemCount(nextSlot) == 0 do
        nextSlot = nextSlot + 1
        turtle.select(nextSlot)
    end
end

function forward()
    selectNextSlot()
    --logic here to pause turtle and wait for resources, or go and consume more resources
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
widestLayer = args[1]
currentLayer = args[1]

while tonumber(currentLayer) > 0 do
    turtle.up()
    turtle.forward()
    buildOuterLayer(currentLayer)
    currentLayer = currentLayer - 2
end
