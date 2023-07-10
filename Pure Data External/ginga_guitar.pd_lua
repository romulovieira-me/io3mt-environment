-- Creating the library
local ginga_guitar = pd.Class:new():register("ginga_guitar")
-- Definindo variável do pipe da guitarra
local pipe_guitar

-- Function that creates object in Pure Data
function ginga_guitar:initialize(sel, atoms)
   self.inlets = 1
   self.outlets = 1
   self.counter = 0
   
   -- Open Pipe
   pipe_guitar = io.open("/home/romulo/Área de Trabalho/pipe_guitar", "a")
   
   return true
end

-- Sending value to guitar pipe
local function sendFloat(num)
   pipe_guitar:write(tostring(num) .. "\n")
   pipe_guitar:flush()
end

-- Function that receives number in the inlet of the Pd object
function ginga_guitar:in_1_float(num)
   sendFloat(num)
   pd.post(string.format("ginga_guitar: got volume from guitar %g", num))
end

-- Close the pipe when object is destroyed
function ginga_guitar:destroy()
   pipe_guitar:close()
end

