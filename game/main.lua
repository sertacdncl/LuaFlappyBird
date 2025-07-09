--First 3 functions
function love.load()
	skyBlue = {0.529, 0.808, 0.922} -- RGB values for sky blue
	cream = {1.0, 0.98, 0.82} -- RGB values for cream color
	green = {0.0, 0.5, 0.0} -- RGB values for green

	love.graphics.setBackgroundColor(skyBlue)

	-- score
	score = 0
	upcomingPipe = 1

	-- background image
	backgroundImage = love.graphics.newImage("Assets/gamebackground.jpg")

	--bird sprite
	birdImage = love.graphics.newImage("Assets/birddrawing.png")

	-- pipe sprites
	pipeDown = love.graphics.newImage("assets/Pipe-down.png")
	pipeUp = love.graphics.newImage("assets/Pipe-up.png")

	-- game screen dimensions
	WINDOW_WIDTH = love.graphics.getWidth()
	WINDOW_HEIGHT = love.graphics.getHeight()

	-- requiring files
	Class = require("src/class")
	bird = require("src/Bird")
	ground = require("src/Ground")
	downwardpipe = require("src/downwardPipes")
	upwardpipe = require("src/upwardPipes")

	Class = require("src.class")
	bird = require("src.Bird")
	ground = require("src.Ground")
	downwardpipe = require("src.downwardPipes")
	upwardpipe = require("src.upwardPipes")

	-- instances
	player = Bird()
	dirt = Ground(0, 390, 315, 60, cream)
	grass = Ground(0, 375, 315, 15, green)

	function FirstPipes()
		-- pipe variables
		local pipeSpaceYMin = -120
		local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
		pipe1 = downwardPipes(WINDOW_WIDTH, pipeSpaceY)
		pipe2 = upwardPipes(WINDOW_WIDTH, pipeSpaceY + 315)
	end
	FirstPipes()

	function SecondPipes()
		-- pipe variables
		local pipeSpaceYMin = -120
		local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
		pipe3 = downwardPipes(490, pipeSpaceY)
		pipe4 = upwardPipes(490, pipeSpaceY + 315)
	end
	SecondPipes()

	print("Bird type:", type(Bird)) -- should be 'table'
	print("player type:", type(player)) -- should be 'table'
end

function love.update(dt)
	if pipe1.x + pipe1.width and pipe2.x + pipe2.width < 0 then
		pipe1.x = WINDOW_WIDTH
		pipe2.x = WINDOW_WIDTH
		FirstPipes()
	end

	if pipe3.x + pipe3.width and pipe4.x + pipe4.width < 0 then
		SecondPipes()
		pipe3.x = WINDOW_WIDTH
		pipe4.x = WINDOW_WIDTH
	end

	player:update(dt)
	pipe1:update(dt)
	pipe2:update(dt)
	pipe3:update(dt)
	pipe4:update(dt)

	if player:collision(pipe1) then
		love.load()
	elseif player:collision(pipe2) then
		love.load()
	elseif player:collision(pipe3) then
		love.load()
	elseif player:collision(pipe4) then
		love.load()
	elseif player:collision(grass) then
		love.load()
	end

	if upcomingPipe == 1 and player.x > (pipe1.x + pipe1.width) then
		score = score + 1
		upcomingPipe = 2
	end
	if upcomingPipe == 2 and player.x > (pipe3.x + pipe3.width) then
		score = score + 1
		upcomingPipe = 1
	end
end

function love.keypressed(key)
	player:jump()
end

function love.draw()
	love.graphics.draw(backgroundImage, 0, 0)
	pipe1:render()
	pipe2:render()
	pipe3:render()
	pipe4:render()
	player:render()
	grass:render()
	dirt:render()

	love.graphics.setColor(0, 0, 0)
	love.graphics.print(score, 140, 50)
	love.graphics.setColor(1, 1, 1)
end
