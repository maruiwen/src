
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
 	 -- self:testSlider();
 	 -- self:testPushButton();
 	 --  self:testInput(); --UITextField EditBox
 	  --  self:testCheckBox();
 	  -- self:testCheckBoxGroup();
      --self:testScrollView();
 	   self:testListView(); --UITableView
 	  -- self:testPageView();
end

function MainScene:testSlider()
	-- @param1 滑动方向 
	-- @param2 images图片 
	-- @param3 options可选参数
	local slider = cc.ui.UISlider.new(display.LEFT_TO_RIGHT,{
			bar = "sliderProgress.png", --背景图片
			button = "sliderThumb.png"  --按钮
		},{
			min = 0,                    --最小值
			max = 100,                   --最大值(可选 默认为0-100)
			touchInButton = true       --是否只在触摸在滑动块上时才有效，默认为真
		})
	--用户滑动监听
	slider:onSliderValueChanged(function ( event )
		-- printf("%.2f", event.value)--dump(event)
	end)
	
	slider:setSliderSize(250, 13);-- 设置slider大小
	slider:pos(115, 300)
	self:add(slider);

	self._slider = slider
end

function MainScene:testPushButton(  )
	local btn = cc.ui.UIPushButton.new({
			normal = "btn-play-normal.png",
			pressed = "btn-play-selected.png"
		})
	--用户点击监听
	btn:onButtonClicked(function ( event )
		local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
		scheduler.scheduleGlobal(function ( )
		if self._slider:getSliderValue()>=100 then
			self._slider:setSliderValue(0)
		end
		self._slider:setSliderValue(self._slider:getSliderValue()+1)
		end,0,false)

	end)
	--用户按下监听
	btn:onButtonPressed(function ( event )
		print("按下")
	end)
	--用户释放监听
	btn:onButtonRelease(function (  )
		print("释放")
	end)
	btn:pos(display.cx, 40)
	self:add(btn)
end
inScene:testInput()
function Ma
	-- create EditBox
	local function onEdit(event, editbox)
    if event == "began" then
        print("开始输入")
    elseif event == "changed" then
        print("输入框内容发生变化")
    elseif event == "ended" then
        print("输入结束")
    elseif event == "return" then
        print("从输入框返回")
    end
end
	local input = cc.ui.UIInput.new({
			image = "green_edit.png",
			size = cc.size(200, 40),
			x = 240,
			y = 260,
			listener = onEdit
		})
	input:setInputFlag(0) --设为密码输入框
	input:setMaxLength(3) --输入长度
	input:setPlaceHolder("请输入密码") --占位符
	self:add(input)
 
	-- local bgSprite = display.newScale9Sprite("yellow_edit.png", 0, 0, 
	-- 					cc.size(200, 40)):pos(240, 180)

 -- 	self:add(bgSprite)
	-- local function onTextField( testField,eventType )	
	 	   
	-- end
	-- -- 没有背景图片
	-- local input2 = cc.ui.UIInput.new({
	-- 		UIInputType = 2,
	-- 		size = cc.size(200, 40),
	-- 		listener = onTextField, 
	-- 		x = 100,y=20,
	-- 		text = "abc",
	-- 		placeHolder = "请输入",
	-- 		maxLength = 10,
	-- 		passwordEnable = true
	-- 	})
	-- bgSprite:add(input2)
end

function MainScene:testCheckBox(  )
	local checkBox = cc.ui.UICheckBoxButton.new({
			off = "check_box_normal.png",
			on = "check_box_active.png"

		})
	checkBox:onButtonStateChanged(function( event )
		if event.state == "on" then
			print("选中")
		elseif event.state == "off" then
			print("未选中")
		end
	end)
	checkBox:setButtonSelected(true) --设置是否选中
	checkBox:pos(400, 300)
	self:add(checkBox)
end

function MainScene:testCheckBoxGroup(  )
	local group = cc.ui.UICheckBoxButtonGroup.new(display.TOP_TO_BOTTOM)
	group:addButton(cc.ui.UICheckBoxButton.new({
			off = "check_box_normal.png",
			on = "check_box_active.png"
		})
            :setButtonLabel(cc.ui.UILabel.new({
            		text = "option 1", color = cc.c3b(255, 0, 0)
            	}))
            :setButtonLabelOffset(20, 0)
            :align(display.LEFT_CENTER)
        )

	group:addButton(cc.ui.UICheckBoxButton.new({
			off = "check_box_normal.png",
			on = "check_box_active.png"
		})
            :setButtonLabel(cc.ui.UILabel.new({text = "option 2", color = cc.c3b(255, 0, 0)}))
            :setButtonLabelOffset(20, 0)
            :align(display.LEFT_CENTER)
        )

	group:addButton(cc.ui.UICheckBoxButton.new({
			off = "check_box_normal.png",
			on = "check_box_active.png"
		})
            :setButtonLabel(cc.ui.UILabel.new({text = "option 3", color = cc.c3b(255, 0, 0)}))
            :setButtonLabelOffset(20, 0)
            :align(display.LEFT_CENTER)
        )

	group:addButton(cc.ui.UICheckBoxButton.new({
			off = "check_box_normal.png",
			on = "check_box_active.png"
		})
            :setButtonLabel(cc.ui.UILabel.new({text = "option 4", color = cc.c3b(255, 0, 0)}))
            :setButtonLabelOffset(20, 0)
            :align(display.LEFT_CENTER)
        )
	group:onButtonSelectChanged(function ( event )
		dump(event)
		print("你选中了第" .. event.selected .."个")
	end)
	group:align(display.LEFT_TOP, 50, display.cy)
	self:add(group)
end

function MainScene:testScrollView(  )

	local scrollView = cc.ui.UIScrollView.new({
			direction = 2,
			viewRect = cc.rect(60,60, 360, 215),
			-- scrollbarImgH = "sliderProgress.png",
			-- scrollbarImgV = "sliderProgress.png"
			bg = "sliderProgress.png",
			bgScale9 = true
		})
	--滑动时的监听事件
	scrollView:onScroll(function ( event )
		print(event.name)
	end)
	scrollView:setBounceable(false) -- 是否回弹
	self:add(scrollView)

	local t = {}
    for i = 1, 8 do
        local png  = cc.ui.UIImage.new(
        	string.format("Scenes/LEVELSELECTION_%d.png",i))
        t[#t+1] = png
        cc.ui.UILabel.new({text = i, size = 24, color = cc.c3b(200,100,100)})
            :align(display.CENTER, png:getContentSize().width/2, png:getContentSize().height/2)
            :addTo(png)
        
  --       local btn = cc.ui.UIPushButton.new({
		-- 	normal = string.format("Scenes/LEVELSELECTION_%d.png",i),
		-- 	pressed = string.format("Scenes/LEVELSELECTION_%d.png",i)
		-- })
		-- btn:setContentSize(cc.size(120,200))
		-- t[#t+1] = btn
    end
    scrollView:fill(t, {itemSize = (t[#t]):getContentSize()})
end

function MainScene:testPageView(  )
	local pageView = cc.ui.UIPageView.new({
			viewRect = cc.rect(20, 20, 440, 280),
			column=4,row=3,
			padding = {left = 10, right = 10, top = 10, bottom = 10},
			columnSpace = 10, rowSpace = 20
		})
	pageView:onTouch(function ( event )
		print(event.pageIdx,event.itemIdx)
	end)
	self:add(pageView)

	for i=1,24 do
		local item = pageView:newItem()
		local content = cc.LayerColor:create( 
				cc.c4b(math.random(250),
                math.random(250),
                math.random(250),
                250))
		content:setContentSize(100, 80)
		item:addChild(content)
		pageView:addItem(item) -- 自动排列
	end
	pageView:reload()
end

--[[--

UIListView构建函数

可用参数有：

-   direction 列表控件的滚动方向，默认为垂直方向
-   alignment listViewItem中content的对齐方式，默认为垂直居中
-   viewRect 列表控件的显示区域
-   scrollbarImgH 水平方向的滚动条
-   scrollbarImgV 垂直方向的滚动条
-   bgColor 背景色,nil表示无背景色
-   bgStartColor 渐变背景开始色,nil表示无背景色
-   bgEndColor 渐变背景结束色,nil表示无背景色
-   bg 背景图
-   bgScale9 背景图是否可缩放
-	capInsets 缩放区域

]]
function MainScene:testListView(  )
	local listView = cc.ui.UIListView.new({
			direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,
			viewRect = cc.rect(100,50,300,200),
			bgColor = cc.c4b(200, 200, 200, 120)
		})
	self:add(listView)

	for i=1,10 do
		local item = listView:newItem()
		local btn = cc.ui.UIPushButton.new({normal = "btn-play-normal.png",
			pressed = "btn-play-selected.png"})
		btn:setTag(i)
		btn:onButtonClicked(function ( event )
			 print("点击第" .. i .. "行" )

		end)
		item:setItemSize(100,40)
		item:addContent(btn)
		listView:addItem(item)
	end
	listView:reload()
end
 

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
