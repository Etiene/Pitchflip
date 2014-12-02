
function love.load()
	require "entities"
	require "game"
	mousex = 0
	mousey = 0
	start = love.timer.getTime()
	

	ents.startup()
	love.graphics.setBackgroundColor( 255, 255, 255 )
	card = love.graphics.newImage("2.png")
	game:begin()

end

function love.draw()
	love.graphics.setColor(0,0,0,255)
	love.graphics.print("Welcome to Pitchflip! Level "..game.level..": "..game.levels[game.level][4],32,32,0,1)
	love.graphics.print("SCORE: "..ents.score,600,256,0,1)
	ents:draw()

end

function love.update(dt)
	ents:update(dt)
	if #ents.cards_flipped == 2 then
		ents:verify()
	end
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
	 if button == "l" then
	 	mousex = x
	 	mousey = y
	 	ents.flip(x,y)
	 end
end

function love.mousereleased( x, y, button )
end

function love.quit()
end

function insideBox(px,py,x,y,wx,hy)
	if px > x and px < x + wx then
		if py >y and py < y+ hy then
			return true
		end
	end
	return false
end