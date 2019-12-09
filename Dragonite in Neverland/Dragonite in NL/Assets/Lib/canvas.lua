tela={}
function tela.load()
--
    start=flagStart
    lose=flagLoser
--
    tela1= love.graphics.newImage("Assets/Images/capa11.png")
    tela2= love.graphics.newImage("Assets/Images/capa12.png")
    gameover= love.graphics.newImage("Assets/Images/telaGO.png")
    restart= love.graphics.newImage("Assets/Images/restart.png")
    exit= love.graphics.newImage("Assets/Images/exit.png")
    font=love.graphics.newFont("Assets/Fonts/Pixel Coleco.otf",20)
--
    rs={}
    rs.x=58
    rs.y=height-57
    rs.width=restart:getWidth()
    rs.height=restart:getHeight()
    
    ex={}
    ex.x=rs.x+100
    ex.y=height-57
    ex.width=exit:getWidth()
    ex.height=exit:getHeight()
--
    rotate=0
   
    
end
function tela.update(dt)
 
   
    if  rotate == 1 then
        rotate=0
    else
        rotate= rotate+3*dt
    end
end
function tela.startDraw()
    love.graphics.draw(tela2)
    verClique()
end
function tela.loseDraw()
    love.graphics.draw(gameover)
    love.graphics.draw(restart,rs.x, rs.y,rotate,1,1,rs.width/2,rs.height/2)
    love.graphics.draw(exit, ex.x,ex.y,rotate,1,1,ex.width/2,ex.height/2)
    love.graphics.print(pontos,90,336-220)
    cont=0
end