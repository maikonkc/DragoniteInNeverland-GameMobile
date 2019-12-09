sea={}
function sea.load()
    imgBg= love.graphics.newImage("Assets/Images/movimento.jpg")
    bgFrames={}
    bgCurrentFrame=1
    bgFrames[1]=love.graphics.newQuad(0,0,30,30,imgBg:getDimensions())
    bgFrames[2]=love.graphics.newQuad(30,0,30,30,imgBg:getDimensions())
    bgFrames[3]=love.graphics.newQuad(0,30,30,30,imgBg:getDimensions())
    bgFrames[4]=love.graphics.newQuad(30,30,30,30,imgBg:getDimensions())
    bgActiveFrame= bgFrames[bgCurrentFrame]
    bgElapsedTime=0
end
function sea.update(dt)
    bgElapsedTime= bgElapsedTime+50*dt
    if (bgElapsedTime>1) then
        if (bgCurrentFrame<4) then
            bgCurrentFrame=bgCurrentFrame+1
        else
            bgCurrentFrame=1
        end
    end
    bgActiveFrame= bgFrames[bgCurrentFrame]
    bgElapsedTime=0
end
function sea.draw()
    for x=0,width,imgBg:getWidth()/2 do
       for y=0,height,imgBg:getHeight()/2 do

           love.graphics.draw(imgBg,bgActiveFrame,x,y)
        end
    end
end