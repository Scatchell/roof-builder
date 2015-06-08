os.loadAPI("digSquareModule")

local args = { ... }
if #args ~= 2 then
    print( "Usage: digSquare <square width>, <square depth>" )
    error()
end

local width = args[1]
local depth = args[2]

digSquareModule.digSquare(width, depth)
