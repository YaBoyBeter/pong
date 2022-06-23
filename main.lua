WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'
class = require 'class'

-- Called once at application start, used to initialize the game
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizeable = false,
        vsync = true
    })
end

-- Called every frame by LOVE deltaTime(dt) is passed in 
-- Multiplying by dt creates consistent functionality across all hardware
function love.update(dt)

end

-- Called every frame after update
-- Used to draw all game objects to the screen
function love.draw()
    love.graphics.printf(
        'Hello Pong',             -- Text to render
        0,                        -- Starting X
        WINDOW_HEIGHT / 2 - 6,    -- Starting Y
        WINDOW_WIDTH,             -- Number of pixels to center within
        'center')                 -- Alignment mode
end