require("conf")
require("Assets/Lib/player")
require("Assets/Lib/mountains")
require("Assets/Lib/ball")
require("Assets/Lib/sea")
require("Assets/Lib/collision")
require("Assets/Lib/canvas")

width=love.graphics.getWidth()
height=love.graphics.getHeight()

function love.load()  
--
    wintone= love.audio.newSource("Assets/Songs/winSong.mp3","stream")
    wintone:setVolume(1.0)
    falltone= love.audio.newSource("Assets/Songs/loseSong.mp3","stream")
    falltone:setVolume(1.0)
    music= love.audio.newSource("Assets/Songs/music.mp3","stream")
    music:setLooping(true)
    music:setVolume(0.1)
    music:play()
    
    flagStart=true
    flagLost=false
--
    tela.load()
    play.load()
    mountains.load()
    poke.load()
    sea.load()
--
    cont=0
    pontos=0
    lancarBall=true   
--   
end
function love.update(dt)
--
    if not (flagLost or flagStart) then
        play.update(dt)
        sea.update(dt)
        mountains.update(dt)
        poke.update(dt)
--
        checarBall(player,balls)
        checarMon(player,mountain)
    elseif flagLost then
        tela.update(dt)
    end
    verClique()
end
function love.draw()
--
    love.graphics.setFont(font)
--
    if flagStart then
        tela.startDraw()
    elseif flagLost then
        tela.loseDraw()
    else
--
        sea.draw()
        mountains.draw()
        poke.draw()
        play.draw()
--
        pontuacaoDraw()
    end

end
function pontuacaoDraw()
    love.graphics.setColor(0,0,0,255)
    love.graphics.print("pontos: "..cont,20,20)
    love.graphics.setColor(255,255,255,255)
end
function reset()
    music:stop()
    falltone:play()
--
    flagLost=true
--
    play.reset()
    mountains.reset()
    poke.reset()
--
    pontos=cont
end
function win()
    wintone:stop()
    wintone:play()
    cont=cont+10
end
function verClique()
    if flagLost then
        if love.mouse.isDown(1) then
			        flagLost=false
		      end
        touchs=love.touch.getTouches()
        for i, id in ipairs(touchs) do
            if checarClique(id,rs.x,rs.y,rs.width,rs.height) then
                love.system.vibrate(0.5)
                flagLost=false
                music:play()
            elseif checarClique(id,ex.x,ex.y,ex.width,ex.height) then
                love.system.vibrate(0.5)
                love.event.quit()
            else
                flagLost=true
            end
        end
    end
    if flagStart then
        if love.mouse.isDown(1) then
			        flagStart=false
		      end
        touchs=love.touch.getTouches()
        for i, id in ipairs(touchs) do
            if id~=nil then
                flagStart=false

            end
        end
    end
end