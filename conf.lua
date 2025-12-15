function lovr.conf(t)
  t.version = '0.0.1'
  t.identity = 'default'

  t.saveprecedence = true

  t.modules.audio    = false
  t.modules.data     = false
  t.modules.sound    = false
  t.modules.touch    = false
  t.modules.mouse    = false

  --t.modules.event    = true
  --t.modules.image    = true
  --t.modules.keyboard = true
  --t.modules.math     = true
  --t.modules.physics  = true
  --t.modules.thread   = true
  --t.modules.video    = true
  --t.modules.joystick = true
  --t.modules.graphics = true
  --t.modules.timer    = true
  --t.modules.system   = true
  --t.graphics.stencil = true
  --t.headset.stencil = true

  t.window.width = 960
  t.window.height = 540
  t.window.fullscreen = false
  --t.window.resizable = true
  --t.window.icon = nil

  -- additional window parameters
  t.window.fullscreentype = "desktop"	-- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
  t.window.x = 0			-- The x-coordinate of the window's position in the specified display (number)
  t.window.y = 500			-- The y-coordinate of the window's position in the specified display (number)
  --t.window.minwidth = 960			-- Minimum window width if the window is resizable (number)
  --t.window.minheight = 540			-- Minimum window height if the window is resizable (number)
  t.window.display = 1			-- Index of the monitor to show the window in (number)
  --t.window.centered = false		-- Align window on the center of the monitor (boolean)
  --t.window.topmost = true		-- Show window on top (boolean)
  t.window.borderless = true		-- Remove all border visuals from the window (boolean)
  t.window.resizable = true		-- Let the window be user-resizable (boolean)
  t.window.opacity = 1			-- Window opacity value (number)
end
