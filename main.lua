function lovr.load()
	shader = require('lighting')()
	lovr.graphics.setShader(shader)
end

function lovr.update(dt)

end

function lovr.draw()
	local time = lovr.timer.getTime()

	for dep = -5, 5 do
		for col = -2, 2 do
			for row = 0, 3 do
				local r, g, b = hsv(.08 * (row + col + dep) + lovr.timer.getTime() * .5, .5, 1)
				local y = row + (math.sin(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
				local z = dep + -(math.cos(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
				local size = .2 + (math.sin(time + col + row) * .05)

				lovr.graphics.setColor(r, g, b)
				lovr.graphics.sphere(col, y, z, size, 0, 0, 0, 0, 10)
			end
		end
	end
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
