mountains={}
function mountains.load()
    mountain={}
    imgMountain= love.graphics.newImage("Assets/Images/montain1.png")
end
function mountains.update(dt)
	while #mountain>4 do
		table.remove(mountain,#mountain)
	end
    if math.random(0,200)==0 then
        mountains.drop()
    end
    for i=#mountain,1,-1 do
        local mon=mountain[i]
        mon.y=mon.y+90*dt
        if mon.y>height then
            table.remove(mountain,i)
         --   mon.y= -imgMountain:getHeight()
            --win()
            cont= cont+1
            wintone:play()
        end
    end
end
function mountains.draw()
    
    for i=#mountain,1,-1 do
        
        local mon=mountain[i]
        love.graphics.draw(imgMountain, mon.x, mon.y)
        
    end
end
function mountains.reset()
    for i=#mountain,1,-1 do
        table.remove(mountain,i)
    end
    mountains.drop()
end
function mountains.drop()
    local mon={}
    mon.x= math.random(0,width-imgMountain:getWidth())
    mon.y=-imgMountain:getHeight()
    mon.w=imgMountain:getWidth()
    mon.h=imgMountain:getHeight()
    table.insert(mountain,mon)
end