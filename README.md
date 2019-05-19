# ConnectIQDatafield
Repository for my Datafield
I started monitoring my HR and bike speed on a vivoactive HR, and later upgraded to the Vivoactive 3. When you are with your Mountain Bike on the trails you need to have most of your attention to the road, and unfortunately with the small screen of the watch  it was difficult to read all the variables from your ride like Speed, Cadence, HR, HR zones, etc. Looking into the available Datafields I loved the Analog implementation from Stanislav for the vivoactive but unfortunatelly it did not include the heartrate zones. So I decided to learn how to make my own Datafield. I believe that showing the numbers with an analog dashboard like those of an automobile, will let me understand the speed faster than when reading a number. So Implemented it for 

Speed 
Cadence 
Heart Rate Zones
Hearth Rate zones are normally used for training, and they have a standard color, so I added the background of the speed to change of color depending of the Hearth Rate I am.  The color zones are as follow:

Zone 1- Gray: 50%-59% of Maximum HR: Warm-Up/Cool Down & Active Recovery.
Zone 2- Blue:60%-69% of Max HR:Endurance or long time effort maintained. Also it is believed that training on this zone you are using mainly your FAT as energy
Zone 3- Green:70%-79% of Max HR: Aerobic zone where you don-t put so much stress of the muscle and can be maintained for long rides.
Zone 4 - Yellow: 80%-89% of Max HR. Anaerobic zone where you energy come more than carbs than fat, muscle are fatigued around 1 hour after depleting your carbs reserves.
Zone 5 - Red: 90%-100% of MHR. Maximum effort, it can be sustained for a very short period round 30 seconds to 3 minutes. 
With a very quick view of the screen you can see on what HR zone you are on that moment when you memorize the colors.

Later I could purchase the EDGE 1000 and saw the big screen can let you put more information in there. I also noticed that the same concept for the watches applies to the cycling computer since your attention need to be always on the road, so a quick glance on the screen can let you know how are you performing. 

And Now with my later acquisition which is a PowerMeter, I implemented the same concept as with the Hearth Rate zones. However Power zones are defined different than those from the HR, so instead of 5 zones we have 7. Instead of Max HR the FTP number is used:

Gray- Zone for warming/cool down and also recovery. <55% FTP
Blue- Zone for endurance or fat burning. Long distance rides. 57%-75% FTP
Green- Aerobic zone or also called Tempo zone. or, 76-90% FTP
Yellow- Lactate Threshold, normally for Time trial efforts. 91-105% of FTP
Orange- VO2 Max , 106-120% FTP
Red - Anaerobic capacity. >= 121% of FTP
Purple- Max effort 
Currently the FTP is 198 watts as default until I figure out how to program the "Settings" so that you can change it to your FTP. Unfortunately the power zones can not be obtained directly from your profile like the HR zones therefore it needs to be input manually. Another pending ideas I have is to include laps averages, may be by placing an arrow with the number of the lap to the Speed and Power. I may need to include also an additional timer for current lap. I may thinking in the future to identify if there is an interval training in process and include a flag or notification where your power average after the 3rd interval is lower than the percentage suggested by the book from Hunter, Coggan, and Allan. 
