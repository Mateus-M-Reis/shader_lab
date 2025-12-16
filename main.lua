local pi = math.pi

-- main.lua
lovr.window = require('lib.lovr-window')

local shader, vertices, mesh,

  kaleidoscope, star_nest, fire

function lovr.load()
  lovr.window.setMode(960, 540, { borderless = true, x = 0, y = 540 })

  vertices = {{-1, -1, 0}, {1, -1, 0}, {-1, 1, 0}, {1, 1, 0}}
  mesh = lovr.graphics.newMesh(vertices, 'cpu')

  kaleidoscope = require('shaders.kaleidoscope')
  star_nest = require('shaders.star-nest')
  fire = require('shaders.fire')

  shader = star_nest
end

function lovr.draw(pass)
  pass:setShader(shader)
  pass:plane()
  --pass:draw(mesh)
  pass:setShader()
end

function lovr.keypressed(key, scancode, is_repeat)

  -- map to individual keys for now
  if key == '1' then
    shader = kaleidoscope
  elseif key == '2' then
    shader = star_nest
  elseif key == '3' then
    shader = fire
  end
end
