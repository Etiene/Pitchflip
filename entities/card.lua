local ent = ents.derive("base")
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

function ent:load(x,y)
	self:setPos(x,y)
	self.image = love.graphics.newImage("images/note.png")
	self.width = 256
	self.height = 256
	self.flipped = false
	self.pitch = 0
end

function ent:setScale(s)
	self.scale = s
end

function ent:getScale()
	return self.scale
end


function ent:draw(dt)
	--local x,y = self:getPos()
	
	--love.graphics.rectangle("line",x,y,64,128)
	if self.flipped then
		love.graphics.setColor(205,201,201,255)
		love.graphics.draw(self.image,self.x,self.y,0,self.scale,self.scale,0,0)

		
	else
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(self.image,self.x,self.y,0,self.scale,self.scale,0,0)
	
	end

end

function ent:flip()
	self.flipped = true
	ents.sounds[self.sound]:play()
end

function ent:unflip()
	self.flipped = false

end

function ent:compare(card)
	return self.sound == card.sound
end

function ent.has_two_in_game(sound)
	local count = 0
	for i, card in pairs(ents.objects) do
		if card.sound == sound then
			count = count + 1
		end
	end
	return count == 2
end

function ent:add_sound(max)
	math.randomseed(love.timer.getTime())
	local sound = math.random(1,max)
	if not ent.has_two_in_game(sound) then
		self.sound = sound
	else
		self:add_sound(max)
	end
end

return ent