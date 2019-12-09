require "collision"
height=love.graphics.getHeight()
width=love.graphics.getWidth()

function love.load()
-- atributos
-- fiz a tabela player
    player={}
    player.imagem=love.graphics.newImage("dragonite.png")
    player.x=(width/2)-(player.imagem:getWidth()/2)
    player.y=height-player.imagem:getHeight()
    player.w=player.imagem:getWidth()/2
    player.h=player.imagem:getHeight()
    player.speed=300
    
    pFrames={}
    pCurrentFrame=1
    pFrames[1]=love.graphics.newQuad(0,0,93,116,player.imagem)
    pFrames[2]=love.graphics.newQuad(95,0,95,116,player.imagem)
    pActiveFrame=pFrames[pCurrentFrame] 
    pElapsedTime=0
    
    coiny=0
    coins={}
    mons ={}
    cont=0
    
    isStart=true
    loser=false
    lancar1=true
    lancar2=true
    
    imagen={}
    imagen.poke=love.graphics.newImage("pokebola.png")
    imagen.montanha=love.graphics.newImage("montain1.png")
    mony=-imagen.montanha:getHeight()
    imagen.background=love.graphics.newImage("movimento.png")
    bgFrames={}
    bgCurrentFrame=1
    bgFrames[1]=love.graphics.newQuad(0,0,30,30,imagen.background:getDimensions())
    bgFrames[2]=love.graphics.newQuad(30,0,30,30,imagen.background:getDimensions())
    bgFrames[3]=love.graphics.newQuad(0,30,30,30,imagen.background:getDimensions())
    bgFrames[4]=love.graphics.newQuad(30,30,30,30,imagen.background:getDimensions())
    bgActiveFrame=bgFrames[bgCurrentFrame]
    bgElapsedTime=0
end
function love.update(dt)
-- sprites do dragonite
    bgElapsedTime= bgElapsedTime+50*dt 
    if (bgElapsedTime>1) then 
        if (bgCurrentFrame<4) then 
            bgCurrentFrame=bgCurrentFrame+1 
        else 
            bgCurrentFrame=1 
        end
    end
    bgActiveFrame=bgFrames[bgCurrentFrame]
    bgElapsedTime=0 
-- sprites das ondas
    pElapsedTime= pElapsedTime+50*dt 
    if (pElapsedTime>1) then 
        if (pCurrentFrame<2) then 
            pCurrentFrame=pCurrentFrame+1 
        else 
            pCurrentFrame=1 
        end
    end
    pActiveFrame=pFrames[pCurrentFrame]
    pElapsedTime=0
-- seeding
    --math.randomseed(dt)
-- lendo a tela
    touches=love.touch.getTouches()
    for i,id in ipairs(touches) do
        if id~=nill and isStart then 
            isStart=false
        end
-- li as posições x e y 
-- verifiquei a veracidade do toque
        if not isStart and not loser then
            local x,y = love.touch.getPosition(id)
            if x>player.x then
                player.x=player.x+player.speed*dt
            end
            if x<player.x then 
                player.x=player.x-player.speed*dt
            end
        end 
    end
-- incrementando o y 
    if not isStart and not loser then
        coiny=coiny+400*dt
-- lancando as montanhas
        for i=#mons,1,-1 do 
            local mon=mons[i]
            mon.y=mon.y+100*dt
            
            if mon.y>390 then 
                table.remove(mons,i)
                lancar1=true
                mon.y=-imagen.montanha:getHeight()
                cont=cont+1
            
            end
        end
-- lançando as pokebolas
        for i=#coins,1,-1 do 
            local coin=coins[i]
            if coiny>390 then 
                table.remove(coins,i)
                lancar2=true
                coiny=0
            end
        end 
-- verificando as chamadas de lancamento
        if math.random(0,100)==0 then 
            local mon={}
            mon.x=math.random(0,width-imagen.montanha:getWidth())
            mon.y=-imagen.montanha:getHeight()
            mon.w=60
            mon.h =60
            lancar1=false
            table.insert(mons,mon)
        end 
        if lancar2 then   
            local coin={}
            coin.x =math.random(0,width-imagen.poke:getWidth())
            coin.y=0 
            coin.w=20 
            coin.h=20 
            lancar2=false
            table.insert(coins,coin)
        end
        for i=#mons,1,-1 do
            mon=mons[i]
            if     AABB(player.x,player.y,player.w,player.h-10,mon.x,mon.y,mon.w,mon.h) then 
                loser=true
                mon.y=-imagen.montanha:getHeight()
                mon.x=math.random(20,900)
            end
        end
        for i=#coins,1,-1 do
            coin=coins[i]
            if     AABB(player.x,player.y,player.w,player.h,coin.x,coiny,coin.w,coin.h) then 
                lancar2=true
                cont=cont+10
                coiny=0 
                coin.x=math.random(20,900)
                table.remove(coins,i)
            end
        end
    else 
        for i=1,#mons do
            table.remove(mons,i)
        end 
        for i=1,#coins do 
            table.remove(coins,i)
        end
        lancar2=true
    end
end
function love.draw()
-- desenhando na tela
   if loser then 
       love.graphics.setColor(255,255,255)
       love.graphics.print("GAME OVER...",200,200)
       pontos=cont
       love.graphics.print(pontos,200,210)
       touches=love.touch.getTouches()
       for i,id in ipairs(touches) do
           if id~=nill then 
               loser=false
               isStart=true
               cont=0
           end
       end   
   elseif isStart then 
       
       love.graphics.setColor(255,255,255)
       love.graphics.print("Press to start...",200,200)
   else
       for x=0, love.graphics.getWidth(), imagen.background:getWidth()/2 do 
           for y=0,love.graphics.getHeight(),imagen.background:getHeight()/2 do 
           
               love.graphics.draw(imagen.background,bgActiveFrame,x,y)
       --love.graphics.setBackgroundColor(0,100,255)
       --love.graphics.setColor(200,300,10)
          end 
      end 
      love.graphics.draw(player.imagem,pActiveFrame,player.x,player.y)
       for i=1,#mons do 
           local mon=mons[i]
           
           --love.graphics.setColor(255,10,10)
               love.graphics.draw(imagen.montanha,mon.x,mon.y)
       end
       for i=1,#coins do 
           local coin=coins[i]
           love.graphics.setColor(255,10,10)
               love.graphics.draw(imagen.poke,coin.x,coiny)
       end
   --    love.graphics.setColor(0,0,0)
       love.graphics.print("PONTOS: "..cont,10,10) 
   end
end