--绘制
function sys_player_draw()
	local p=actors[1]
	spr(p.c.spr,p.x,p.y)
end

function sys_en_draw()
	 foreach(actors, function(e)
        if e.c.kind == "enemy" then
            spr(e.c.spr, e.x, e.y)  --绘制敌人
        end
    end)
end

function sys_bul_draw()
	foreach(actors,function(b)
		if b.c.kind=="bullet" then spr(b.c.spr,b.x,b.y) end
	end)
end

function sys_particle_draw()
	foreach(actors,function(p) --foreach函数
		if p.c.kind=="particle" then
			circ(p.x,p.y,1,p.c.color)
		end
	end)
end
