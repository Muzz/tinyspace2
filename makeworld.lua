

function makeworld ()--LEVEL SETUP, Object creation has to be moved to functions, and you need to make a level file, incase you ever want to add levels in the future.

Planet = world:addBody ( MOAIBox2DBody.KINEMATIC)

PlanetF = Planet:addCircle(0,0,1000)

PlanetF:setDensity ( 1 )
PlanetF:setFriction ( 1 )
PlanetF:setRestitution (0.1)
PlanetF:setFilter( 0x02 )
Planet:setAngularVelocity (0)
PlanetF:setFriction (10)

Satelite = world:addBody (MOAIBox2DBody.DYNAMIC)
SateliteF = Satelite:addRect (-10,-70,10,30)
Satelite:setTransform ( 0,1060,1)
Satelite:setFixedRotation (false)
SateliteF:setDensity ( 10 )
SateliteF:setFriction ( 1 )
SateliteF:setRestitution (0.05)
SateliteF:setFilter( 0x01 )
Satelite:resetMassData ()
Satelite:setMassData (20)
Satelite:setAngularVelocity (0)

sattex = MOAIGfxQuad2D.new()
sattex:setTexture ('moai.png')
sattex:setRect (-10,-5,10,5)

pltex = MOAIGfxQuad2D.new()
pltex:setTexture ('planet.png')
pltex:setRect (-847*2,-847*2,847*2,847*2)

boxbody = world:addBody (MOAIBox2DBody.DYNAMIC)
boxfix = boxbody:addRect (-30,-20,30,20)
boxbody:setTransform ( 2500,0)
boxbody:applyLinearImpulse (-250,1600)
boxbody:setFixedRotation (false)
boxfix:setDensity ( 1 )
boxfix:setFriction ( 1 )
boxfix:setRestitution (0.1)
boxfix:setFilter( 0x01 )
boxbody:resetMassData ()
boxbody:setMassData (30)

boxbodya = world:addBody (MOAIBox2DBody.DYNAMIC)
boxfixa = boxbodya:addRect (-30,-20,30,20)
boxbodya:setTransform ( -2500,0)
boxbodya:applyLinearImpulse (250,-1600)
boxbodya:setFixedRotation (false)
boxfixa:setDensity ( 1 )
boxfixa:setFriction ( 1 )
boxfixa:setRestitution (0.1)
boxfixa:setFilter( 0x01 )
boxbodya:resetMassData ()
boxbodya:setMassData (30)

boxbodyc = world:addBody (MOAIBox2DBody.DYNAMIC)
boxfixc = boxbodyc:addRect (-30,-20,30,20)
boxbodyc:setTransform ( 0,-2500)
boxbodyc:applyLinearImpulse (1600,-250)
boxbodyc:setFixedRotation (false)
boxfixc:setDensity ( 1 )
boxfixc:setFriction ( 1 )
boxfixc:setRestitution (0.1)
boxfixc:setFilter( 0x01 )
boxbodyc:resetMassData ()
boxbodyc:setMassData (30)

boxbodyb = world:addBody (MOAIBox2DBody.DYNAMIC)
boxfixb = boxbodyb:addRect (-30,-20,30,20)
boxbodyb:setTransform ( 0,2500)
boxbodyb:applyLinearImpulse (-1600,250)
boxbodyb:setFixedRotation (false)
boxfixb:setDensity ( 1 )
boxfixb:setFriction ( 1 )
boxfixb:setRestitution (0.1)
boxfixb:setFilter( 0x01 )
boxbodyb:resetMassData ()
boxbodyb:setMassData (30)


--PROPS

SateliteProp = MOAIProp2D.new ()
SateliteProp:setDeck(sattex)
SateliteProp:setParent(Satelite)
world_layer:insertProp (SateliteProp)


BoxProp = MOAIProp2D.new ()
BoxProp:setDeck(sattex)
BoxProp:setParent(boxbodya)
world_layer:insertProp (BoxProp)

BoxPropa = MOAIProp2D.new ()
BoxPropa:setDeck(sattex)
BoxPropa:setParent(boxbodya)
world_layer:insertProp (BoxPropa)

PlanetProp = MOAIProp2D.new ()
PlanetProp:setDeck(pltex)
PlanetProp:setParent(Planet)
world_layer:insertProp (PlanetProp)


debugbox = MOAIGfxQuad2D.new()
debugbox:setTexture ('moai.png')
debugbox:setRect (-30,-5,5,5)


debugProp = MOAIProp2D.new()
debugProp:setDeck(debugbox)
world_layer:insertProp (debugProp)



-- camera stuff

Fitter = MOAICameraFitter2D.new()
Fitter:setViewport (world_viewport)
Fitter:setCamera (world_camera)
Fitter:setBounds (-100000,-100000,100000,100000)
Fitter:setMin (256)
Fitter:setDamper(0.5)
Fitter:start ()

anchor = MOAICameraAnchor2D.new ()
anchor:setParent (SateliteProp)
anchor:setRect (-256,-256,256,256)

anchorbox = MOAICameraAnchor2D.new ()
anchorbox:setParent (BoxProp)
anchorbox:setRect (-256,-256,256,256)

anchorboxa = MOAICameraAnchor2D.new ()
anchorboxa:setParent (BoxPropa)
anchorboxa:setRect (-256,-256,256,256)

panchor = MOAICameraAnchor2D.new ()
panchor:setParent (PlanetProp)
panchor:setRect (2000,2000,-2000,2000) 

end
