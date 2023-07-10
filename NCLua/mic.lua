--[[
 
Practical implementation code for Io3MT
GNU General Public License v3

]]

-- code that receives messages from Pure Data
function getLastValueFromPipe()

    -- open pipe 
    local pipemic = io.open("/home/Desktop/pipe_mic", "r")

    -- checks if the pipe was opened successfully
  if not pipemic then
    print("Failed to open the pipe.")
    return nil
  end

  local lastValue = nil --variable to store the last value read

  -- read lines from the pipe and update the last value
  while true do
    local line = pipemic:read("*l")
    if not line then
      break
    end
    lastValue = tonumber(line)
  end

   -- close the pipe
   pipemic:close()

   return lastValue
 end

 -- Function to get the last value of the pipe
local lastValue = getLastValueFromPipe()

-- Checks if the value was obtained and prints
if lastValue then
  print("Last value received from MicPD:", lastValue)
else
  print("Could not get the last value from the pipe.")
end

-- variable that will be used to change the Microphone volume in each of the scenes
volumeMic = lastValue

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

-- creating actions for the Microphone Player
function handler(evt)
    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'start' then
        
       start = OpenMicPD()
    end
    
    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'stop' then
        
       start = CloseMicPD() 
    end 

    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'pause' then
        
       start = PauseMicPD() 
    end 

    if evt.class == 'ncl' and
       evt.type == 'presentation' and 
       evt.action == 'resume' then
        
       start = ResumeMicPD() 
    end 

  -- ************************ changing properties on light effect for scene 1 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityLight' then 

        Intensidade = 20

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityLight1', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

  -- ************************ Changing properties on light effect for scene 2 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityLight' then 

        Intensidade = 80

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityLight', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

  -- ************************ Changing properties on light effect for scene 1 3 ************************
  if evt.class ~= 'ncl' and
     evt.type ~= 'attribution' and
     evt.property ~= 'intensityLight' then 

        Intensidade = 50

        event.register(nclHandler)

      evt.post {
          class = 'ncl',
          type = 'attribution',
          property = 'intensityLight', 
          action = 'start'
      }
      
      IntensidadeEvt.value = Intensidade
      IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

  end

   -- ************************ Changing properties on light effect for scene 4 ************************
   if evt.class ~= 'ncl' and
   evt.type ~= 'attribution' and
   evt.property ~= 'intensityLight' then 

      Intensidade = 100

      event.register(nclHandler)

    evt.post {
        class = 'ncl',
        type = 'attribution',
        property = 'intensityLight', 
        action = 'start'
    }
    
    IntensidadeEvt.value = Intensidade
    IntensidadeEvt.action = 'start'; evt.post(IntensidadeEvt)

end

    -- ************************ Setting Microphone value for Scene 1 ************************
    event.post {
      class = 'ncl',
      type = 'attribution',
      label = 'volumeMic',
      action = 'start',
      value = volumeMic,
  }

    -- passando valor númérico para variável  
    local function setVolume ()
        
        os.execute("echo '" .. volumeMic .. "' | nc -u localhost 1350 &")
    end

    -- Lidando com atribuição no NCL
    local function nclHandler (evt)
        if evt.class ~= 'ncl' then return end
    
        if evt.type == 'attribution' then
            if evt.name == 'volumeMic' then
                setVolume()
            end
        end
    end
    event.register(nclHandler)

    if evt.class ~= 'ncl' and
       evt.type ~= 'attribution' and
       evt.property ~= 'volumeMic' then

        evt.post {
            class = 'ncl',
            type = 'attribution',
            property = 'volumeMic',
            action = 'start'
        }
        
        VolumeEvt.value = volumeMic
        VolumeEvt.action = 'start'; evt.post(VolumeEvt)

    end

end

-- Criando funções para o Player
function OpenMicPD ()
    -- Caminho para o arquivo Pure Data
    local patchPath1 = "/home/Desktop/Tarefa/loudspeakermic.pd"

    -- Comando para executar o arquivo
    local cmd1 = "pd " .. patchPath1 .. " &"

    -- Executa o comando para abrir o arquivo PD
    os.execute(cmd1)
end

-- Função que encerra player do Microfone Pure Data
function CloseMicPD()
    local patchPath1 =  "/home/Desktop/Tarefa/loudspeakermic.pd"
    
    --Encerra o processo do Pure Data correspondente a cada arquivo
    os.execute("pkill -f '" .. patchPath1 .. "'")
    
end

function PauseMicPD()
    local message_pause_audio1 = "0;"
    os.execute("echo '" .. message_pause_audio1 .. "' | pdsend 12350 ")

end

function ResumeMicPD()
    local message_resume_audio1 = "1;"
    os.execute("echo '" .. message_resume_audio1 .. "' | pdsend 12450")

end


event.register(handler)