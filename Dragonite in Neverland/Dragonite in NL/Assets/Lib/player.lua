width=love.graphics.getWidth()
height=love.graphics.getHeight()
play={}
function play.load()
    osString = love.system.getOS()
    playerimagem= love.graphics.newImage("Assets/Images/dragonite.png")
    player={
        x=(width/2)-(playerimagem:getWidth()/2),
        y= height-playerimagem:getHeight(),
        w=playerimagem:getWidth()/2,
        h=playerimagem:getHeight(),
        speed=400
        }
    frames={}
    currentFrame=1
    frames[1]=love.graphics.newQuad(0,0,93,116,playerimagem:getDimensions())
    frames[2]=love.graphics.newQuad(95,0,95,116,playerimagem:getDimensions())
    activeFrame=frames[currentFrame]
    elapsedTime=0
end
function play.update(dt)
    elapsedTime= elapsedTime+50*dt
    if (elapsedTime>1) then
        if (currentFrame<2) then
            currentFrame=currentFrame+1
        else
            currentFrame=1
        end
    end
    activeFrame=frames[currentFrame]
    elapsedTime=0
    play.move(dt)
end
function play.draw()
    love.graphics.draw(playerimagem,activeFrame,player.x,player.y)
end
function play.move(dt)
	if osString=="Windows" then
		x,y = love.mouse.getPosition()
		player.x=x
	elseif osString=="Android" or osString=="iOS" then
		touches=love.touch.getTouches()
		for i,id in ipairs(touches) do
			local x,y = love.touch.getPosition(id)
			if x>player.x then
				player.x= player.x+player.speed*dt
			end
			if x<player.x then
				player.x= player.x-player.speed*dt
			end
		end
	end
end
function play.getPlayer()
    return player.x,
           player.y,
           player.w,
           player.h-10
end
function play.reset()
    player.x=(width/2)-(playerimagem:getWidth()/2)
end