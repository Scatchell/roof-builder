blocksMoved = {}
blocksMoved['u'] = 0
blocksMoved['d'] = 0
blocksMoved['f'] = 0
blocksMoved['r'] = 0
blocksMoved['l'] = 0
function down()
    if turtle.down() then
        blocksMoved['d'] = blocksMoved['d'] + 1
    end
end

function digDown()
    turtle.digDown()
    down()
end

function findBlockBelow()
    while not turtle.detectDown() do
        down()
    end
end


findBlockBelow()
digDown()

print('Blocks moved down: ', blocksMoved['d'])
