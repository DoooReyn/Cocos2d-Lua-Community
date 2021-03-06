local BaseLayer = require("app.scenes.BaseLayer")

local TestCase = class("Test_FairyGUI", BaseLayer)

function TestCase:ctor()
	self.super.ctor(self)

	-- tips
	self.fairyRoot = fairygui.GRoot:create(display.getRunningScene())
    self.fairyRoot:retain()

	fairygui.UIPackage:addPackage("fairygui/package01");
    local view = fairygui.UIPackage:createObject("package01", "StartLayer")
	view:setOpaque(false) -- ignore touch
    self.fairyRoot:addChild(view)

	-- btn event, fairy has it's own EventDispatcher, cover the cocos's node
	view:getChild("n9"):addEventListener(fairygui.UIEventType.TouchEnd, function(context)
		local input = context:getInput()
		local touchPos = input:getTouch():getLocation()
		if input:getTarget():hitTest(touchPos, cc.Camera:getVisitingCamera()) then
			print("touch ended")
			self.fairyRoot:release()
		else
			print("touch canceled")
		end
	end)
end

return TestCase
