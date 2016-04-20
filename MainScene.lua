local socketTcp = require('app.views.SocketTCP')
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    self:setPosition1(100, 100)

    local s = socketTcp.new('127.0.0.1', 17642)
    s:connect()
    local function onConnected(event)
        s:send('test it')
    end
    local function onData(__event)
         print("socket status: %s, partial:%s", __event.name, __event.data)
    end
    s:addEventListener(socketTcp.EVENT_CONNECTED, onConnected)
    s:addEventListener(socketTcp.EVENT_DATA, onData)
end

return MainScene
