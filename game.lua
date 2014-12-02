game = {}
game.level = 1
game.score = 0
game.cards = {}

--amount of unique cards, type, key
game.levels = {
	{8,"unison",0,"Find the unisons!"},
	{12,"unison",0},

}
ents.sounds = {}

function game:begin()
	local amount = game.levels[game.level][1]
	local startx = 32
	local starty = 80
	local scale

	

	if amount == 8 then
		for i = 0,7,1 do
			local sound = love.audio.newSource("sounds/"..i..".wav", "static")
			if i == 7 then
				sound:setPitch(2)
			end
			table.insert(ents.sounds,sound)
		end
		scale = 0.4

		for i = 1,amount*2,1 do
			if i%4 == 1 and i > 1 then
				starty = starty + 130
				startx = 32
			end
			
			card = ents.create("card",startx,starty)
			startx = startx+128
			card:setScale(scale)
			card:add_sound(8)
		end


	end

end

