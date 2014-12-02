ents = {}
ents.objects = {}
ents.objpath = "entities/"
ents.cards_flipped = {}
ents.score = 0
local register = {}
local id = 0

function ents.startup()
	register["card"] = love.filesystem.load(ents.objpath.."card.lua")
end

function ents.create( name, x, y)
	x = x or 0
	y = y or 0

	if register[name] then
		id = id + 1
		local ent = register[name]()
		ent:load()
		ent:setPos(x,y)
		ent.id = id
		ents.objects[#ents.objects + 1] =  ent
		return ent
	else
		print("Error: This entity is not registered")
		return false
	end
end

function ents.derive(name)
	return love.filesystem.load(ents.objpath..name..".lua")()
end

function ents:update(dt)
	for i, ent in pairs(ents.objects) do
		if ent.update then
			ent:update(dt)
		end
	end
end



function ents:draw(dt)

	for i, ent in pairs(ents.objects) do
		if ent.draw then
			ent:draw(dt)
		end
	end
end

function ents.destroy(id)
	if ents.objects[id] then
		if ents.objects[id].die then
			ents.objects[id]:die()
		end
		ents.objects[id]=nil
	end
end


function ents.flip(x,y)
	for i, ent in pairs(ents.objects) do
		local already_flipped = false
			for i, flipped in pairs(ents.cards_flipped) do
				if ent == flipped then
					already_flipped = true
				end
			end
			local hit = insideBox(x,y,ent.x,ent.y,ent.width * ent.scale,ent.height * ent.scale)
			if already_flipped and hit then
				break
			end
			if hit then
				ent:flip()
				table.insert(ents.cards_flipped,ent)
			end
		
	end
end

function ents.unflip()
	for i, ent in pairs(ents.cards_flipped) do
		ent:unflip()
		ents.cards_flipped = {}
	end
end


function ents.verify()
	if ents.cards_flipped[1].sound ~=  ents.cards_flipped[2].sound then
		ents.unflip()
	else
		ents.destroy(ents.cards_flipped[1].id)
		ents.destroy(ents.cards_flipped[2].id)
		ents.score = math.floor(ents.score + (1/(love.timer.getTime()-start))*51200)
		ents.cards_flipped = {}
	end
end


