pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function _init()
	player = new_player(32, 32)
	obstacle = new_obstacle(59, 0, 10, 10, 9)
end

function _update()
	if (btn(0)) then player.move(-1,0) end
	if (btn(1)) then player.move(1,0) end
	if (btn(2)) then player.move(0,-1) end
	if (btn(3)) then player.move(0,1) end
	if (btnp(4)) then obstacle.grow_horizontal(10) end
	if (btnp(5)) then obstacle.change_colour() end
end

function _draw()
	rectfill(0,0,127,127,7)
	player.show()
	obstacle.show()
	if (player.collides_with(obstacle)) then obstacle.change_colour() end
end

-->8
	-- player class
	function new_player(x, y)
		local p = {}
		
		p.x = x
		p.y = y
		p.w = 10
		p.h = 10
		
		p.collides_with = function(other)
			if ((p.x <= other.x + other.w) and 
				(p.x + p.w >= other.x) and 
				(p.y <= other.y + other.h) and 
				(p.y + p.h >= other.y)) then
				return true
			else
				return false
			end
		end
		
		p.move = function(x,y)
			p.x += x
			p.y += y
		end
		
		p.show = function()
			rectfill(p.x, p.y, p.x + p.w, p.y + p.w, 8)
		end
		
		return p
	end
	-- end player class
	
-->8
	-- obstacle class
	function new_obstacle(x,y,w,h,c)
		local o = {}
		
		o.x = x
		o.y = y
		o.w = w
		o.h = h
		o.c = c
		
		o.grow_horizontal = function(n)
			growth = n or 1
			o.x -= growth
			o.w += growth*2
		end
		
		o.grow_vertical = function(n)
			growth = n or 1
			o.y -= growth
			o.h += growth*2
		end
		
		o.move = function(x,y)
			o.x += x
			o.y += y
		end
		
		o.change_colour = function(c)
			if (o.c < 15) then temp = o.c + 1 else temp = 1 end
			colour = c or temp
			if (colour == 7) then colour += 1 end
			o.c = colour
		end
		
		o.show = function()
			rectfill(o.x, o.y, o.x + o.w, o.y + o.h, o.c)
		end
		
		return o
	end
	-- end obstacle class
