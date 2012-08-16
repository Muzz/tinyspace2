function radialGravity (body, debugOn, CameraTarget,bodyanchor)

	-- gravity depreciates over distance, need to find distance from the body and depreciate it over a square.

	--vectors? of objects


	BodyAX,BodyAY = Planet:getPosition ()
	BodyBX,BodyBY = body:getPosition ()

	--BodyAVec = Vector.new(BodyAX,BodyAY)
	--BodyBVec = Vector.new(BodyBX,BodyBY)
	--distance from body in deltas
	deltaY = BodyAY - BodyBY
	deltaX = BodyAX - BodyBX
	--print ("ze vector for you muz"..BodyBVec:toString())

	--Distance = BodyBVec:distanceTo(BodyAVec)

	--gravity strangth with distance in mind, gives the distance as a percentage pythagoras
	Distance = math.sqrt ( math.pow (deltaY, 2) + math.pow (deltaX, 2))

	-- how much influence the planet has in world units does affect gravity strength, so for every time you double it halve the gravity
	planGrav = 16000

	--turn the distance to a percentage of gravity applied
	percent = (1 / planGrav * Distance)
	percent = 1-( math.min (1 , math.max (0,percent)) )

	--how strong the gravity is
	GravForce = 4

	--only apply gravity if percent is greater than 0
	if percent > 0 then
	body:applyForce (deltaX*(math.pow(GravForce,2)*percent),deltaY*(math.pow(GravForce,2)*percent))
	end

	BodyVX,BodyVY = body:getLinearVelocity ()
	BodyRot = body:getAngularVelocity ()



	-- wind resistance, plan resist is how far the atmosphere stretches out in world units.

	planResist = 2000 
	Airdensity = 0.01
	resistanceAMper = (1 / planResist * Distance)
	resistanceAMper = 1-( math.min (1 , math.max (0,resistanceAMper)) )
	resistanceAM = 1-(resistanceAMper * Airdensity)
	resistanceAM = math.min (1,resistanceAM)
	resistanceAM = math.pow (resistanceAM,2)
	resistancex = BodyVX * resistanceAM
	resistancey = BodyVY * resistanceAM
	resistancerot = BodyRot * resistanceAM
	body:setAngularVelocity (resistancerot)
	body:setLinearVelocity (resistancex, resistancey)
	

	angleBtwPB = math.deg (math.atan2 (deltaX,deltaY) )



	-- sets if you are viewing the object. Only one object should have this on at a time
	if CameraTarget == true then
		Fitter:insertAnchor (bodyanchor)

		--this is just so i can have the camera zoomed out enough
		if percent > .87 then
		--if percent > .99 then
			--Camera:setRot((angleBtwPB*-1)+180)
			Fitter:removeAnchor(panchor)
		else 
			world_camera:setRot(0)
			Fitter:insertAnchor(panchor)
		end
	end

	--print the debug stuff for the object if it is set to true
	if debugOn == true then
		print (percent,resistanceAM)

	end

end