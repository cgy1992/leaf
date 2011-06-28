-- ++++++++++++++++++++++++++++++
-- + Leaf Console Module        +
-- + Copyright 2011 Josh Bothun +
-- + joshbothun@gmail.com       +
-- + minornine.com              +
-- ++++++++++++++++++++++++++++++

require 'leaf.object'
require 'leaf.containers'

local Message = leaf.Object:extend('Message')

function Message:init(str, err)
	self.str 	= str or ''
	self.err 	= err or false
end

----[[ Console singleton ]]----

leaf.console = {}
local console = leaf.console

console.queue = leaf.Queue:new()

function console.write(str)
	console.queue:push(Message:new(str, false))
end

function console.err(str)
	console.queue:push(Message:new(str, true))
end

function console.draw()
	local spacing = 15
	love.graphics.setFont(12)
	love.graphics.setColor(255, 255, 255, 150)
	num = 0
	for i = console.queue.front, console.queue.back do
		num = num + 1
		local msg = console.queue[i]
		love.graphics.print(msg.str, 5, (num - 1) * spacing)
	end
end

console.write('Console initialized')
