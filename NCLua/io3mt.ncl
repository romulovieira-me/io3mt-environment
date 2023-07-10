<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="aplTesteEffect">

<!-- Io3MT - Envrionment implementation -->

<head>

    <!-- Regions -->
    <regionBase>
        <region id="rgVideo" width="100%" height="100%" zIndex="0" />
        <region id="rgPD" width="50%" height="50%" zIndex="1" />
        <region id="rg2" location="center:top:front" />
        <region id="rg3" location="center:top:front" />
    </regionBase>

    <!-- Descriptors -->

    <!-- Video -->
    <descriptorBase>
        <descriptor  id="descVideoTrem"   region="rgVideo" />
        <descriptor  id="descVideoLafa"   region="rgVideo" />
        <descriptor  id="descVideoSJ"     region="rgVideo" />
        <descriptor  id="descVideoTiradentes" region="rgVideo" />
        <descriptor  id="descVideoOP"     region="rgVideo" />

        <!-- Sensorial effects descriptors -->

        <!-- Light descriptor -->
        <descriptor id="descLight" region="rg2" intensityValue="100" intensityRange="[0,100]" />

        <!-- Scent descriptor -->
        <descriptor id="descScent" region="rg3" intensityValue="100" intensityRange="[0,100]" />
           

    </descriptorBase>

    <!-- Connectors -->
    <connectorBase>

        <causalConnector id="onBeginStart">
            <simpleCondition role="onBegin" />
            <simpleAction role="start" max="unbounded" />
        </causalConnector>

        <causalConnector id="onBeginPause">
            <simpleCondition role="onBegin" />
            <simpleAction role="pause" max="unbounded" />
        </causalConnector>

        <causalConnector id="onEndStart">
            <simpleCondition role="onEnd" />
            <simpleAction role="start" max="unbounded"/>
        </causalConnector>    

        <causalConnector id="onEndStop">
            <simpleCondition role="onEnd" />
            <simpleAction role="stop" max="unbounded" />
        </causalConnector>

        <causalConnector id="onBeginSet">
            <connectorParam name="var" />
            <simpleCondition role="onBegin" />
            <simpleAction role="set" max="unbounded" value="$var" />
        </causalConnector> 

    </connectorBase>

</head>

<body>

    <!-- Entry port -->
    <port id="entryPoint" component="videoTrem" />

    <!-- Medias -->

    <!-- Light effect -->
    <effect id="lightEffect" type="LightType" descriptor="descLight">
        <property name="color" value="green" />
        <property name="intensityLight" />
    </effect>

    <!-- Scent effect -->
    <effect id="scentEffect" type="ScentType" descriptor="descScent">
        <property name="scent" value="urn:mpeg:mpeg-v:01-SI-ScentCS-NS:floral_magic" />
        <property name="intensityScent" />
    </effect>

    <!-- Audios -->
    <media id="audioTrem1" src="media/trem1.mp3" />
    <media id="audioTrem2" src="media/trem2.wav" />
    <media id="audioTremAzul" src="media/tremazul.wav" />
    <media id="audioSino" src="media/sino.wav" />
    <media id="audioCredo" src="media/credo.ogg" />

    <!-- Videos -->
    <media id="videoTrem" src="media/tremnosound.mp4" descriptor="descVideoTrem"/>
    <media id="videoLafa" src="media/lafa.mp4" descriptor="descVideoLafa"/>
    <media id="videoSJ" src="media/sjdr.avi" descriptor="descVideoSJ"/>
    <media id="videoTiradentes" src="media/tiradentes.mp4" descriptor="descVideoTiradentes"/>
    <media id="videoOP" src="media/ouropreto.mp4" descriptor="descVideoOP"/>

    <!-- Lua files -->
    <media id="MicPD" src="media/mic.lua" >
        <property name="volumeMic"/>
	</media> 

     <media id="GuitarPD" src="media/guitar.lua" >
        <property name="reverbGuitar"/>
	</media> 

    

    <!-- Links between medias -->
    <link xconnector="onBeginStart" />
        <bind role="onBegin" component="videoTrem" />
        <bind role="start" component="audioTrem1" />
        <bind role="start" component="lightEffect" />
        <bind role="start" component="scentEffect" />
    </link>

    <link xconnector="onEndStart">
        <bind role="onEnd" component="videoTrem" />
        <bind role="start" component="audioSino" />
        <bind role="start" component="MicPD" />
        <bind role="start" component="GuitarPD" />
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="audioSino" />
        <bind role="set" component="LightEffect" interface="color" >
        <bindParam name="var" value="white" />
        </bind>
    </link>

    <link xconnector="onEndStart">
        <bind role="onEnd" component="audioSino" />
        <bind role="start" component="audioTremAzul" />
        <bind role="start" component="videoLafa" />
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoLafa" />
        <bind role="set" component="LightEffect" interface="color" >
        <bindParam name="var" value="blue" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoLafa" />
        <bind role="set" component="LightEffect" interface="intensityLight" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoLafa" />
        <bind role="set" component="scentEffect" interface="scent" >
        <bindParam name="var" value="urn:mpeg:mpeg-v:01-SI-ScentCS-NS:wood_royale" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoLafa" />
        <bind role="set" component="scentEffect" interface="intensityScent" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoLafa" />
		<bind role="set" component="MicPD" interface="volumeMic">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoLafa" />
		<bind role="set" component="GuitarPD" interface="reverbGuitar">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onEndStart">
        <bind role="onEnd" component="videoLafa" />
        <bind role="start" component="videoSJ" />
    </link>

     <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoSJ" />
        <bind role="set" component="LightEffect" interface="color" >
        <bindParam name="var" value="red" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoSJ" />
        <bind role="set" component="LightEffect" interface="intensityLight" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

     <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoSJ" />
        <bind role="set" component="scentEffect" interface="scent" >
        <bindParam name="var" value="urn:mpeg:mpeg-v:01-SI-ScentCS-NS:lavender" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoSJ" />
        <bind role="set" component="scentEffect" interface="intensityScent" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoSJ" />
		<bind role="set" component="MicPD" interface="volumeMic">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoSJ" />
		<bind role="set" component="GuitarPD" interface="reverbGuitar">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

     <link xconnector="onEndStart">
        <bind role="onEnd" component="videoSJ" />
        <bind role="start" component="videoTiradentes" />
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoTiradentes" />
        <bind role="set" component="LightEffect" interface="color" >
        <bindParam name="var" value="purple" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoTiradentes" />
        <bind role="set" component="LightEffect" interface="intensityLight" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

     <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoTiradentes" />
        <bind role="set" component="scentEffect" interface="scent" >
        <bindParam name="var" value="urn:mpeg:mpeg-v:01-SI-ScentCS-NS:floral_magic" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoTiradentes" />
        <bind role="set" component="scentEffect" interface="intensityScent" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoTiradentes" />
		<bind role="set" component="MicPD" interface="volumeMic">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoTiradentes" />
		<bind role="set" component="GuitarPD" interface="reverbGuitar">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onEndStart">
        <bind role="onEnd" component="videoTiradentes" />
        <bind role="start" component="videoOP" />
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoOP" />
        <bind role="set" component="LightEffect" interface="color" >
        <bindParam name="var" value="yellow" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoOP" />
        <bind role="set" component="LightEffect" interface="intensityLight" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

     <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoOP" />
        <bind role="set" component="scentEffect" interface="scent" >
        <bindParam name="var" value="urn:mpeg:mpeg-v:01-SI-ScentCS-NS:wood_royale" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
        <bind role="onBegin" component="videoOP" />
        <bind role="set" component="scentEffect" interface="intensityScent" >
        <bindParam name="var" value="$var" />
        </bind>
    </link>

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoOP" />
		<bind role="set" component="MicPD" interface="volumeMic">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onBeginSet">
		<bind role="onBegin" component="videoOP" />
		<bind role="set" component="GuitarPD" interface="reverbGuitar">
		<bindParam name="var" value="$var" />
		</bind>
	</link> 

    <link xconnector="onEndStop">
        <bind role="onEnd" component="videoOP" />
        <bind role="stop" component="MicPD" />
        <bind role="stop" component="GuitarPD" />
        <bind role="stop" component="audioTremAzul" />
    </link>

    <link xconnector="onEndStart">
			<bind role="onEnd" component="videoOP"  />
			<bind role="start" component="audioTrem2" />
            <bind role="start" component="audioCredo" />
	</link>

    <link xconnector="onEndStop">
        <bind role="onEnd" component="audioCredo" />
        <bind role="stop" component="audioTrem2" />
    </link>

</body>

</ncl>

