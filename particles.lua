
--[[
-- particle systems
function debugParticles (deltax,deltay,pX,pY,pTexture)
debugPSystem = MOAIParticleSystem.new ()
debugPSystem:reserveParticles (256,6)
debugPSystem:reserveSprites (256)
debugPSystem:reserveStates (1)
debugPSystem:setDeck (debugptexture)
debugPSystem:start()

debugEmitter = MOAIParticleDistanceEmitter.new()

CONST = MOAIParticleScript.packConst
local PARTICLE_

end
--]]
-- render particles from new texture

        function particles_smoke(ax,ay,pX,pY,pTexture)

 				angle = math.atan2 (ay,ax)
 				angle = math.deg (angle)
 				--print(angle)
                CONST = MOAIParticleScript.packConst
                local PARTICLE_X1 = MOAIParticleScript.packReg(1)
                local PARTICLE_Y1 = MOAIParticleScript.packReg(2)
                local PARTICLE_R0 = MOAIParticleScript.packReg(3)
                local PARTICLE_R1 = MOAIParticleScript.packReg(4)
                local PARTICLE_S0 = MOAIParticleScript.packReg(5)
                local PARTICLE_S1 = MOAIParticleScript.packReg(6)
 
                system2 = MOAIParticleSystem.new()
                system2:reserveParticles(256, 2)
                system2:reserveSprites(256)
                system2:reserveStates(1)
                system2:setDeck(pTexture)
                system2:start()

                emitter2 = MOAIParticleDistanceEmitter.new()
                emitter2:setLoc(pX, pY)
                emitter2:setSystem(system2)
                emitter2:setMagnitude(0.125)
                emitter2:setAngle(angle, angle)
                emitter2:start()
 
                state1 = MOAIParticleState.new()
                state1:setTerm(0, 1.25)
                layer:insertProp(system2)

                --world_partition:insertProp(system2) 

                local init = MOAIParticleScript.new()
                init:rand( PARTICLE_X1, CONST(pX+2), CONST(pX-2))
                init:rand( PARTICLE_Y1, CONST(pY+2), CONST(pY-2))
                init:rand( PARTICLE_S0, CONST(pX), CONST(pX))
                init:rand( PARTICLE_S1, CONST(pY), CONST(pY))

                local render = MOAIParticleScript.new()
                render:ease( MOAIParticleScript.PARTICLE_X, MOAIParticleScript.PARTICLE_DX, PARTICLE_X1, MOAIEaseType.LINEAR)
                render:ease( MOAIParticleScript.PARTICLE_Y, MOAIParticleScript.PARTICLE_DY, PARTICLE_Y1, MOAIEaseType.LINEAR) 

                render:sprite()
                render:ease( MOAIParticleScript.SPRITE_X_SCL, CONST(0.1), CONST(1),MOAIEaseType.EASE_IN)
                --render:rand(MOAIParticleScript.SPRITE_X_SCL, CONST(0), CONST(0.5))
                --render:rand(MOAIParticleScript.SPRITE_Y_SCL, CONST(0), CONST(1))
                render:ease(MOAIParticleScript.SPRITE_Y_SCL, CONST(0.1), CONST(1),MOAIEaseType.EASE_IN)
                render:ease(MOAIParticleScript.SPRITE_OPACITY, CONST(1), CONST(0.6),MOAIEaseType.EASE_IN)
                --render:rand(MOAIParticleScript.SPRITE_ROT, CONST(-180), CONST(180)) 

                state1:setInitScript(init)
                state1:setRenderScript(render)
                system2:setState(1, state1) 

                system2:surge(16,pX,pY,pX,pY)

        end