--[[
 
Practical implementation code for Io3MT
GNU General Public License v3

]]

-- code that receives messages from Pure Data
function getLastValueFromPipe()

    -- open pipe 
    local pipeguitar = io.open("/home/Desktop/pipe_guitar", "r")

    -- checks if the pipe was opened successfully
  if not pipeguitar then
    print("Falha ao abrir o pipe.")
    return nil
  end

  local lastValue = nil --variable to store the last value read

  -- read lines from the pipe and update the last value
  while true do
    local line = pipeguitar:read("*l")
    if not line then
      break
    end
    lastValue = tonumber(line)
  end

   -- close the pipe
   pipeguitar:close()

   return lastValue
 end

 -- Function to get the last value of the pipe
local lastValue = getLastValueFromPipe()

-- Verifica se o valor foi obtido e imprime
if lastValue then
  print("Last value received from GuitarPD:", lastValue)
else
  print("Could not get the last value from the pipe.")
end

-- variable that will be used to change the Microphone volume in each of the scenes
reverbGuitar = lastValue


-- declaring variable that will be used to change the light intensity
Intensidade = nil


-- events that allow communication between NCLUA objects and external entities
evt = {
    class = 'ncl',
    type = 'presentation', 
    action = 'start',
}

evt = {
    class = 'ncl',
    type = 'presentation',
    action = 'stop',
}

evt = {
    class = 'ncl',
    type = 'presentation',
    action = 'pause',
}

evt = {
    class = 'ncl',
    type = 'presentation',
    action = 'resume',
}

-- starting event handler

-- creating actions for the Guitar Player
function handler(evt)
    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'start' then
        
       start = AbreGuitarPD()
    end
    
    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'stop' then
        
       start = FechaGuitarPD() 
    end 

    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'pause' then
        
       start = PauseGuitarPD() 
    end 

    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'resume' then
        
       start = ResumeGuitarPD() 
    end 

  -- ************************ changing properties on light effect for scene 1 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityScent' then 

        Intensidade = 100

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityScent', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

  -- ************************ changing properties on light effect for scene 2 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityScent' then 

        Intensidade = 80

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityScent', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

  -- ************************ changing properties on light effect for scene 3 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityScent' then 

        Intensidade = 50

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityScent', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

   -- ************************ changing properties on light effect for scene 4 ************************
   if evt.class ~= 'ncl' and
   evt.type ~= 'attribution' and
   evt.property ~= 'intensityScent' then 

      Intensidade = 100

      event.register(nclHandler)

    evt.post {
        class = 'ncl',
        type = 'attribution',
        property = 'intensityScent', 
        action = 'start'
    }
    
    IntensidadeEvt.value = Intensidade
    IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

end

    -- ************************ changing properties on light effect for scene 1 ************************
    event.post {
      class = 'ncl',
      type = 'attribution',
      label = 'reverbGuitar1',
      action = 'start',
      value = reverbGuitar,
  }

    -- passando valor númérico para variável  
    local function setVolume ()
        
        os.execute("echo '" .. reverbGuitar .. "' | nc -u localhost 1351 &")
    end

    -- Lidando com atribuição no NCL
    local function nclHandler (evt)
        if evt.class ~= 'ncl' then return end
    
        if evt.type == 'attribution' then
            if evt.name == 'reverbGuitar' then
                setVolume()
            end
        end
    end
    event.register(nclHandler)

    if evt.class ~= 'ncl' and
       evt.type ~= 'attribution' and
       evt.property ~= 'reverbGuitar' then

        evt.post {
            class = 'ncl',
            type = 'attribution',
            property = 'reverbGuitar',
            action = 'start'
        }
        
        VolumeEvt.value = reverbGuitar1
        VolumeEvt.action = 'start'; evt.post(VolumeEvt)

    end

end

-- PLayer functions
function OpenGuitarPD ()
    
    local patchPath1 = "/home/Tarefa/loudspeakerguitar.pd"

    local cmd1 = "pd " .. patchPath1 .. " &"

    os.execute(cmd1)
end

-- Função que encerra player do Microfone Pure Data
function CloseGuitarPD()
    local patchPath1 =  "/home/Tarefa/loudspeakermic.pd"
    
    
    os.execute("pkill -f '" .. patchPath1 .. "'")
    
end

function PauseGuitarPD()
    local message_pause_audio1 = "0;"
    os.execute("echo '" .. message_pause_audio1 .. "' | pdsend 12351 ")

end

function ResumeGuitarPD()
    local message_resume_audio1 = "1;"
    os.execute("echo '" .. message_resume_audio1 .. "' | pdsend 12451")

end


event.register(handler)