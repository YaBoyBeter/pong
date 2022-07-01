--[[
    Pong Recreation for Harvard GD50

    Author: Pierce Jennings
    Twitter: @YaBoyBeter
]]--

Paddle = Class() {
    init = function (x, y, width, height)
        self.x = x
        self.y = y
        self.width = width
        self.height = height

        self.dy = 0
    end
}
function Paddle:update()
    if self.dy < 0 then
        -- Keeps paddle y at the greater of 0 or the players curreent calculated y
        self.y = math.max(0, self.y + self.dy * dt)
    else
        -- Keeps paddle y at the lesser of the bottom of the screen and calculated paddle position
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.x, self.width, self.height)
end
