


---------GUI Input
-- global key-reading functions for the app
-- the purpose of these handlers are to gain a formatted text
-- string from the host soft keyboard.  the native edittext
-- field is used as appropriate for the platform, to benefit
-- from the platform-specific input mechanics - i.e. we only
-- care about the input as a done, formatted, edited string.
-- the last input string is always available as last_text_entered
-- if a layout requires string input, its edit_input_handler is
-- called after string input by the user, to process the 
-- string event.  in this handler, last_text_entered must be
-- the only means by which a layout gains access to the user
-- input text (i.e. no layouts should do key input directly)
function onSoftKeyInput ( start, length, text )
  print ( 'on softkeyinput start: ', start, 'length:', length, 'text:', text )
  
  if MOAIKeyboardIOS then
    last_text_entered = MOAIKeyboardIOS.getText ()
  end

  if MOAIKeyboardAndroid then
    if string.find(text, "\n") == nil then
      last_text_entered = MOAIKeyboardAndroid.getText ()
    else
      print("got return. Leaving onSoftKeyInput and continue at onSoftKeyReturn")
      onSoftKeyReturn()
      return      
    end 
  end

  print ( "text input from host keyboard callback is : [", last_text_entered, "]")

  -- call the handler as specified by the layout
  if (editbox_input_handler ~= nil) then
    editbox_input_handler(start, length, last_text_entered)
  end

end

-- the user has pressed return in a soft input field
function onSoftKeyReturn ()
  print ( 'on softkeyreturn' )
  if MOAIKeyboardIOS then
    last_text_entered = MOAIKeyboardIOS.getText ()
  elseif MOAIKeyboardAndroid then
    last_text_entered = MOAIKeyboardAndroid.getText ()
    MOAIKeyboardAndroid.setText("")
  end

  -- signal that keyboard has closed
  local ret = true
  if (editbox_return_handler ~= nil) then
    ret = editbox_return_handler()
  end

  last_text_entered = "" -- clear it for future use

  -- handler supports returning a bool value 
  -- which decideds if keyboard gets destroyed
  if ret == false then
    keyboardIsPopped = true
    --print("onSoftKeyRetrun returns false")
  else
    if MOAIKeyboardAndroid then
      MOAIKeyboardAndroid.hideKeyboard()
    end
    keyboardIsPopped = false
    --print("onSoftKeyRetrun returns true")
  end


  return ret
end


-- Local MOAI Event Handlers
function onKeyboardEvent(key, down)
  --print("Key received: ", key, " down: ", down)
  if (down == true) then
    g:injectKeyDown(key)
  else
    g:injectKeyUp(key)
    if (shouldDoKeyHack) then
      screen_requested = screen_requested + 1    
      screen_changing = true
    end
  end
end

function onPointerEvent(x, y)
  g:injectMouseMove(x, y)

    local oldX = mouseX
  local oldY = mouseY
  
  mouseX, mouseY = world_layer:worldToModel ( x, y )
  mouseX = mouseX - screenWidthX/2
  if pick then
    pick:addLoc ( mouseX - oldX, mouseY - oldY )
  end

end

function onMouseLeftEvent(down)
  if (down) then
    g:injectMouseButtonDown(inputconstants.LEFT_MOUSE_BUTTON)
    istouching = down
  else
    g:injectMouseButtonUp(inputconstants.LEFT_MOUSE_BUTTON)
    istouching = up
  end
end

function onMouseMiddleEvent(down)
  if (down) then
    g:injectMouseButtonDown(inputconstants.MIDDLE_MOUSE_BUTTON)
  else
    g:injectMouseButtonUp(inputconstants.MIDDLE_MOUSE_BUTTON)
  end
end

function onMouseRightEvent(down)
  if (down) then
    g:injectMouseButtonDown(inputconstants.RIGHT_MOUSE_BUTTON)
  else
    g:injectMouseButtonUp(inputconstants.RIGHT_MOUSE_BUTTON)
  end
end





-- multiple platforms have different mechanics
-- i.e. single-touch keypad, keyboard-only,
-- multi-touch, mouse+keyboard, etc.
-- this function is to adapt each platform mechanic 
-- for the needs of the layouts
function setupUserInputs()
  -- Register the callbacks for input
  --MOAIInputMgr.device.pointer:setCallback(onPointerEvent)
  --MOAIInputMgr.device.mouseLeft:setCallback(onMouseLeftEvent)
  --MOAIInputMgr.device.mouseMiddle:setCallback(onMouseMiddleEvent)
  --MOAIInputMgr.device.mouseRight:setCallback(onMouseRightEvent)

  if MOAIKeyboardIOS then
    MOAIKeyboardIOS.setListener ( MOAIKeyboardIOS.EVENT_INPUT, onSoftKeyInput )
    MOAIKeyboardIOS.setListener ( MOAIKeyboardIOS.EVENT_RETURN, onSoftKeyReturn )
  end
  
  if MOAIKeyboardAndroid then
    --MOAIKeyboardAndroid.setListener ( MOAIKeyboardAndroid.ACTION_DOWN, onSoftKeyInput )
    MOAIKeyboardAndroid.setListener ( MOAIKeyboardAndroid.EVENT_INPUT, onSoftKeyInput )
    MOAIKeyboardAndroid.setListener ( MOAIKeyboardAndroid.EVENT_RETURN, onSoftKeyReturn )
  end

  if MOAIInputMgr.device.keyboard then
    MOAIInputMgr.device.keyboard:setCallback(onKeyboardEvent)
  end

  if MOAIInputMgr.device.pointer then
    -- mouse input
    MOAIInputMgr.device.pointer:setCallback (onPointerEvent)
    MOAIInputMgr.device.mouseLeft:setCallback (onMouseLeftEvent)
  else
    -- touch input
    MOAIInputMgr.device.touch:setCallback ( 

      function ( eventType, idx, x, y, tapCount )

        onPointerEvent( x, y )

        if (touch_handler~=nil) then
          touch_handler(eventType, x, y)
        end

        if eventType == MOAITouchSensor.TOUCH_DOWN then
          onMouseLeftEvent ( true )
        elseif eventType == MOAITouchSensor.TOUCH_UP then
          onMouseLeftEvent ( false )
        end
      end
      )
  end
end

setupUserInputs()




---OLD INPUT SHIT


--[[


-- callbacks for touch interface

function pointerCallback ( x, y )
  
  local oldX = mouseX
  local oldY = mouseY
  
  mouseX, mouseY = world_layer:worldToModel ( x, y )
  mouseX = mouseX - screenWidthX/2
  if pick then
    pick:addLoc ( mouseX - oldX, mouseY - oldY )
  end
end

function clickCallback (down)
    istouching = down
end

if MOAIInputMgr.device.pointer then
  
  -- mouse input
  MOAIInputMgr.device.pointer:setCallback ( pointerCallback )
  MOAIInputMgr.device.mouseLeft:setCallback ( clickCallback )
else

  -- touch input
  MOAIInputMgr.device.touch:setCallback ( 
  
    function ( eventType, idx, x, y, tapCount )

      pointerCallback ( x, y )    

      if eventType == MOAITouchSensor.TOUCH_DOWN then
        clickCallback (true)
      elseif eventType == MOAITouchSensor.TOUCH_UP then
        clickCallback (false)
      end
    end
  )
end
--]]