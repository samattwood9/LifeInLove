return function()

    local landing_screen = {}
    local horizontal_center 

    landing_screen.load = function()

        title_font = love.graphics.newFont("indieflower.ttf", 100)
        landing_screen.title = love.graphics.newText(title_font, "Life in Love!")

        heading_font = love.graphics.newFont("indieflower.ttf", 66)
        landing_screen.controls = love.graphics.newText(heading_font, "Controls")

        text_font = love.graphics.newFont("indieflower.ttf", 33)
        landing_screen.space = love.graphics.newText(text_font, "Space = start/restart")
        landing_screen.k = love.graphics.newText(text_font, "k = pause/resume")

    end

    landing_screen.update = function(width)

        horizontal_center = math.floor(width / 2)

    end

    landing_screen.draw = function(self)

        love.graphics.draw(self.title, horizontal_center - (self.title:getWidth()/2), 130)
        love.graphics.draw(self.controls, horizontal_center - (self.controls:getWidth()/2), 260)
        love.graphics.draw(self.space, horizontal_center - (self.space:getWidth()/2), 360)
        love.graphics.draw(self.k, horizontal_center - (self.k:getWidth()/2), 380)

    end

    return landing_screen

end