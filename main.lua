flux = require 'flux'
wave = require 'wave'
icosphere = require 'icosphere'

function lovr.load()
	shader = require('lighting')()
	lovr.graphics.setShader(shader)
	music = wave:newSource('cinders.ogg', 'stream')
	music:parse()
	music:setIntensity(20)
	music:detectBPM()
	music:play();
	balls = {}
	balls.size = .2
	runningTime = 0
	vertices, indices = icosphere(2)
	mesh = lovr.graphics.newMesh(vertices, 'triangles')
	mesh:setVertexMap(indices)
	showWireframe = false
	spiraling = true
	pulsing = true
end

function lovr.update(dt)
	flux.update(lovr.timer.getDelta())
	music:update(dt)
	-- updateBlob()
end

function lovr.draw()
	if pulsing then balls.size = music:getEnergy() * .06 end

	lovr.graphics.setWireframe(showWireframe)
	drawBalls()
	-- drawBlob()
end

function toggleWireframe()
	showWireframe = showWireframe and false or true
end

function drawBalls()
	local time = lovr.timer.getTime()
	for dep = -5, 5 do
		for col = -2, 2 do
			for row = 0, 3 do
				local y = row
				local z = dep
				local r, g, b = hsv(.08 * (row + col + dep) + lovr.timer.getTime() * .5, .5, 1)
				if spiraling then y, z = spinBalls(col, row, dep, time) end

				lovr.graphics.setColor(r, g, b)
				mesh:draw(col, y, z, balls.size)
			end
		end
	end
end

function spinBalls(col, row, dep, time)
	local y = row + (math.sin(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
	local z = dep + -(math.cos(time * 3 + col + (row * .9) + select(3, lovr.headset.getPosition())) * .075)
	return y, z
end

function updateBlob()
	local t = lovr.timer.getTime()
	for i = 1, #vertices do
		local v = vertices[i]
		local x, y, z = unpack(v)
		local length = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
		x, y, z = x / length, y / length, z / length
		local offset = t / 2
		local n = (1 + lovr.math.noise(x/2 + offset, y/2 + offset, z/2 + offset)) ^ 5
		n = n * (music:getEnergy() * .1 + .5)
		x, y, z = x * n, y * n, z * n
		v[1], v[2], v[3] = x, y, z
	end
	mesh:setVertices(vertices)
end

function drawBlob()
	local time = lovr.timer.getTime()
	local r, g, b = hsv(.08 * lovr.timer.getTime() * .5, .5, 1)
	lovr.graphics.setWireframe(true)
	lovr.graphics.setColor(r, g, b)
	mesh:draw(0, 1, -3, .2)
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
