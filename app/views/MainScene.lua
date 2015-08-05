
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:testMenu()
    -- Menu的制作
    local menu = cc.Menu:create()
    self:addChild(menu)

    local menuItem = cc.MenuItemFont:create("HelloMenu")
    menu:addChild(menuItem)

    local function callback()
        print("Hello Menu")
    end

    menuItem:registerScriptTapHandler(callback)
end

function MainScene:onEnter()
    print("OnEnter")
end

function MainScene:scrollViewTest()
    local view = cc.ScrollView:create(display.size)
    self:addChild(view)
    local node = view:getContainer()

    for i = 0, 3 do
        local sprite = cc.Sprite:create("PlaySceneBg.jpg")
        node:addChild(sprite)
        sprite:setPosition(display.center.x + i * display.width, display.center.y)
    end

    view:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    view:setContentSize(cc.size(display.width*4, display.height))
end

function MainScene:touchTest()

    
    local disp = cc.Director:getInstance():getEventDispatcher()
    local function onTouchBegan(touch, event)
        print("began and send custom event")
       
        local event = cc.EventCustom:new("MyEventType")
        disp:dispatchEvent(event) 

     --   disp:dispatchCustomEvent("MyEventType")
     --   disp:dispatchCustomEvent("MyEventType")
      --  cc.App:enterScene("MyScene")
     --   self.app_:enterScene("MyScene", "FADE", 2)

        return true
    end
    local function onTouchEnded(touch, event)
    end

    local function onTouchMoved(touch, event)
    end

    local ev = cc.EventListenerTouchOneByOne:create()

    ev:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    ev:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    ev:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)

    
    disp:addEventListenerWithSceneGraphPriority(ev, self)
end

function MainScene:testSchedule()
    
    local scheduler = nil
    local entry = nil

    local function func(dt)
        print("schedule callback")
        scheduler:unscheduleScriptEntry(entry)
    end

    scheduler = cc.Director:getInstance():getScheduler()
    entry = scheduler:scheduleScriptFunc(func, 1, false)
end

function MainScene:animationTest()
    local spriteFrameCache = cc.SpriteFrameCache:getInstance()
    spriteFrameCache:addSpriteFrames("grossini_blue.plist")

    local spriteFrames = {}
    for i = 1, 4 do 
        local spriteFrameName = string.format("grossini_blue_%02d.png", i)
        local spriteFrame = spriteFrameCache:getSpriteFrame(spriteFrameName)
        table.insert(spriteFrames, spriteFrame)
    end

    local animation = cc.Animation:createWithSpriteFrames(spriteFrames, 0.5)
    local animate = cc.Animate:create(animation)
    local rep = cc.RepeatForever:create(animate)

    local sprite = cc.Sprite:create()
    self:addChild(sprite)
    sprite:setPosition(display.center)

    sprite:runAction(rep)
end

function MainScene:customEventTest()

    local function eventHandler(ev)
       
        print("handle custom event")
    end

    local ev = cc.EventListenerCustom:create("MyEventType", eventHandler)

    local disp = cc.Director:getInstance():getEventDispatcher()
    disp:addEventListenerWithSceneGraphPriority(ev, self)
end

function MainScene:tableViewTest()

    -- cells
    local cells = {}
   
    for i = 1, 5 do 
        local cell = cc.TableViewCell:create()
     --   table.insert(cells, cell)

        local sprite = cc.Sprite:create("Star.png")
        cell:addChild(sprite)
        sprite:setPosition(cc.p(22, 22))
    end

    -- cells end

    local tableView = cc.TableView:create(cc.size(44, 44))
    

    local function cellSize(view)
        print("cellSize")
        return 44, 44
    end
    local function cellAtIdx(view, idx)
        print("cellAtIdx", idx)
    --    return cells[idx+1]
        
        if cells[idx] then return cells[idx] end

        local cell = cc.TableViewCell:create()
        cells[idx] = cell

        local sprite = cc.Sprite:create("Star.png")
        cell:addChild(sprite)
        sprite:setPosition(cc.p(22, 22))

        return cell
        
    end
    local function cellNumber(view)
        print("cellNumber")
        return 5
    end
    local function cellTouch(view, cell)
       print("touch", cell:getIdx())
    end

    tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(cellAtIdx, cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(cellNumber, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    tableView:registerScriptHandler(cellTouch, cc.TABLECELL_TOUCHED)

    tableView:setDelegate()
    
    self:addChild(tableView)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableView:setPosition(display.cx, display.cy)
    tableView:reloadData()
end

function MainScene:tableViewTest1()

    -- 准备好格子对象
    local cells = {}
    --[[
    for i = 1, 5 do
        local cell = cc.TableViewCell:create()
        table.insert(cells, cell)

        local sprite = cc.Sprite:create("Star.png");
        cell:addChild(sprite)
        sprite:setPosition(22, 22)
    end
    ]]--
    --

    local tableView = cc.TableView:create(cc.size(44, 44));
    self:addChild(tableView)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableView:setPosition(display.center)
    tableView:setDelegate()

 --   local function cellSize(table, idx)
    local function cellSize()
    --    return cc.size(44, 44)
        return 44, 44
    end

    local function cellAtIndex(table, idx)
        print("idx****************", idx)
        if cells[idx] == nil then
            local cell = cc.TableViewCell:create()
          --  table.insert(cells, cell)
            cells[idx] = cell

            local sprite = cc.Sprite:create("Star.png");
            cell:addChild(sprite)
            sprite:setPosition(22, 22)
            return cell
        end

        return cells[idx]
    --    return cells[idx];
    end

    local function cellNumber(table)
        return 5
    end

    local function cellTouch(table, cell)
        print(cell)
        print("cell index is:" , cell:getIdx())
    end

    -- 获取TableCell尺寸的回调函数
    tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(cellNumber, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    tableView:registerScriptHandler(cellTouch, cc.TABLECELL_TOUCHED)

    tableView:reloadData()
end

--MyVar = 20

a = 
{
    b = {
            c = 13
        },
    d = 14
}

function MainScene:onCreate()

  --  self:testMenu()
  --  self:scrollViewTest()
    self:touchTest()
  --  self:testSchedule()
  -- self:animationTest()
    self:customEventTest()
  -- self:tableViewTest1()

    cppForLua()
    print("now a.a.a is", a.b.c)
 
 --[[   
    cppForLua()

    print("now global var is:", global_var_int)
    print("now global var1 is:", global_var_int1)
    print("now a.a.a is:", a.a.a)
    ]]--
    
end

return MainScene
