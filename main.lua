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

-- https://github.com/Ulydev/push
push = require 'push'
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

require 'Paddle'
require 'Ball'

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

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState  = 'start'
end

-- Called every frame by LOVE deltaTime(dt) is passed in 
-- Multiplying by dt creates consistent functionality across all hardware
function love.update(dt)
    -- PLAYER 1 CONTROLS
    if love.keyboard.isDown('w') then
        -- If w pressed add negative Y
        -- Until Y reaches the negative bounds (top) of the screen
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- If s pressed add positive Y
        -- Until Y reaches the positive bounds (bottom) of the screen
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- PLAYER 2 CONTROLS
    if love.keyboard.isDown('up') then
        -- If up pressed add negative Y
        -- Until Y reaches the negative bounds (top) of the screen
       player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- If down pressed add positive Y
        -- Until Y reaches the positive bounds (bottom) of the screen
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play'  then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

-- LOVE2D keyboard handling
function love.keypressed(key)
    if key == 'escape' then
        -- Close application
        love.event.quit()
        -- During start state pressing enter will move to play state
        -- Moving the ball in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            
            ball:reset()
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

    -- Print Score fonts to first and third quarter of the screen
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- RENDER PADDLE AND BALL
    --Render paddles
    player1:render()
    player2:render()
    -- Render ball
    ball:render()

    -- End rendering at virtual resolution
    push:finish()
end