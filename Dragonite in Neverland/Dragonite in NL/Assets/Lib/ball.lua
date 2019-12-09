poke={}
function poke.load()
    balls={}
    speed=300
    imgPokeball= love.graphics.newImage("Assets/Images/pokebola.png")
end
function poke.update(dt)
    if lancarBall then
        poke.drop() 
    end
    for i=#balls,1,-1 do 
        local ball=balls[i]
        ball.y=ball.y+speed*dt
        if ball.y>390 then 
            table.remove(balls,i)
            lancarBall=true
        end
    end
    
end
function poke.draw()
    for i=1,#balls do
        local ball=balls[i]
        love.graphics.draw(imgPokeball,ball.x,ball.y)
    end
end
function poke.drop()
    local ball={}
    ball.x= math.random(0,width-imgPokeball:getWidth())
    ball.y=-imgPokeball:getHeight()
    ball.w=imgPokeball:getWidth()
    ball.h=imgPokeball:getHeight()
    lancarBall=false
    table.insert(balls,ball)
end
function poke.reset()
    for i=1,#balls do
        table.remove(balls,i)
    end
    lancarBall=true
end