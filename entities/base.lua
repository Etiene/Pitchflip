local base = {}
base.x = 0
base.y = 0
base.pitch = 1

function base:setPos (x,y)
	base.x = x
	base.y = y
end

function base:getPos()
	return base.x,base.y
end

function base:load()
end

return base