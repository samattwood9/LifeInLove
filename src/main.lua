function love.load()

    love.graphics.setBackgroundColor(0.253, 0.767, 0.982)

    active_colour = 1
    state = 1
    time = 0
    previous_time = 0

    title = require('title')
    title = title()
    title.load()

    grid = require('grid')
    grid = grid(40,40)
    grid.load(0)

end


function love.update(dt)

    local width, height = love.window.getMode()

    time = time + dt

    if state == 1 then
        title.update(width)
    elseif state == 2 then
        grid.update(width, height)
        if time > previous_time + 0.5 then
            grid.step(0)
            previous_time = time
        end
    end

end

function love.draw()

    if state == 1 then
        title:draw()
    else
        grid.draw(active_colour)
    end

end

function love.keypressed(pressed_key)

    if pressed_key == "space" then -- restart
        state = 2
        grid.load(20)
        time = 0
        previous_time = 0
    elseif pressed_key == "k" then
        if state == 2 then -- is running, so pause
            state = 0
        elseif state == 0 then -- is paused, so start up again
            state = 2
        end
    end
    
end
