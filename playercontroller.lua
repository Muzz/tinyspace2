

--units is how many world units to offset, 
--and origx and orig y are the location of the body.  direction is the direction vectors of the object



function vectorOffset (origx, origy, angle, offsetangle, units)
	angle = angle + offsetangle
	rad = math.rad (angle)
	vectorx = math.cos (rad)
	vectory = math.sin (rad)
	newPosx = vectorx * units
	newPosy = vectory * units
	newPosx = origx + newPosx
	newPosy = origy + newPosy
	return newPosx, newPosy
end

function vectorDegreesAdd (angle,degreestoadd)
	outputangle = angle + degreestoadd
	debugProp:setRot (outputangle)
	return outputangle
end


function thrustControl (body)

	--works 
	--[[
	bodyAngle = body:getAngle ()
	bodyRad = math.rad (bodyAngle)
	satVecy =   math.sin (bodyRad)
	satVecx =	math.cos (bodyRad)
	Bodyx,Bodyy = body:getPosition ()
	--]]


	
	--correct
	bodyAngle = body:getAngle ()
	bodyRad = math.rad (bodyAngle)
	satVecy =   math.cos (bodyRad)
	satVecx =	math.sin (bodyRad)
	Bodyx,Bodyy = body:getPosition ()

	PlVec = Vector.new(math.sin (bodyRad),math.cos (bodyRad))

	
	if istouching == true then

		newposxup, newposyup  = vectorOffset (Bodyx,Bodyy, bodyAngle, -90, 50)

	body:applyForce (satVecx *-18000, satVecy *18000, newposxup, newposyup)

	debugProp:setLoc (newposxup,newposyup)
	--
		if mouseX >50  then


			outputangleright = vectorDegreesAdd(bodyAngle, 90)
			radsright = math.rad (outputangleright)
			newvecxright = math.cos (radsright)
			newvecyright = math.sin (radsright)

			debugangle = math.atan2 (newvecyright,newvecxright)
			

			newposxright, newposyright  = vectorOffset (Bodyx,Bodyy, bodyAngle, -45, 100)


			body:applyForce (newvecxright*500, newvecyright*500,newposxright,newposyright)

			--debugProp:setLoc (newposxright,newposyright)
			
			elseif mouseX <-50 then


			outputangleleft = vectorDegreesAdd(bodyAngle, 90)
			radsleft = math.rad (outputangleleft)
			newvecxleft = math.cos (radsleft)
			newvecyleft = math.sin (radsleft)
		

			newposxleft, newposyleft  = vectorOffset (Bodyx,Bodyy, bodyAngle, -135, 100)

			--debugProp:setLoc (newposxleft,newposyleft)

			body:applyForce (newvecxleft*500, newvecyleft*500,newposxleft,newposyleft)

		end
	end
end