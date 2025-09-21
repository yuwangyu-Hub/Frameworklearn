--表驱动学习案例
--picotron中

include "sys_update.lua"
include "sys_draw.lua"
window(240,180)

debug=""
debug1=""

function reg_sys(name,upd,draw) --u=update,d=draw
	systems[name] ={u=upd,d=draw,active=true} -- key = value
end

function entity(x,y,comps) --comps=component
	local a={x=x,y=y,c=comps}
	add(actors,a)
	return a
end

function _init()
	actors={}	
	systems={}
	
	reg_sys("player",sys_player_upd,sys_player_draw)
	reg_sys("enemy",sys_en_upd,sys_en_draw)
	reg_sys("bullet",sys_bul_upd,sys_bul_draw)
	reg_sys("collision",sys_collision_upd, nil)
	reg_sys("particle",sys_particle_upd,sys_particle_draw)
	------------player
	entity(64,64,{kind="player",spr=1,alive=true})
	------------enemies
	for i=1,3 do
		local x,y
		if i==1 then
			x,y=10,10
		elseif i==2 then
			x,y=118,10
		else
			x,y=64,118
		end 
		entity(x,y,{kind="enemy",spr=2,speed=.5,direction=0,alive=true})
	end
	
end


function _update()
	for _,s in pairs (systems) do 
		if s.active then
			s.u() 
		end
	end
end

function _draw()
	cls()
	for _,s in pairs (systems) do
		if s.active and s.d then 
			s.d()
		end
	end

	print(debug)
	print(debug1)
	
end


function spawn_bullet(x,y)
	entity(x,y,{kind="bullet",spr=3,alive=true})
end

function 	spawn_particles(x,y)
	for i=1,3 do
		entity(x,y,{kind="particle",color=14,life=10,vy=flr(rnd(2)-1)})
	end
end

function rect_overlap(x1,y1,x2,y2,x3,y3,x4,y4)
  return x1 < x4 and x2 > x3 and y1 < y4 and y2 > y3
end
