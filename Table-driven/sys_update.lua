--更新
function sys_player_upd()
	local p=actors[1] --将第一个放入p中，因为在_init()中，主角是第一个entity的
	if btn(0) then p.x-=1 end
	if btn(1) then p.x+=1 end	
	if btn(2) then p.y-=1 end
	if btn(3) then p.y+=1 end
	p.x=mid(0,p.x,232)
	p.y=mid(0,p.y,172)
	if btnp(5) then
		spawn_bullet(p.x+4,p.y)
	end
end

function sys_en_upd()
	foreach(actors,function(e)
		if e.c.kind=="enemy" then
      if rnd() < 0.05 then
        e.c.direction = flr(rnd(4))
      end
      if e.c.direction == 0 then
        e.x += e.c.speed
      elseif e.c.direction == 1 then
        e.x -= e.c.speed
      elseif e.c.direction == 2 then
        e.y += e.c.speed
      elseif e.c.direction == 3 then
        e.y -= e.c.speed
      end
      e.x = mid(0, e.x, 232)--240 边界限制
      e.y = mid(0, e.y, 172)--180 边界限制
		end
	end)
end

function sys_bul_upd()
	foreach(actors,function(b)
		if b.c.kind=="bullet" then 
			b.y-=3
			if b.y<-8 then del(actors,b) end
		end
	end)
end

function sys_collision_upd()
	foreach(actors,function(b)
		if b.c.kind=="bullet" then
			foreach(actors,function(e)
				if e.c.kind=="enemy" and rect_overlap(b.x,b.y,b.x+2,b.y+2,e.x,e.y,e.x+7,e.y+7) then
					del(actors,b)
					del(actors,e)
					spawn_particles(e.x+4,e.y+4)
				end
			end)
		end
	end)
end

function sys_particle_upd()
	foreach(actors,function(p)
		if p.c.kind=="particle" then
			p.y+=p.c.vy
			p.c.life-=1 
			if p.c.life<=0 then
				del(actors,p)
			end
		end
	end)
end
