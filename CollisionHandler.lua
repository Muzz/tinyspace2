--collision handler

function onCollide (event, fixtureA, fixtureB, arbiter)

	if event == MOAIBox2DArbiter.BEGIN then
	end

	if event == MOAIBox2DArbiter.END then
		print( fixtureA.userdata.."collided with " .. fixtureB.userdata)
		if fixtureA.userdata and fixtureB.userdata then
			if fixtureA.userdata==-1 and fixtureB.userdata>3 then

				--world:setGravity ( 0, gravity)
				Ball:applyLinearImpulse (0, impulse)

			end
			if fixtureA.userdata==-1 and fixtureB.userdata>4 then

				--world:setGravity ( 0, gravity)
				Ball:applyLinearImpulse (0, impulse * -1)

			end
		end
	end

	if event == MOAIBox2DArbiter.PRE_SOLVE then
	end

	if event == MOAIBox2DArbiter.POST_SOLVE then
	end
end



