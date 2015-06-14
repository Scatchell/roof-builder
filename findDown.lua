os.loadAPI("findMoreBlocksModule")

for i=1,5 do
    turtle.up()
end

findMoreBlocksModule.moveAway(0)
findMoreBlocksModule.findBlockBelow()
findMoreBlocksModule.returnToOriginalPosition()
