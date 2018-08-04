flux = require 'flux'
wave = require 'wave'

function lovr.load()
	shader = require('lighting')()
	lovr.graphics.setShader(shader)
	music = wave:newSource('song2.ogg', 'stream')
	music:setBPM(170)
	song = lovr.audio.newSource('song2.ogg')
	song:play()
	-- music:parse()
	-- music:setIntensity(20)
	balls = {}
	balls.size = .2
	runningTime = 0
end

function lovr.update(dt)
	flux.update(lovr.timer.getDelta())
	music:update(dt)

	-- music:onBeat(function()
	-- 	pulseBalls()
	-- end)

	local t = lovr.timer.getTime()
	if (t - runningTime) > .345 then
		runningTime = t
		pulseBalls()
	end
end

function lovr.draw()
	-- lovr.graphics.setWireframe(true)

	defaultMovement()
end

function defaultMovement()
	local time = lovr.timer.getTime()
	for dep = -5, 5 do
		for col = -2, 2 do
			for row = 0, 3 do
				local r, g, b = hsv(.08 * (row + col + dep) + lovr.timer.getTime() * .5, .5, 1)
				local y = row + (math.sin(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
				local z = dep + -(math.cos(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
				-- balls.size = balls.size-- + (math.sin(time + col + row) * .05)

				lovr.graphics.setColor(r, g, b)
				lovr.graphics.sphere(col, y, z, balls.size, 0, 0, 0, 0, 10)
			end
		end
	end
end

function pulseBalls()
	local oSize = balls.size
	local nSize = balls.size * 1.15
	flux.to(balls, 0.1, { size = nSize })
	flux.to(balls, 0.1, { size = oSize }):delay(0.05)
end

function hsv(h, s, v)
  local r, g, b

  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return r, g, b
end

function lovr.controlleradded(...)
end

function lovr.controllerremoved(...)
end

function lovr.controllerpressed(...)
end

function lovr.controllerreleased(...)
end
