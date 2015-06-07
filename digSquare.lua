
function forward()
    turtle.dig()
    turtle.forward()
end

function digAround(squareWidth)
    forward()
    turtle.turnRight()
    for i=1,squareWidth do
        forward()
    end
    turtle.turnRight()
    for i=1,squareWidth do
        forward()
    end
end

function digExpandingSquares(times)
    for i=1,times do
        digAround(i)
    end
end

local args = { ... }
if #args ~= 2 then
    print( "Usage: digSquare <square width>, <square depth>" )
    error()
end

local width = args[1]
local depth = args[2]

print("digging square of width: ", width, " and depth: ", depth)

for i=1,depth do
    turtle.digDown()
    turtle.down()
    digExpandingSquares(width)
end

for i=1,depth do
    turtle.digUp()
    turtle.up()
end

