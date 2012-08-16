
Vector = {}
Vector.__index = Vector
Vector.__metatable = Vector

function Vector.new(x,y)
	local vec = {}
	setmetatable(vec,Vector)
	
	vec.x = x or 0
	vec.y = y or 0
	
	return vec
end

function Vector:toString()
	return "("..self.x..","..self.y..")"
end

function Vector:angleTo(vec)
	if getmetatable(op) ~= getmetatable(self) then error("Vector:angleTo - Argument provided is not a vector.", 2) end
	return math.atan2(vec.y - self.y, vec.x - self.x ) * (180/math.pi)
end

function Vector:distanceTo(vec)
	if getmetatable(op) ~= getmetatable(self) then error("Vector:distanceTo - Argument provided is not a vector.", 2) end
	return math.sqrt(((vec.x - self.x)^2) + ((vec.y - self.y)^2))
end

function Vector:length()
	return math.sqrt((self.x * self.x) + (self.y * self.y)) 
end

function Vector:normalize()
	local len = self:length()
	self.x = self.x / len
	self.y = self.y / len
end

function Vector:Dot(vec)
	return (self.x * vec.x) + (self.y * vec.y) 
end

function Vector:Cross(vec)
	return (self.x * vec.y) - (self.y * vec.x) 
end

-- Operators

function Vector:__add(op)
	if getmetatable(op) ~= getmetatable(self) then error("Attempt to add vector with non-vector value.", 2) end
	return Vector.new(self.x + op.x,self.y + op.y)
end

function Vector:__sub(op)
	if getmetatable(op) ~= getmetatable(self) then error("Attempt to subtract vector with non-vector value.", 2) end
	return Vector.new(self.x - op.x,self.y - op.y)
end

function Vector:__mul(op)
	if getmetatable(op) == getmetatable(self) then error("Must multiply vector by scalar value.", 2) end
	return Vector.new(self.x * op,self.y * op)
end

function Vector:__eq(op)
	if getmetatable(op) ~= getmetatable(self) then error("Attempt to compare vector with non-vector.", 2) end
	return (self.x == op.x) and (self.y == op.y)
end

