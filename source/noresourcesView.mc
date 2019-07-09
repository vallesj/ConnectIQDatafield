using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.UserProfile as UserProfile;
using Toybox.Math;

class noresourcesView extends Ui.DataField {
    hidden var avgSpeedStr = 0;
    hidden var stepHR = 0;
    hidden var hrStr = 0;
    hidden var maxSpeedStr = 0;
    hidden var cadenciaStr =0;
    hidden var distStr = 0;
    hidden var duration = 0;
    hidden var time =0;
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
	//hidden var tempe = 0;
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
	hidden var CADcoor = [30,30];
	hidden var FTP = 217;
	hidden var SpeedEndX = 0;
	hidden var SpeedEndY= 0;
	hidden var SpeedStartX =0;
	hidden var SpeedStartY =0;
	hidden var cadStartX = 0;
	hidden var cadStartY = 0;
	hidden var cadEndX = 0;
	hidden var cadEndY = 0;	
	//hidden var SpeedEndXS = [7,4,4,4,4,4,4,1,0,0,1,3,6,10,16,22,29,37,45,55,65,75,86,97,108,120,132,143,154,165,175,185,195,203,211,218,224,230,234,237,239,240,240,239,236,233];
	//hidden var SpeedEndYS=[161,150,150,150,150,150,150,139,127,116,104,93,82,71,61,51,42,34,26,19,14,9,5,2,1,0,1,2,5,9,14,19,26,34,42,51,61,71,82,93,104,116,127,139,150,161];
	//hidden var MspdStartX = [35,33,33,33,33,33,33,31,30,30,31,32,35,38,42,46,52,57,64,71,78,86,94,103,111,120,129,137,146,154,162,169,176,183,188,194,198,202,205,208,209,210,210,209,207,205];
	//hidden var MspdStarty= [151,143,143,143,143,143,143,134,125,117,108,100,91,83,76,68,62,55,50,45,40,37,34,32,30,30,30,32,34,37,40,45,50,55,62,68,76,83,91,100,108,117,125,134,143,151];
	hidden var MspdStartX = 0;
	hidden var MspdStarty = 0;
	hidden var SpeedEndXS = 0;
	hidden var SpeedEndYS = 0;
	hidden var MspdStartXa = 0;
	hidden var MspdStartya = 0;
	hidden var SpeedEndXSa = 0;
	hidden var SpeedEndYSa = 0;
	
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
	hidden var xm10, xm15, xm20, xm25, xm30, xm35, xm40, ym10, ym15, ym20, ym25, ym30, ym35, ym40; 
	hidden var altura = 400;
	hidden var ancho = 240;
	hidden var angleS = 67.30335;
	hidden var angleE = 112.6966;
	hidden var angleSP = 0;
	hidden var angleEP = 0;
	hidden var stepPWR = 0;
    hidden var m = 0;
    hidden var b = 0;
    hidden var teta1 = 0;
    hidden var teta2 = 0;
    hidden var teta3=0;
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
    	
        if (RoundSpeed > 45) {
        	RoundSpeed = 45;
        }
        RoundMSpeed = toNumberCeil(3600*maxSpeed/1000);
        if (RoundMSpeed > 45) {
        	RoundMSpeed = 45;
        }
        if (RoundMSpeed < 5) {
        	RoundMSpeed =5;
        }
        RoundASpeed = toNumberCeil(3600*avgSpeed/1000);
        if (RoundASpeed > 45) {
        	RoundASpeed = 45;
        }
        if (RoundASpeed < 5) {
        	RoundASpeed =5;
        }
    	cadrpm = cadencias;
        if (cadrpm > 120) {
        	cadrpm = 120;
        }else if (cadrpm < 40) {
        	cadrpm = 40;
        }	
    	
    	 // coordenadas aguja de velocidad     
        SpeedStartX= toNumberCeil(CX+(-7)*Math.cos(Math.toRadians(227.5-speedkmh*5.5)));
        SpeedStartY=toNumberCeil(CY-(-7)*Math.sin(Math.toRadians(227.5-speedkmh*5.5)));
        
        SpeedEndX= toNumberCeil(CX+extspdcircle*Math.cos(Math.toRadians(227.5-speedkmh*5.5)));
        SpeedEndY=toNumberCeil(CY-extspdcircle*Math.sin(Math.toRadians(227.5-speedkmh*5.5)));
        
        //coordenadas agujas de avg y Max speed
        MspdStartX= toNumberCeil(CX+(intspdcircle-7)*Math.cos(Math.toRadians(227.5-RoundMSpeed*5.5)));
        MspdStarty=toNumberCeil(CY-(intspdcircle-7)*Math.sin(Math.toRadians(227.5-RoundMSpeed*5.5)));        
        SpeedEndXS= toNumberCeil(CX+extspdcircle*Math.cos(Math.toRadians(227.5-RoundMSpeed*5.5)));
        SpeedEndYS=toNumberCeil(CY-extspdcircle*Math.sin(Math.toRadians(227.5-RoundMSpeed*5.5)));
        MspdStartXa= toNumberCeil(CX+(intspdcircle-7)*Math.cos(Math.toRadians(227.5-RoundASpeed*5.5)));
        MspdStartya=toNumberCeil(CY-(intspdcircle-7)*Math.sin(Math.toRadians(227.5-RoundASpeed*5.5)));        
        SpeedEndXSa= toNumberCeil(CX+extspdcircle*Math.cos(Math.toRadians(227.5-RoundASpeed*5.5)));
        SpeedEndYSa=toNumberCeil(CY-extspdcircle*Math.sin(Math.toRadians(227.5-RoundASpeed*5.5)));
        
        
                
        // coordenadas aguja de cadencia 
        teta1  = 270-cadrpm*2.25;  
        cadStartX= toNumberCeil(cadX+(-7)*Math.cos(Math.toRadians(teta1)));
        cadStartY=toNumberCeil(cadY-(-7)*Math.sin(Math.toRadians(teta1)));
        cadEndX= toNumberCeil(cadX+((ancho-40)/2+5)*Math.cos(Math.toRadians(teta1)));
        cadEndY=toNumberCeil(cadY-((ancho-40)/2+5)*Math.sin(Math.toRadians(teta1)));
        
        // coordenadas aguja de HR
        teta2 = Math.toRadians((angleE-stepHR)+(-stepHR*4/(mHRZones[4]-mHRZones[0]))*(hr-mHRZones[0]));
        hrstartx = toNumberCeil(CX+ 315*Math.cos(teta2));
        hrstarty = toNumberCeil(CY+354 - 315*Math.sin(teta2));
        hrendx = toNumberCeil(CX + 332*Math.cos(teta2));        
        hrendy =  toNumberCeil(CY+354 - 332*Math.sin(teta2)); 
        
        // coordenadas aguja de PWR
        m = - (angleEP-angleSP)/(1.78-0.25);
        b = angleEP - m * 0.25;
        teta3 = Math.toRadians(b + m * potencia/FTP);
        PWRstartx = toNumberCeil(CX+ 297*Math.cos(teta3));
        PWRstarty = toNumberCeil(CY+354 - 297*Math.sin(teta3));
        PWRendx = toNumberCeil(CX + 312*Math.cos(teta3));        
        PWRendy =  toNumberCeil(CY+354 - 312*Math.sin(teta3));           
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
   		 ancho = dc.getWidth();
   		 altura = dc.getHeight(); 
   		 
   		 if (ancho > altura){
   		 	CX= altura/2;
   		 	CY = altura/2;
   		 	extspdcircle = CY;
   		 	intspdcircle = CY - 23;   		 
   		 } else {
   		 	// Normal mode
   		 	CX = ancho/2;
   		 	CY = CX;
   		 	extspdcircle = CX;
   		 	cadX= CX;
   		 	cadY= 2*CX + 54;//altura - altura/4;
   		 	intspdcircle = CX-23; // 97
   		 	
   		 	angleS = Math.toDegrees(Math.acos(CX/311.0));
   		 	angleE = 180-angleS;
   		 	stepHR= (angleE-angleS)/6.0;
   		 	angleSP = Math.toDegrees(Math.acos(CX/290.0));
   		 	angleEP = 180-angleSP;
   		 	stepPWR = (angleEP-angleSP)/153;
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
   		 	// coordenadas para velocidades alternas
   		 	xm10=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-10*5.5));
   		 	xm15=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-15*5.5));
   		 	xm20=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-20*5.5));
   		 	xm25=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-25*5.5));
   		 	xm30=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-30*5.5));
   		 	xm35=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-35*5.5));
   		 	xm40=CX+(intspdcircle-10)*Math.cos(Math.toRadians(227.5-40*5.5));
   		 	ym10=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-10*5.5));
   		 	ym15=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-15*5.5));
   		 	ym20=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-20*5.5));
   		 	ym25=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-25*5.5));
   		 	ym30=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-30*5.5));
   		 	ym35=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-35*5.5));
   		 	ym40=CY-(intspdcircle-10)*Math.sin(Math.toRadians(227.5-40*5.5));   		 	
   		 	
   		 	//Definir coordenadas para las 5 zonas texto
   		 	xz1=toNumberCeil(CX+(326)*Math.cos(Math.toRadians(angleE-stepHR)));
   		 	xz2=toNumberCeil(CX+(325)*Math.cos(Math.toRadians(angleE-stepHR*2)));
   		 	xz3=toNumberCeil(CX+(325)*Math.cos(Math.toRadians(angleE-stepHR*3)));
   		 	xz4=toNumberCeil(CX+(323)*Math.cos(Math.toRadians(angleE-stepHR*4)));
   		 	xz5=toNumberCeil(CX+(323)*Math.cos(Math.toRadians(angleE-stepHR*5)));
   		 	yz1=toNumberCeil(CY+354-(326)*Math.sin(Math.toRadians(angleE-stepHR)));
   		 	yz2=toNumberCeil(CY+354-(325)*Math.sin(Math.toRadians(angleE-stepHR*2)));
   		 	yz3=toNumberCeil(CY+354-(325)*Math.sin(Math.toRadians(angleE-stepHR*3)));
   		 	yz4=toNumberCeil(CY+354-(323)*Math.sin(Math.toRadians(angleE-stepHR*4)));
   		 	yz5=toNumberCeil(CY+354-(323)*Math.sin(Math.toRadians(angleE-stepHR*5)));
   		 	
   		 	// coordenadas para las zonas de Potencia
   		 	xzp0=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-2)));
   		 	xzp1=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-1)));
   		 	xzp2=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-19*stepPWR)));
   		 	xzp3=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR)));
   		 	xzp4=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2)));
   		 	xzp5=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR)));
   		 	xzp6=toNumberCeil(CX+(305)*Math.cos(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR-29*stepPWR)));
   		 	yzp0=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-2)));
   		 	yzp1=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-1)));
   		 	yzp2=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-19*stepPWR)));
   		 	yzp3=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR)));
   		 	yzp4=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2)));
   		 	yzp5=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR)));
   		 	yzp6=toNumberCeil(CY+354-(305)*Math.sin(Math.toRadians(angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR-29*stepPWR)));   		 	   		 	   		 	   		 	
   		 }	   		 	     
   }
    
    
    function onUpdate(dc){
    //View.onUpdate(dc);
 		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT); // background filling blank
 		dc.fillRectangle(0,0,ancho,altura); 	 
   	 
   	 //HR fill circle
    	dc.setColor(getHRColor(hr), Gfx.COLOR_TRANSPARENT);
   		dc.fillCircle(CX,CY,intspdcircle);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(1);
    	dc.drawCircle(CX,CY,extspdcircle); // circulo exterior de la velocidad
                
    // bottom Circle
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(CX,CY+332+22,332);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);    
    	//dc.drawCircle(CX,CY+332+22,332);
    	
    // PWR fill circle
    	dc.setColor(getPWRColor(potencia),Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(cadX,cadY,(ancho-40)/2-5);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(0,cadY-1, ancho,cadY+96);
    	    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
	    	    	
   // Pongo el HR con rallita de donde va en relacion a los colores 
    dc.setPenWidth(21);
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE+1,angleS);    
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,100,80);
    dc.setPenWidth(18);  
     	// zona gris	
    
    dc.setColor(HRColor[1], Gfx.COLOR_TRANSPARENT);
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE-stepHR,angleE-stepHR*2);
          // para la potencia
    
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.setColor(PWRColor[2], Gfx.COLOR_TRANSPARENT); //azul
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR,angleEP-30*stepPWR-19*stepPWR);
    dc.setColor(PWRColor[3], Gfx.COLOR_TRANSPARENT);  // Verde
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR-19*stepPWR,angleEP-30*stepPWR-19*stepPWR-15*stepPWR); 
    dc.setColor(PWRColor[4], Gfx.COLOR_TRANSPARENT);  // Amarillo
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR-19*stepPWR-15*stepPWR,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2);
    dc.setColor(PWRColor[5], Gfx.COLOR_TRANSPARENT);  // Naranja
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR);
    dc.setColor(PWRColor[6], Gfx.COLOR_TRANSPARENT); // Rojo
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR-29*stepPWR);
    dc.setColor(PWRColor[7], Gfx.COLOR_TRANSPARENT); // purpura
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR-29*stepPWR,angleEP-30*stepPWR-19*stepPWR-15*stepPWR*2-16*stepPWR-29*stepPWR*2);
    dc.setColor(PWRColor[1], Gfx.COLOR_TRANSPARENT); // gris
    dc.drawArc(CX,CY+354,302,Gfx.ARC_CLOCKWISE,angleEP,angleEP-30*stepPWR);
    
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(xz1+3,yz1-3,Gfx.FONT_XTINY,"Warming", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp0,yzp0,Gfx.FONT_XTINY,"Z1", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp1,yzp1,Gfx.FONT_XTINY,"Z2", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp2,yzp2,Gfx.FONT_XTINY,"Z3", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp3,yzp3,Gfx.FONT_XTINY,"Z4", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp4,yzp4,Gfx.FONT_XTINY,"Z5", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    dc.drawText(xzp5,yzp5,Gfx.FONT_XTINY,"Z6", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
   dc.drawText(xzp6,yzp6,Gfx.FONT_XTINY,"Z7", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    // Pinto las zonas HR	 
    dc.setColor(HRColor[2], Gfx.COLOR_TRANSPARENT); // zona azul
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE-stepHR*2,angleE-stepHR*3);
    dc.setColor(HRColor[3], Gfx.COLOR_TRANSPARENT); // zona verde
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE-stepHR*3,angleE-stepHR*4); 
    dc.setColor(HRColor[0], Gfx.COLOR_TRANSPARENT);  // zona blanca
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE+1,angleE-stepHR);
    dc.setColor(HRColor[4], Gfx.COLOR_TRANSPARENT); // zona Naranja
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE-stepHR*4,angleE-stepHR*5);
    dc.setColor(HRColor[5], Gfx.COLOR_TRANSPARENT); // zona Roja
    dc.drawArc(CX,CY+354,322,Gfx.ARC_CLOCKWISE,angleE-stepHR*5,angleS);
   
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(xz2+3,yz2,Gfx.FONT_XTINY,"Fat burn", Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);   
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
    	

   //Digital speed background
    	SPDcoor = dc.getTextDimensions(velocidadkmh.format("%.0f"),Gfx.FONT_NUMBER_THAI_HOT);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRoundedRectangle(CX-SPDcoor[0]/2,y25+30, SPDcoor[0],SPDcoor[1],5);
    	    	
    // speed dial
    	dc.setPenWidth(1);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(CX,CY,6);    	
    	dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(SpeedStartX,SpeedStartY, SpeedEndX, SpeedEndY);       // speed needle
    	dc.setColor(getHRColor(hr),Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(CX,CY,2);
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
    	// alternate speeed numbers
    	dc.drawText(xm10,ym10,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "6": "10", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm15,ym15,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "9": "15", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm20,ym20,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "12": "20", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm25,ym25,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "16": "25", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm30,ym30,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "19": "30", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm35,ym35,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "22": "35", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	dc.drawText(xm40,ym40,Gfx.FONT_TINY,distanceUnits == System.UNIT_METRIC ? "25": "40", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	
    // max speed dial  
    	dc.setPenWidth(2);
    	dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(MspdStartX,MspdStarty, SpeedEndXS, SpeedEndYS);
    	// avg speed dial  
    	dc.setPenWidth(2);
    	dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(MspdStartXa,MspdStartya, SpeedEndXSa, SpeedEndYSa);
    
    // Cadence section
    	
    	//cadence bar
    	dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(12);
    	dc.drawArc(cadX,cadY,(ancho-40)/2,Gfx.ARC_CLOCKWISE ,181, -1);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.setPenWidth(10);
    	dc.drawArc(cadX,cadY,(ancho-40)/2,Gfx.ARC_CLOCKWISE ,180, 0);
    	dc.setPenWidth(1);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(10,cadY,Gfx.FONT_TINY,"40", Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(cadX,cadY-(ancho-40)/2-5,Gfx.FONT_TINY,"80", Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(cadX+(ancho-40)/2+15,cadY,Gfx.FONT_TINY,"120", Gfx.TEXT_JUSTIFY_RIGHT);
    	// Cadence
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	
    	dc.drawText(cadX-2,cadY+4,Gfx.FONT_TINY,cadencias, Gfx.TEXT_JUSTIFY_RIGHT); 
    	
    	dc.drawText(cadX+2,cadY+4,Gfx.FONT_TINY,"RPM", Gfx.TEXT_JUSTIFY_LEFT);
    	
    	
    	//Cadence dial
    	dc.setPenWidth(1);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(cadX,cadY,6);  
        
    	dc.setPenWidth(4);
    	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.drawLine(cadStartX,cadStartY, cadEndX, cadEndY); // Cadence needle
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(cadX,cadY,2);
    	
    	// Time
    	var clockTime = Sys.getClockTime();  	
    	time = Lang.format("$1$:$2$",[clockTime.hour, clockTime.min.format("%.2d")]);
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(CX,altura-85,Gfx.FONT_LARGE,time, Gfx.TEXT_JUSTIFY_CENTER);
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
    	dc.drawText(ancho-30,altura-50,Gfx.FONT_NUMBER_MILD,distStr, Gfx.TEXT_JUSTIFY_RIGHT); // Distancia recorrida
    	dc.drawText(ancho-25,altura-50,Gfx.FONT_XTINY,distanceUnits == System.UNIT_METRIC ? "km": "mi", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
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
    	dc.drawText(5,altura-50,Gfx.FONT_NUMBER_MEDIUM,duration, Gfx.TEXT_JUSTIFY_LEFT);  // tiempo de recorrido
    	
    	
    	// Power
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(cadX,cadY-70,Gfx.FONT_NUMBER_MEDIUM,potencia, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	
    	// Speed
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(CX,y25+40,Gfx.FONT_NUMBER_THAI_HOT,velocidadkmh.format("%.0f"), Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(CX,y25+30,Gfx.FONT_XTINY, distanceUnits == System.UNIT_METRIC ? "km/h":"mi/h", Gfx.TEXT_JUSTIFY_CENTER);
    	// HR
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(15,yz1+2,Gfx.FONT_TINY,hr, Gfx.TEXT_JUSTIFY_CENTER);
    	

    	// average speed
     	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
     	dc.drawText(25,10,Gfx.FONT_TINY, "AVG",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(25,yz1+52,Gfx.FONT_TINY, "AVG",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); // pwr
     	dc.drawText(25,25,Gfx.FONT_TINY,avgSpeedStr.format("%.1f"), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(25,yz1+65,Gfx.FONT_TINY,avgPWR, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    	// max speed
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
     	dc.drawText(ancho-25,10,Gfx.FONT_TINY, "MAX",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(ancho-25,yz1+52,Gfx.FONT_TINY, "MAX",Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); // pwr
     	dc.drawText(ancho-25,25,Gfx.FONT_TINY,maxSpeedStr.format("%.1f"), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
     	dc.drawText(ancho-25,yz1+65,Gfx.FONT_TINY,maxPWR, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
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
