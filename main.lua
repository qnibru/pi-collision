-- Pixel perfect
love.graphics.setDefaultFilter("nearest")
-------------------------------------------------------------------------------
cube10 = {}
    cube10.x = 0
    cube10.y = 0
    cube10.ox = 0
    cube10.v = 0
    cube10.m = 0
    cube10.img = love.graphics.newImage("assets/10.png")
   
cube100 = {}
    cube100.x = 0
    cube100.y = 0
    cube100.v = -3
    cube100.m = 0
    cube100.img = love.graphics.newImage("assets/100.png")

lineH = {}
    lineH.x = 50
    lineH.y = 0
    lineH.img = love.graphics.newImage("assets/lineH.png")

lineV = {}
    lineV.x = 50
    lineV.y = 0
    lineV.img = love.graphics.newImage("assets/lineV.png")

clack = love.audio.newSource("assets/clack.wav", "static")

start = false
power100 = 1
collide = false
pi = 0



function demarre ()
    -- Position du cube10
    cube10.x = (widthScreen/10) * 4
    cube10.y = (heightScreen/10) * 7
    cube10.v = 0
    cube10.m = 1

    -- Position du cube100
    cube100.x = (widthScreen/10) * 7
    cube100.y = (heightScreen/10) * 7 - cube10.width
    cube100.v = 0
    
    start = false
    pi = 0
    timeSteps = 10
end





function love.load()
    -- Dimensions écran
    widthScreen = love.graphics.getWidth()
    heightScreen = love.graphics.getHeight()

    -- Dimensions des cubes
    cube10.width = cube10.img:getWidth()
    cube10.ox = cube10.ox + cube10.width

    cube100.width = cube100.img:getWidth()
    


    -- Position de la ligne horizontale
    lineH.y = (heightScreen/10) * 7 + cube10.width

    -- Position de la ligne verticale
    lineV.y = lineV.y - (heightScreen - lineH.y)
    lineV.width = lineV.img:getWidth()

    demarre()

    cube100.v = -5
end



  

function love.update ()

    function love.keypressed(key)
        if key == "up" then
            power100 = power100 + 1

        elseif key == "down" then
            power100 = power100 - 1
            
        elseif key == "space" or " " then
            start = true
        end
    end

    cube100.m = 100^power100

    if love.keyboard.isDown("f") then
        demarre()
    end
        
    if start == true then
        cube10.x = cube10.x + cube10.v
        cube100.x = cube100.x + cube100.v
    end

    
    -- Collision de cube100 avec cube10
    if cube100.x <= cube10.x + 1 then
        local v1 = nil
        local v2 = nil
        local u1 = cube10.v
        local u2 = cube100.v
        local m1 = cube10.m
        local m2 = cube100.m

        -- Energie cinétique de cube10 après transfert/reception
        v1 = u1*((m1-m2) / (m1 + m2)) + u2*((2*m2) / (m1 + m2))
        cube10.v = v1

        -- Energie cinétique de cube100 après transfert/reception
        v2 = u1*((2*m1) / (m1 + m2)) + u2*((m2-m1) / (m1 + m2))
        cube100.v = v2
    end


    -- Collisions entre cubes
    if cube100.x <= cube10.x +1 then
        cube100.x = cube10.x +1

        love.audio.stop(clack)
        love.audio.play(clack)
      
        collide = true

    -- Collision cube10 avec mur
    elseif cube10.x - cube10.width <= lineV.x + lineV.width then
        cube10.x = lineV.x + lineV.width + cube10.width
        cube10.v =  -cube10.v

        love.audio.stop(clack)
        love.audio.play(clack)

        collide = true
    else 
        collide = false
    end

    if collide == true then
        pi = pi + 1
    end
end


function love.draw()
    
    love.graphics.setBackgroundColor(1, 1, 1, 1)

    love.graphics.draw(lineH.img, lineH.x, lineH.y)
    love.graphics.draw(lineV.img, lineV.x, lineV.y)

    love.graphics.draw(cube10.img, cube10.x, cube10.y, 0, 1, 1, cube10.ox)
    love.graphics.draw(cube100.img, cube100.x, cube100.y)

    -- Debug
    black = {0, 0, 0, 1}

    love.graphics.print({black, "Vitesse cube100 : ",cube100.v}, 100, 5)
    love.graphics.print({black, "Vitesse cube10 : ",cube10.v}, 100, 20)
    love.graphics.print({black, "Masse cube100 : ",cube100.m}, 100, 35)
    love.graphics.print({black, "Puissance de 100 : ",power100}, 100, 50)



    love.graphics.print({black, "pi : ",pi}, 200, 500)

end

 
