using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.UserProfile as UserProfile;
using Toybox.Math;

class noresourcesView extends Ui.DataField {
    hidden var avgSpeedStr, hrStr, maxSpeedStr, cadenciaStr, distStr, duration,time;
	hidden var velocidadms = 0;
	hidden var velocidadkmh = 0;
	hidden var avgSpeed = 0;
	hidden var avgPWR = 0;
	hidden var maxPWR = 0;
	hidden var distance = 0;
	hidden var velocidad = 0;
	hidden var distancia = 0;
	hidden var potencia = 0;
	hidden var elapsedTime = 0;
	hidden var inclina = 0;
	hidden var tempe = 0;
	hidden var maxSpeed = 0;
	hidden var cadencias = 0;
	hidden var hr = 0;
	hidden const ZERO_TIME = "0:00";
	hidden const ZERO_DISTANCE = "0.00";
	// km or millas
	hidden var kmOrMileInMeters = 1000;
	hidden var distanceUnits = System.UNIT_METRIC;
	hidden var mHRZones = [100, 121, 134, 147, 161, 174];
	hidden var PWRZones = [49,108,147,177,206,237,296];
	hidden var HRColor = [Gfx.COLOR_WHITE,Gfx.COLOR_LT_GRAY,Gfx.COLOR_BLUE,Gfx.COLOR_DK_GREEN,Gfx.COLOR_YELLOW,Gfx.COLOR_RED];
	hidden var PWRColor = [Gfx.COLOR_WHITE,Gfx.COLOR_LT_GRAY,Gfx.COLOR_BLUE,Gfx.COLOR_DK_GREEN,Gfx.COLOR_YELLOW, Gfx.COLOR_ORANGE, Gfx.COLOR_RED,Gfx.COLOR_PURPLE ];
	hidden var SPDcoor = [30,30];
	hidden var FTP = 217;
	hidden var SpeedEndX = 0;
	hidden var SpeedEndY= 0;
	hidden var SpeedStartX =0;
	hidden var SpeedStartY =0;
	hidden var cadStartX = 0;
	hidden var cadStartY = 0;
	hidden var cadEndX = 0;
	hidden var cadEndY = 0;	
	hidden var SpeedEndXS = [7,4,4,4,4,4,4,1,0,0,1,3,6,10,16,22,29,37,45,55,65,75,86,97,108,120,132,143,154,165,175,185,195,203,211,218,224,230,234,237,239,240,240,239,236,233];
	hidden var SpeedEndYS=[161,150,150,150,150,150,150,139,127,116,104,93,82,71,61,51,42,34,26,19,14,9,5,2,1,0,1,2,5,9,14,19,26,34,42,51,61,71,82,93,104,116,127,139,150,161];
	hidden var MspdStartX = [35,33,33,33,33,33,33,31,30,30,31,32,35,38,42,46,52,57,64,71,78,86,94,103,111,120,129,137,146,154,162,169,176,183,188,194,198,202,205,208,209,210,210,209,207,205];
	hidden var MspdStarty= [151,143,143,143,143,143,143,134,125,117,108,100,91,83,76,68,62,55,50,45,40,37,34,32,30,30,30,32,34,37,40,45,50,55,62,68,76,83,91,100,108,117,125,134,143,151];
	hidden var hrstartx = 0;
	hidden var PWRstartx = 0;
	hidden var hrendx = 0;
	hidden var PWRendx = 0;
	hidden var hrstarty = 0;
	hidden var PWRstarty = 0;
	hidden var PWRendy = 0;
	hidden var hrendy = 0;
	hidden var RoundSpeed = 0;
	hidden var RoundMSpeed = 0;
	hidden var RoundASpeed = 0;
	hidden var RoundCad = 0;
	hidden var speedkmh = 0;
	hidden var CY = 0;
	hidden var CX = 0;
	hidden var cadX= 120;
	hidden var cadY= 135;
	hidden var cadrpm = 0;
	hidden var extspdcircle=0;
	hidden var intspdcircle=0;
	hidden var extrpmcircle = 0;
	hidden var intrpmcircle = 0;
	hidden var x10, x15, x20, x25, x30, x35, x40, y10, y15, y20, y25, y30, y35, y40, xz1, xzp1, xz2, xzp2, xz3, xzp3, xz4, xzp4, xz5, xzp5, xzp6, yz1, yzp1, yz2, yzp2, yz3, yzp3, yz4, yzp4, yz5, yzp5, xzp0, yzp0, yzp6;
	hidden var altura = 400;
    // Set the label of the data field here.
    
    function initialize() {
         DataField.initialize(); 
    }

    function compute(info) {
        avgSpeed = info.averageSpeed != null ? info.averageSpeed : 0;
        elapsedTime = info.elapsedTime !=null ? info.elapsedTime : 0;
        distance = info.elapsedDistance !=null ? info.elapsedDistance : 0;
        hr = info.currentHeartRate !=null ? info.currentHeartRate : 0;
        velocidadms = info.currentSpeed !=null ? info.currentSpeed : 0;
        maxSpeed = info.maxSpeed !=null ? info.maxSpeed : 0;
        cadencias = info.currentCadence !=null ? info.currentCadence : 0;
        potencia = info.currentPower !=null ? info.currentPower : 0;
        avgPWR = info.averagePower !=null ? info.averagePower : 0;
        maxPWR = info.maxPower !=null ? info.maxPower : 0;
        //tempe=  info.temperature !=null ? info.temperature : 0;
        
        velocidadkmh = 3600*velocidadms/kmOrMileInMeters;
        velocidad = 3600*velocidadms/1000;
        avgSpeedStr = 3600*avgSpeed/kmOrMileInMeters;
        maxSpeedStr = 3600*maxSpeed/kmOrMileInMeters;
        RoundSpeed = toNumberCeil(velocidad);
        speedkmh=velocidad;      
        if (velocidadkmh < 5) {
              speedkmh=5;
        }
        if (velocidadkmh >45){
              speedkmh=45;
        }
    	 // coordenadas aguja de velocidad
        SpeedEndX= toNumberCeil(CX+extspdcircle*Math.cos(Math.toRadians(227.5-speedkmh*5.5)));
        SpeedStartX= toNumberCeil(CX+(intspdcircle-2)*Math.cos(Math.toRadians(227.5-speedkmh*5.5)));
        SpeedStartY=toNumberCeil(CY-(intspdcircle-2)*Math.sin(Math.toRadians(227.5-speedkmh*5.5)));
        SpeedEndY=toNumberCeil(CY-extspdcircle*Math.sin(Math.toRadians(227.5-speedkmh*5.5)));
        
        if (RoundSpeed > 45) {
        	RoundSpeed = 45;
        }
        RoundMSpeed = toNumberCeil(3600*maxSpeed/1000);
        if (RoundMSpeed > 45) {
        	RoundMSpeed = 45;
        }
        RoundASpeed = toNumberCeil(3600*avgSpeed/1000);
        if (RoundASpeed > 45) {
        	RoundASpeed = 45;
        }
        cadrpm = cadencias;
        if (cadrpm > 120) {
        	cadrpm = 120;
        }else if (cadrpm < 40) {
        	cadrpm = 40;
        }	
        // coordenadas aguja de cadencia
        cadEndX= toNumberCeil(cadX+(100+5)*Math.cos(Math.toRadians(270-cadrpm*2.25)));
        cadStartX= toNumberCeil(cadX+(58-5)*Math.cos(Math.toRadians(270-cadrpm*2.25)));
        cadStartY=toNumberCeil(cadY-(58-5)*Math.sin(Math.toRadians(270-cadrpm*2.25)));
        cadEndY=toNumberCeil(cadY-(100+5)*Math.sin(Math.toRadians(270-cadrpm*2.25)));
        
        // coordenadas aguja de HR
        hrstartx = toNumberCeil(CX+ 315*Math.cos(Math.toRadians(105.0799+(-30.15982/(mHRZones[4]-mHRZones[0]))*(hr-mHRZones[0]))));
        hrendx = toNumberCeil(CX + 332*Math.cos(Math.toRadians(105.0799+(-30.15982/(mHRZones[4]-mHRZones[0]))*(hr-mHRZones[0]))));
        hrstarty = toNumberCeil(CY+354 - 315*Math.sin(Math.toRadians(105.0799+(-30.15982/(mHRZones[4]-mHRZones[0]))*(hr-mHRZones[0]))));
        hrendy =  toNumberCeil(CY+354 - 332*Math.sin(Math.toRadians(105.0799+(-30.15982/(mHRZones[4]-mHRZones[0]))*(hr-mHRZones[0])))); 
        
        // coordenadas aguja de PWR
        PWRstartx = toNumberCeil(CX+ 297*Math.cos(Math.toRadians(121.8431+(-31.3725*potencia/FTP))));
        PWRendx = toNumberCeil(CX + 312*Math.cos(Math.toRadians(121.8431+(-31.3725*potencia/FTP))));
        PWRstarty = toNumberCeil(CY+354 - 297*Math.sin(Math.toRadians(121.8431+(-31.3725*potencia/FTP))));
        PWRendy =  toNumberCeil(CY+354 - 312*Math.sin(Math.toRadians(121.8431+(-31.3725*potencia/FTP)))); 
        
        
    }
    
   function onLayout(dc){
   		  setDeviceSettingsDependentVariables(); // obtengo si es metrico o decimal en los settings
   		  setPowerZones(); // Pongo las zonas de Potencia
   		  
   		 // inicializar las zonas de HR
   		 var profile = UserProfile.getProfile();
   		 if( profile != null ) {
	        mHRZones = profile.getHeartRateZones(profile.getCurrentSport());
	     }
   		 // Si es el edge 100 en landscape
   		 if (dc.getWidth() > dc.getHeight()){
   		 	CX= dc.getHeight()/2;
   		 	CY = dc.getHeight()/2;
   		 	extspdcircle = CY;
   		 	intspdcircle = CY - 23;   		 
   		 } else {
   		 	// Normal mode
   		 	CX = dc.getWidth()/2;
   		 	CY = CX;
   		 	extspdcircle = CX;
   		 	cadX= CX;
   		 	cadY= dc.getHeight() - dc.getHeight()/4;
   		 	intspdcircle = CX-23; // 97
   		 	// Definir coordenadas para las 7 velocidades
   		 	x10=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-10*5.5));
   		 	x15=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-15*5.5));
   		 	x20=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-20*5.5));
   		 	x25=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-25*5.5));
   		 	x30=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-30*5.5));
   		 	x35=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-35*5.5));
   		 	x40=CX+(intspdcircle+10)*Math.cos(Math.toRadians(227.5-40*5.5));
   		 	y10=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-10*5.5));
   		 	y15=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-15*5.5));
   		 	y20=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-20*5.5));
   		 	y25=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-25*5.5));
   		 	y30=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-30*5.5));
   		 	y35=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-35*5.5));
   		 	y40=CY-(intspdcircle+10)*Math.sin(Math.toRadians(227.5-40*5.5));
   		 	
   		 	//Definir coordenadas para las 5 zonas texto
   		 	xz1=toNumberCeil(CX+(326)*Math.cos(Math.toRadians(105.0799)));
   		 	xz2=toNumberCeil(CX+(325)*Math.cos(Math.toRadians(97.53995)));
   		 	xz3=toNumberCeil(CX+(325)*Math.cos(Math.toRadians(90)));
   		 	xz4=toNumberCeil(CX+(323)*Math.cos(Math.toRadians(82.46005)));
   		 	xz5=toNumberCeil(CX+(323)*Math.cos(Math.toRadians(74.92009)));
   		 	yz1=toNumberCeil(CY+354-(326)*Math.sin(Math.toRadians(105.0799)));
   		 	yz2=toNumberCeil(CY+354-(325)*Math.sin(Math.toRadians(97.53995)));
   		 	yz3=toNumberCeil(CY+354-(325)*Math.sin(Math.toRadians(90)));
   		 	yz4=toNumberCeil(CY+354-(323)*Math.sin(Math.toRadians(82.46005)));
   		 	yz5=toNumberCeil(CY+354-(323)*Math.sin(Math.toRadians(74.92009)));
   		 	
   		 	// coordenadas para las zonas de Potencia
   		 	xzp0=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(112.6199)));
   		 	xzp1=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(104.5882)));
   		 	xzp2=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(98.62745)));
   		 	xzp3=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(93.92157)));
   		 	xzp4=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(89.21569)));
   		 	xzp5=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(84.19608)));
   		 	xzp6=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(75.09804)));
   		 	yzp0=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(112.6199)));
   		 	yzp1=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(104.5882)));
   		 	yzp2=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(98.62745)));
   		 	yzp3=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(93.92157)));
   		 	yzp4=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(89.21569)));
   		 	yzp5=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(84.19608)));
   		 	yzp6=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(75.09804)));
   		 	
   		 	
   		 	
   		 	
   		 }	
   		 	     
   }
    
    
    function onUpdate(dc){
    //View.onUpdate(dc);
 		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
 		dc.fillRectangle(0,0,240,400); 	 
   	 
   	 //HR fill circle
    	dc.setColor(getHRColor(hr), Gfx.COLOR_TRANSPARENT);
   		dc.fillCircle(CX,CY,intspdcircle);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(1);
    	//dc.drawCircle(CX,CY,intspdcircle);
    	dc.drawCircle(CX,CY,extspdcircle);
    
    
    
    
    // bottom Circle
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(CX,CY+332+22,332);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);    
    	//dc.drawCircle(CX,CY+332+22,332);
    	
    // PWR fill circle
    	dc.setColor(getPWRColor(potencia),Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(cadX,cadY,95);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(cadX-95,cadY-1, cadX+95,cadY+96);
    	
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	//dc.setPenWidth(1);
    	//dc.drawCircle(CX,CY,intspdcircle);
    	//dc.drawCircle(CX,CY,extspdcircle);	
    	
    	
    	
    	
   // Pongo el HR con rallita de donde va en relacion a los colores 
    dc.setPenWidth(21);
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,113,67);    
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,100,80);
    dc.setPenWidth(18);  
     	// zona gris	
    
    dc.setColor(HRColor[1], Gfx.COLOR_TRANSPARENT);
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,105.0799,97.533995);
          // para la potencia
    
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.setColor(PWRColor[2], Gfx.COLOR_TRANSPARENT); //azul
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,104.5882,98.62745);
    dc.setColor(PWRColor[3], Gfx.COLOR_TRANSPARENT);  // Verde
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,98.62745,93.92157); 
    dc.setColor(PWRColor[4], Gfx.COLOR_TRANSPARENT);  // Amarillo
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,93.92157,89.21569);
    dc.setColor(PWRColor[5], Gfx.COLOR_TRANSPARENT);  // Naranja
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,89.21569,84.19608);
    dc.setColor(PWRColor[6], Gfx.COLOR_TRANSPARENT); // Rojo
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,84.19608,75.09804);
    dc.setColor(PWRColor[7], Gfx.COLOR_TRANSPARENT); // purpura
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,75.09804,66);
    //dc.setColor(PWRColor[0], Gfx.COLOR_TRANSPARENT); // blanco
    //dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,115,112.6199);
    dc.setColor(PWRColor[1], Gfx.COLOR_TRANSPARENT); // gris
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,114,104.5882);
    
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(xz1,yz1,Gfx.FONT_XTINY,"Warming", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp0,yzp0,Gfx.FONT_XTINY,"Z1", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp1,yzp1,Gfx.FONT_XTINY,"Z2", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp2,yzp2,Gfx.FONT_XTINY,"Z3", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp3,yzp3,Gfx.FONT_XTINY,"Z4", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp4,yzp4,Gfx.FONT_XTINY,"Z5", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp5,yzp5,Gfx.FONT_XTINY,"Z6", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
   dc.drawText(xzp6,yzp6,Gfx.FONT_XTINY,"Z7", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    // Pinto las zonas HR	 
    dc.setColor(HRColor[2], Gfx.COLOR_TRANSPARENT); // zona azul
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,97.53995,90);
    dc.setColor(HRColor[3], Gfx.COLOR_TRANSPARENT); // zona verde
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,90,82.46005); 
    dc.setColor(HRColor[0], Gfx.COLOR_TRANSPARENT);  // zona blanca
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,113,105.0799);
    dc.setColor(HRColor[4], Gfx.COLOR_TRANSPARENT); // zona Naranja
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,82.46005,74.92009);
    dc.setColor(HRColor[5], Gfx.COLOR_TRANSPARENT); // zona Roja
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,74.92009,67.38);
   
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(xz2,yz2,Gfx.FONT_XTINY,"Fat burn", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);   
    dc.drawText(xz3,yz3,Gfx.FONT_XTINY,"Aerobic", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);  
    dc.drawText(xz4,yz4,Gfx.FONT_XTINY,"Anaerobic", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
   	dc.drawText(xz5,yz5,Gfx.FONT_XTINY,"VO2 Max", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);	
    
   
    
    
 
    // marco abajo del de potencia de colores
    	dc.setPenWidth(1);
    	dc.drawCircle(CX,CY+354,293);
   
   //hr dial
        dc.setPenWidth(6);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(hrstartx,hrstarty, hrendx, hrendy);
        dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(hrstartx,hrstarty, hrendx, hrendy);
    
    //PWR dial	
    	dc.setPenWidth(6);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(PWRstartx,PWRstarty, PWRendx, PWRendy);
        dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(PWRstartx,PWRstarty, PWRendx, PWRendy);
    	
    	
    	
   
   //speed background
    	SPDcoor = dc.getTextDimensions(velocidadkmh.format("%.0f"),Gfx.FONT_NUMBER_THAI_HOT);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRoundedRectangle(CX-SPDcoor[0]/2,y25+30, SPDcoor[0],SPDcoor[1],5);
    	
    	
    // speed dial
    	dc.setPenWidth(1);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawCircle(CX,CY,6);
    	dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(CX,CY, SpeedEndX, SpeedEndY);
    // Speed numbers
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    //dc.drawCircle(11,106,1);
    	dc.drawText(x10,y10,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "10": "6", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x15,y15,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "15": "9", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x20,y20,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "20": "12", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x25,y25,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "25": "16", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x30,y30,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "30": "19", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x35,y35,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "35": "22", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(x40,y40,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "40": "25", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	
    	
    // max speed dial
    	dc.setPenWidth(2);
    	dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(MspdStartX[RoundMSpeed],MspdStarty[RoundMSpeed], SpeedEndXS[RoundMSpeed], SpeedEndYS[RoundMSpeed]);
    	// avg speed dial
    	dc.setPenWidth(2);
    	dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(MspdStartX[RoundASpeed],MspdStarty[RoundASpeed], SpeedEndXS[RoundASpeed], SpeedEndYS[RoundASpeed]);
    
    // Cadence section
    	
    	//cadence bar
    	dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(12);
    	dc.drawArc(cadX,cadY,100,Gfx.ARC_CLOCKWISE ,181, -1);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(10);
    	dc.drawArc(cadX,cadY,100,Gfx.ARC_CLOCKWISE ,180, 0);
    	dc.setPenWidth(1);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(10,cadY,Gfx.FONT_TINY,"40", Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(cadX,cadY-105,Gfx.FONT_TINY,"80", Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(235,cadY,Gfx.FONT_TINY,"120", Gfx.TEXT_JUSTIFY_RIGHT);
    	dc.drawText(cadX,cadY+5,Gfx.FONT_XTINY,"RPM", Gfx.TEXT_JUSTIFY_CENTER);
    	
    	
    	//Cadence dial
    	dc.drawCircle(cadX,cadY,6);
    	dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(cadX,cadY, cadEndX, cadEndY);
    	// Time
    	var clockTime = Sys.getClockTime();
    	
    	time = Lang.format("$1$:$2$",[clockTime.hour, clockTime.min.format("%.2d")]);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(CX,altura-80,Gfx.FONT_LARGE,time, Gfx.TEXT_JUSTIFY_CENTER);
    	// Distance
    	
    	if (distance > 0) {
    		var distancia = distance / kmOrMileInMeters;
    		if (distancia < 100) {
    			distStr  = distancia.format("%.2f");
    		} else {
    		distStr = distancia.format("%.1f");
    		}
    	} else {
    		distStr = ZERO_DISTANCE;
    	}
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(210,altura-50,Gfx.FONT_NUMBER_MILD,distStr, Gfx.TEXT_JUSTIFY_RIGHT);
    	dc.drawText(215,altura-50,Gfx.FONT_XTINY,distanceUnits == System.UNIT_METRIC ? "km": "mi", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	// Duration
    	
    	if (elapsedTime != null && elapsedTime >0){
    		var hours = null;
    		var minutes = elapsedTime / 1000 / 60;
    		var seconds = elapsedTime / 1000 % 60;
    	
    		if (minutes >=60) {
    			hours = minutes / 60;
    			minutes = minutes % 60;
    		}
    		if (hours == null) {
    			duration = minutes.format("%d") + ":" + seconds.format("%02d");
    		} else {
    			duration = hours.format("%d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d");
    		}
    	} else {
    		duration = ZERO_TIME;
    	}
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(5,altura-50,Gfx.FONT_NUMBER_MEDIUM,duration, Gfx.TEXT_JUSTIFY_LEFT);
    	// Cadence
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(cadX,cadY-30,Gfx.FONT_NUMBER_MEDIUM,cadencias, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	
    	// Power
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(cadX,cadY-65,Gfx.FONT_NUMBER_MEDIUM,potencia, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	
    	// Speed
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(CX,y25+40,Gfx.FONT_NUMBER_THAI_HOT,velocidadkmh.format("%.0f"), Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(CX,y25+30,Gfx.FONT_XTINY, distanceUnits == System.UNIT_METRIC ? "km/h":"mi/h", Gfx.TEXT_JUSTIFY_CENTER);
    	// HR
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(CX,yz3-27,Gfx.FONT_TINY,hr, Gfx.TEXT_JUSTIFY_CENTER);
    	
    	//temperatura
    	//dc.drawText(5,yz3+5,Gfx.FONT_TINY,tempe, Gfx.TEXT_JUSTIFY_CENTER);
    	
    	// average speed
     	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
     	dc.drawText(25,10,Gfx.FONT_TINY, "AVG",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(25,10+210,Gfx.FONT_TINY, "AVG",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); // pwr
     	dc.drawText(25,25,Gfx.FONT_TINY,avgSpeedStr.format("%.1f"), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(25,25+183,Gfx.FONT_TINY,avgPWR, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	// max speed
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
     	dc.drawText(215,10,Gfx.FONT_TINY, "MAX",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(215,10+210,Gfx.FONT_TINY, "MAX",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); // pwr
     	dc.drawText(215,25,Gfx.FONT_TINY,maxSpeedStr, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(215,25+183,Gfx.FONT_TINY,maxPWR, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    }
 	
 	function setDeviceSettingsDependentVariables() {       
        distanceUnits = System.getDeviceSettings().distanceUnits;
        if (distanceUnits == System.UNIT_METRIC) {
            kmOrMileInMeters = 1000;
        } else {
            kmOrMileInMeters = 1610;
        }
 	}
  
   function setPowerZones() {
   		
   		FTP= Application.Properties.getValue("FTP");
   		
   		PWRZones[0] = FTP*0.25;
   		PWRZones[1] = FTP*0.55;
   		PWRZones[2] = FTP*0.74;
   		PWRZones[3] = FTP*0.89;
   		PWRZones[4] = FTP*1.04;
   		PWRZones[5] = FTP*1.20;
   		PWRZones[6] = FTP*1.49;  		
   }
  
	function getHRColor(hrt){
		var colorHR;
		
		if (hrt == null || hr < mHRZones[0]) {
			colorHR = HRColor[0];
		} else if (hrt < mHRZones[1]) {
			colorHR = HRColor[1];
		} else if (hrt < mHRZones[2]) {
			colorHR = HRColor[2];
		} else if (hrt < mHRZones[3]) {
			colorHR = HRColor[3];
		} else if (hrt < mHRZones[4]) {
			colorHR = HRColor[4];
		} else {
			colorHR = HRColor[5];
		}
		return colorHR;
	}
	function getPWRColor(PWR){
		var colorPWR;
		
		if (PWR == null || PWR < PWRZones[0]) {
			colorPWR = PWRColor[0];
		} else if (PWR < PWRZones[1]) {
			colorPWR = PWRColor[1];
		} else if (PWR < PWRZones[2]) {
			colorPWR = PWRColor[2];
		} else if (PWR < PWRZones[3]) {
			colorPWR = PWRColor[3];
		} else if (PWR < PWRZones[4]) {
			colorPWR = PWRColor[4];
		} else if (PWR < PWRZones[5]) {
			colorPWR = PWRColor[5];
		} else if (PWR < PWRZones[6]) {
			colorPWR = PWRColor[6];
		} else {
			colorPWR = PWRColor[7];
		}
		return colorPWR;
	}
	
	
	//! convert to integer - round ceiling 
	function toNumberCeil(float) {
        var floor = float.toNumber();
        if (float - floor > 0) {
            return floor + 1;
        }
        return floor;
	}
}