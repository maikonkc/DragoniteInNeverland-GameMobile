function checarMon(player,mountain)
    for i=#mountain,1,-1 do
        local mon=mountain[i]
		if mon~=nil then
			colisao= AABB(player.x+(player.w/3),player.y,player.w/3,player.h-10,mon.x,mon.y,mon.w,mon.h)
			if colisao then
			    love.system.vibrate(0.5)
			    reset()
			end
		end
    end
end
function checarBall(player,balls)
    for i=1,#balls do
        local ball= balls[i]
        colisao= AABB(player.x,player.y,player.w,player.h,ball.x,ball.y,ball.w,ball.h)
        if colisao then
            win()
            table.remove(balls,i)
            lancarBall=true
        end
    end
end
function checarClique(id,x,y,w,h)
    x1,y1=love.touch.getPosition(id)
    return x1>=x and
           x1<=x+w and
           y1>=y and
           y1<=y+h
end
function AABB(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1<x2+w2 and
           x1+w1>x2 and
           y1<y2+h2 and
           y1+h1>y2
end