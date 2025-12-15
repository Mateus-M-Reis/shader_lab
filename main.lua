-- main.lua
lovr.window = require('lib.lovr-window')

local kaleidoscope

function lovr.load()
  lovr.window.setMode(960, 540, { borderless = true, x = 0, y = 540 })

  kaleidoscope = require('shaders/kaleidoscope')
end

function lovr.draw(pass)
  pass:setShader(kaleidoscope)
  pass:plane()
  pass:setShader()
end
