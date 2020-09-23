return function(x_size, y_size)

    local grid = {}
    local x_pos, y_pos
    local window_width, window_height
    local cell_size_x, cell_size_y

    grid.load = function()

        -- initial random set-up
        for x = 1, x_size do
            grid[x] = {}
            for y = 1, y_size do
                grid[x][y] = math.random(10) -- 1 is alive, so this by passing 10 we will initiall have approx 10% alive, passsing 100 -> approx1% alive
            end
        end

        return

    end

    grid.update = function(width, height)

        -- perform calcs & assignments to ensure grid is sized/drawn correctly
        window_width = width
        window_height = height
        x_pos = 5
        y_pos = 5
        cell_size_x = (window_width - x_pos) / x_size
        cell_size_y = (window_height - y_pos) / y_size

    end

    grid.draw = function(active_colour)

        -- set the size of every cell
        local cell_draw_size_x = cell_size_x - 5
        local cell_draw_size_y = cell_size_y - 5

        -- draw each cell based on its state
        for x = 1, x_size do
            for y = 1, y_size do

                -- set cell draw parameters 
                local is_filled

                if grid[x][y] == 1 then
                    love.graphics.setColor(0.9, 0.3, 0.6)
                    is_filled = true
                else
                    love.graphics.setColor(0.9, 0.9, 0.9)
                    is_filled = false
                end

                -- actually draw the cell
                if  (is_filled) then
                    love.graphics.rectangle(
                        'fill',
                        x_pos + ((x - 1) * cell_size_x),
                        y_pos + ((y - 1) * cell_size_y),
                        cell_draw_size_x,
                        cell_draw_size_y
                    )
                else
                    love.graphics.rectangle(
                        'line',
                        x_pos + ((x - 1) * cell_size_x),
                        y_pos + ((y - 1) * cell_size_y),
                        cell_draw_size_x,
                        cell_draw_size_y
                    )
                end

            end

        end

    end

    grid.step = function(active_colour)

        local next_grid = {}

        for x = 1, x_size do
            next_grid[x] = {}
            for y = 1, y_size do

                -- get info on neighbours
                local neighbours
                if x == 1 and y == 1 then
                    neighbours = {grid[x][y+1], grid[x+1][y], grid[x+1][y+1]}
                elseif x == x_size and y == y_size then
                    neighbours = {grid[x-1][y-1], grid[x-1][y], grid[x][y-1]}
                elseif x == 1 and y == y_size then
                    neighbours = {grid[x][y-1], grid[x+1][y-1], grid[x+1][y]}
                elseif x == x_size and y == 1 then
                    neighbours = {grid[x][y+1], grid[x-1][y], grid[x-1][y+1]}
                elseif x == 1 then
                    neighbours = {grid[x][y-1], grid[x][y+1], grid[x+1][y-1], grid[x+1][y], grid[x+1][y+1]}
                elseif x == x_size then
                    neighbours = {grid[x-1][y-1], grid[x-1][y], grid[x-1][y+1], grid[x][y-1], grid[x][y+1]}
                elseif y == 1 then
                    neighbours = {grid[x-1][y], grid[x-1][y+1], grid[x][y+1], grid[x+1][y], grid[x+1][y+1]}
                elseif y == y_size then
                    neighbours = {grid[x-1][y], grid[x-1][y-1], grid[x][y-1], grid[x+1][y], grid[x+1][y-1]}
                else
                    neighbours = {grid[x-1][y-1], grid[x-1][y], grid[x-1][y+1], grid[x][y-1], grid[x][y+1], grid[x+1][y-1], grid[x+1][y], grid[x+1][y+1]}
                end

                -- count neighbours
                local count = 0
                for neighbour = 1, #neighbours do
                    if neighbours[neighbour] == 1 then
                        count = count + 1
                    end
                end 

                -- anything under 2 dies (via underpopulation) and over 3 dies (via overpopulation)
                if (grid[x][y] == 1) and (count == 2 or count == 3) then
                    next_grid[x][y] = 1 -- on
                elseif (grid[x][y] ~= 1) and (count == 3) then
                    next_grid[x][y] = 1 -- on
                else 
                    next_grid[x][y] = 0 -- off
                end

            end
            
        end

        grid = next_grid

        return

    end

    return grid

end