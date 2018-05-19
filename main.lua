function lovr.load()
	shader = require('lighting')()
	lovr.graphics.setShader(shader)
end

function lovr.update(dt)

end

function lovr.draw()
	for i = -2, 2 do
		for j = 0, 3 do
			lovr.graphics.sphere(i, j + (math.sin(lovr.timer.getTime() * 3 + i + (j * .9) + select(3, lovr.headset.getPosition())) * .075), -3, .25)--x, y, z, size, angle, ax, ay, az)
			-- lovr.graphics.sphere(i, j + (math.sin(lovr.headset.getPosition() * 3 + i + (j * .5)) * .2), -3, .25)--x, y, z, size, angle, ax, ay, az)

		end
	end
end

function lovr.controlleradded(...)
end

function lovr.controllerremoved(...)
end

function lovr.controllerpressed(...)
end

function lovr.controllerreleased(...)
end
