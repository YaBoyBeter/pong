--[[
    Pong Recreation for Harvard GD50

    Author: Pierce Jennings
    Twitter: @YaBoyBeter
]]--

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'
class = require 'class'

-- Called once at application start, used to initialize the game
function love.load()
    -- Removes bluring of text and graphics
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Generates a seed based on the os clock to make it seem more random
    math.randomseed(os.time())

    -- FONT OBJECTS
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Assigns "smallFont as the active font"
    love.graphics.setFont(smallFont)

    -- Screen Setup
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    -- Paddle positions on Y
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    -- Ball X and Y positions
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- Ball Velocity
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)


    gameState  = 'start'
end

-- Called every frame by LOVE deltaTime(dt) is passed in 
-- Multiplying by dt creates consistent functionality across all hardware
function love.update(dt)
    -- PLAYER 1 CONTROLS
    if love.keyboard.isDown('w') then
        -- If w pressed add negative Y
        -- Until Y reaches the negative bounds (top) of the screen
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- If s pressed add positive Y
        -- Until Y reaches the positive bounds (bottom) of the screen
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- PLAYER 2 CONTROLS
    if love.keyboard.isDown('up') then
        -- If up pressed add negative Y
        -- Until Y reaches the negative bounds (top) of the screen
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- If down pressed add positive Y
        -- Until Y reaches the positive bounds (bottom) of the screen
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play'  then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

-- LOVE2D keyboard handling
function love.keypressed(key)
    if key == 'escape' then
        -- Close application
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else 
            gameState = 'start'
            
            -- Start ball at center screen
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            -- Set ball velocity for game start
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

-- Called every frame after update
-- Used to draw all game objects to the screen
function love.draw()
    -- Begin rendering at virtual resolution
    push:start()

    -- Wipes screen to grey
    love.graphics.clear(0.40, 0.45, 0.52, 0.50)

    -- Prints welcome text to the top of the screen
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong', 0, 20, VIRTUAL_WIDTH, 'center')

    -- Print Score fonts to first and third quarter of the screen
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- RENDER PADDLE AND BALL
    -- Left paddle (player1)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    -- Right paddle (player 2)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    -- Ball
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    -- End rendering at virtual resolution
    push:finish()
end