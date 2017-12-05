--- === EventGhostServer ===
---
--- Execute callbacks using an EventGhost-compatible HTTP API
---
--- Download: https://github.com/c99koder/HS-EventGhostServer/releases

local obj={}
obj.__index = obj

-- Metadata
obj.name = "EventGhostServer"
obj.version = "1.0"
obj.author = "Sam Steele <sam.steele@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.homepage = "https://github.com/c99koder/HS-EventGhostServer/"

function obj:init()
	self.handlers = {}
end

--- EventGhostServer:start(port)
--- Method
--- Starts the HTTP server
---
--- Parameters:
---  * port - Port number to listen on
---
--- Returns:
---  * None
function obj:start(port)
	self.server = hs.httpserver.new(false):setName("EventGhostServer_" .. port)
	:setPort(port)
	:setCallback(function(type,path,headers,body)
		local _, _, event, value = string.find(path:gsub("+", " "), "^/%?([^&]+)&?(.*)$")
		if event then
			if value then
				print('EventGhostServer received event: ' .. event .. ' value: ' .. value)
			else
				print('EventGhostServer received event: ' .. event)
			end
			if self.handlers[event] then
				self.handlers[event](event, value)
			end
		end
		return 'OK', 200, {} 
	end):start()
	print('Started HTTP server on port ' .. self.server:getPort())
end

--- EventGhostServer:registerHandler(event, handler)
--- Method
--- Registers a handler for a specific event
---
--- Parameters:
---  * event - A string specifying the event name to listen to
---  * handler - A function that will be called when the event happens. It should accept two parameters:
---    * event - A string containing the name of the event that occured
---    * value - An optional value that was included with the event
---
--- Returns:
---  * None
function obj:registerHandler(event, handler)
	self.handlers[event] = handler
end

return obj