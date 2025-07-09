local M = {}

--First 3 functions
function M.load()
    -- Load resources or initialize variables here

    print("Game loaded")
    x = 100
    y = 100
end

function M.draw()
    love.graphics.rectangle("fill", x, y, 50, 100)
end
--First 3 functions end

function M.movement(dt)
    if love.keyboard.isDown("left") then
        x = x - 200 * dt
    end
    if love.keyboard.isDown("right") then
        x = x + 200 * dt
    end
    if love.keyboard.isDown("up") then
        y = y - 200 * dt
    end
    if love.keyboard.isDown("down") then
        y = y + 200 * dt
    end
    if x > love.graphics.getWidth() then
        x = 0
    end
end

return M