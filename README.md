# HS-EventGhostServer
An [EventGhost](http://www.eventghost.net/)-compatible HTTP server for [HammerSpoon](http://www.hammerspoon.org/)

## About

This module allows [HammerSpoon](http://www.hammerspoon.org/) to respond to events using a HTTP server compatible with [EventGhost](http://www.eventghost.net/).  It was designed to be used with the SmartThings [Send Events To EventGhost](https://github.com/aderusha/SmartThings/blob/master/Send-Events-to-EventGhost.groovy) SmartApp.

## Installing

Download and extract the latest version of the module from the [Releases page](https://github.com/c99koder/HS-EventGhostServer/releases) and double-click the Spoon file to install the module into `~/.hammerspoon/Spoons`.

## Usage

While the server is running, it will log the incoming event names to the console to quickly create new event handlers.  Below is an example Lua script using this module to react to various events from a SmartThings hub:

```
speech = hs.speech.new()
eg = hs.loadSpoon('EventGhostServer')

--- Register a handler for motion sensor `Living Room Motion Sensor` that will log a message to the HammerSpoon console
eg:registerHandler("ST.Living Room Motion Sensor.motion.active",
    function(event, value)
        print "Motion detected in the living room!"
    end
)

--- Register a handler for contact sensor `Living Room Patio Door` that will speak a phrase using the default Mac OS X voice
eg:registerHandler("ST.Living Room Patio Door.contact.open",
    function(event, value)
        speech:speak("Patio door is open")
    end
)

--- Register a handler for virtual switch `Lock iMac` that will start the screensaver
eg:registerHandler("ST.Lock iMac.switch.on",
    function(event, value)
        hs.caffeinate.startScreensaver()
    end
)

--- Start the server on port 8081
eg:start(8081)
```
