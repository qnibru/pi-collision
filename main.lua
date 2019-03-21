-- lineH perfect
love.graphics.setDefaultFilter("nearest")
-------------------------------------------------------------------------------
cube10 = {}
    cube10.x = 0
    cube10.y = 0
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

collide = false
collideCube = false


function demarre ()
    -- Position du cube10
    cube10.x = (widthScreen/10) * 2
    cube10.y = (heightScreen/10) * 7
    cube10.v = 0
    cube10.m = 1

    -- Position du cube100
    cube100.x = (widthScreen/10) * 5
    cube100.y = (heightScreen/10) * 7 - cube10.width
    cube100.v = -1
    cube100.m = 10000

end


function love.load()

    -- Dimensions écran
    widthScreen = love.graphics.getWidth()
    heightScreen = love.graphics.getHeight()

    -- Dimensions des cubes
    cube10.width = cube10.img:getWidth()
    cube100.width = cube100.img:getWidth()

    -- Position de la ligne horizontale
    lineH.y = (heightScreen/10) * 7 + cube10.width

    -- Position de la ligne verticale
    lineV.y = lineV.y - (heightScreen - lineH.y)
    lineV.width = lineV.img:getWidth()

    demarre()
    
end



  

function love.update ()

    -- Determine la vitesse des cubes
    --if love.keyboard.isDown("space") then
        cube10.x = cube10.x + cube10.v
        cube100.x = cube100.x + cube100.v
    --end

    if love.keyboard.isDown("f") then
        demarre()
    end

    if cube100.x <= cube10.x + cube10.width then

        -- Collision de cube100 avec cube10
        local v1 = nil
        local v2 = nil
        local u1 = cube10.v
        local u2 = cube100.v
        local m1 = cube10.m
        local m2 = cube100.m
        local sumM = m1 + m2

        -- Energie cinétique de cube10 après transfert/reception
        v1 = (m1-m2) / sumM * u1
        v1 = v1 + 2*m2 / sumM * u2
        cube10.v = v1

        -- Energie cinétique de cube100 après transfert/reception
        v2 = 2*m1 / sumM * u1
        v2 = v2 + (m2-m1) / sumM * u2
        cube100.v = v2

        love.audio.play(clack)
        love.audio.play(clack)
        love.audio.play(clack)
        love.audio.play(clack)

        
        collideCube = true

    end

        
    -- Collisions entre cube et murs
    if cube100.x <= cube10.x + cube10.width then
        cube100.x = cube10.x + cube10.width

    elseif cube10.x < lineV.x then
        cube10.x = lineV.x + lineV.width
        cube10.v =  -cube10.v

        love.audio.play(clack)
        collide = true
    else 
        collide = false
        collideCube = false
    end


end


function love.draw()
    
    love.graphics.setBackgroundColor(1, 1, 1, 1)

    love.graphics.draw(lineH.img, lineH.x, lineH.y)
    love.graphics.draw(lineV.img, lineV.x, lineV.y)

    love.graphics.draw(cube10.img, cube10.x, cube10.y)
    love.graphics.draw(cube100.img, cube100.x, cube100.y)

    -- Debug
    black = {0, 0, 0, 1}

    love.graphics.print({black, "Vitesse cube100 : ",cube100.v}, 100, 5)
    love.graphics.print({black, "Vitesse cube10 : ",cube10.v}, 100, 20)

    if collide == true then
        love.graphics.print({black, "collision avec le mur"}, 300, 5)
    elseif collideCube == true then
        love.graphics.print({black, "collision entre cube"}, 300, 20)
    end
end