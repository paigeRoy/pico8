pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
cls(0)

//array of points for 
//the bezier curve
p_x = {1,2,4,5,2}
p_y = {2,5,6,2,-3}
out = {0,0}

//add scaling factor
scl = 8

// factorial
function fact(n)
 if n==0 then
  return 1
 else
  return n * fact(n-1)
 end
end

//subroutine for bernstein
function c(n,i)
 return (fact(n))/(fact(i)*fact(n-i))
end
 
//bernstein
function bernstein(i,n,u)
	return c(n,i)*(u^i)*((1-u)^(n-i))
end

//parametric
function p(u)
	local final_x = 0 
	local final_y = 0
	n = #p_x
	for i=1,n do
	 final_x += p_x[i]*bernstein((i-1),(n-1),u) 
	 final_y += p_y[i]*bernstein((i-1),(n-1),u)
	end
	out[1] = final_x
	out[2] = final_y
end	

//creating gridline
line(64,0,64,128,6)
line(0,64,128,64,6)
//creating ticks
//5
line(64+scl*5,64-2,64+scl*5,64+2,6)
//1
line(64+scl*2.5,64-1,64+scl*2.5,64+1,6)

//part where it draws da curve
for i=0,1,0.01 do
	p(i)
	pset(64+scl*out[1],64-scl*out[2],7)
end

//bounding box of points
for i=1,#p_x do
 if i<#p_x then
  line(64+scl*p_x[i],64-scl*p_y[i],64+scl*p_x[i+1],64-scl*p_y[i+1],14)
 //draws line from final to initial point
 else 
  line(64+scl*p_x[i],64-scl*p_y[i],64+scl*p_x[1],64-scl*p_y[1],14)
 end
 pset(64+scl*p_x[i],64-scl*p_y[i],8)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
