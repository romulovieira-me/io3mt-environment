-- Creating the library
local ginga_mic = pd.Class:new():register("ginga_mic")
-- Setting mic pipe variable
local pipe_mic

-- Function that creates object in Pure Data
function ginga_mic:initialize(sel, atoms)
   self.inlets = 1
   self.outlets = 1
   self.counter = 0
   
   -- Open mic pipe
   pipe_mic = io.open("/home/romulo/Área de Trabalho/pipe_mic", "a")
   
   return true
end

-- Sending value to mic pipe
local function sendFloat(num)
   pipe_mic:write(tostring(num) .. "\n")
   pipe_mic:flush()
end

-- Function that receives number in the inlet of the Pd object
function ginga_mic:in_1_float(num)
   sendFloat(num)
   pd.post(string.format("ginga_mic: got volume from mic %g", num))
end

-- Close the pipe when object is destroyed
function ginga_mic:destroy()
   pipe_mic:close()
end

