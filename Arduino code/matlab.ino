
  const int sound[] = {2,3};        //selectors pin
  const int led[]={12,13};          //selection's led
  const int off=7;                  //off pin
  int offread=1;                    //assume it is off
  volatile bool off_state = true;  //assuming it is off
  const int FMswitch=8;
  int FM=1;
  const int choffset=10; 
  int serial_read,sequence=0; // for bouncing
  const byte m[] = {1,2};           //sound file index
  int long count=0;
  int long pcount=0;
  int long offcount=0;
  int x=0;
  const int vol=A5;
  //intialize the volume
  int volume_input=513;       //default value
  const int ch_selector=A0;         //chanel selector
  int ch_selector_input=0;   
  int chanel= 1;              //default chanel

  void setup(void) {
    // put your setup code here, to run once:
    Serial.begin(9600);
    delay(100);
    //Serial.println("0");
    //  Off pin
    pinMode(off, INPUT_PULLUP); // Set as input with internal pull-up resistor
    pinMode(FMswitch, INPUT_PULLUP); // Set as input with internal pull-up resistor
    // Selectors leds
    for (int i=0;i<2;i++)
    pinMode(led[i],OUTPUT); 

    // Selectors pins
    for (int i=0;i<2;i++)
      pinMode(sound[i],INPUT);  
  
    // make the leds off
    for (int i=0;i<2;i++)
      digitalWrite(led[i],LOW);
    delay(100);
    while(offread==1){
      offread=digitalRead(off);
      Serial.println(1000L*volume_input);
      delay(1500);
    }
    //it is on now
    // make the leds on for a second then off
    for (int i=0;i<2;i++)
      digitalWrite(led[i],HIGH);
    Serial.println(1000L*volume_input+10*chanel); // intialize
    delay(1100);
    for (int i=0;i<2;i++)
      digitalWrite(led[i],LOW);
    //Serial.println("First off"); // intialize
    off_state = false;
  }
  
  void loop(void) {
    /*
    // just to make sure arduino is OK
    digitalWrite(13,HIGH);
    delay(100);
    digitalWrite(13,LOW);
    delay(175);
    */
    //Serial.println(off_state);
    while(off_state==false){
      //for volume
      int old_volume=volume_input;
      volume_input=analogRead(vol);
      if((volume_input>=old_volume+15 ||volume_input<=old_volume-15) && digitalRead(sound[0])==0 && digitalRead(sound[1])==0){ 
        //check if it changed due to potentiometre not noise
        volume_input=check_analog_pin(vol,old_volume);
        if (x>=2){ //we need first to calculate everything
          Serial.println("from volume");
          Serial.println(1000L*volume_input+10*chanel);
          x=2;
        }
      }
      else{
        volume_input=old_volume;   //leave it as it was before
      }

      //check the off 
      offread=digitalRead(off);
      if(offread==1){
        handle_off_Interrupt();
        break;
      }
      //for chanel mode
      int FMselector=digitalRead(FMswitch);

      if(FMselector==0 && chanel<=choffset){
        //it means we switch to AM
        chanel=chanel+choffset;
        FM=0;
        Serial.println("From mode");
        Serial.println(1000L*volume_input+10*chanel);  
      }
      else if(FMselector==1 && chanel>=choffset){
        //it means we switch to AM
        chanel=chanel-choffset;
        FM=1;
        Serial.println("From mode");
        Serial.println(1000L*volume_input+10*chanel);
      }
      
      //for chanel
      int old_chanel_input=ch_selector_input;
      ch_selector_input=analogRead(ch_selector);
      /*
      Serial.print("old input: ");
      Serial.println(old_chanel_input);
      Serial.print("input: ");
      Serial.println(ch_selector_input);
      */
      if((ch_selector_input>=old_chanel_input+15 ||ch_selector_input<=old_chanel_input-15) && digitalRead(sound[0])==0 && digitalRead(sound[1])==0){ 
        //check if it changed due to potentiometre not noise
        /*int x=old_chanel_input;
        int y=chanel;
        */
        ch_selector_input=check_analog_pin(ch_selector,old_chanel_input);
        chanel=check_chanel(ch_selector_input);
        if (FM==0) //AM
          chanel=chanel+choffset;
        /*
        Serial.print("old: ");
        Serial.println(x);
        Serial.print("old chanel: ");
        Serial.println(y);
        Serial.print("new: ");
        Serial.println(ch_selector_input);
        Serial.print("new chanel: ");
        Serial.println(chanel);
        */
        if (x>=2){ //we need first to calculate everything
          Serial.println("From chanel");
          Serial.println(1000L*volume_input+10*chanel);
          x=2;
        }

      }
      else{
        //Serial.print("else");
        ch_selector_input=old_chanel_input;   //leave it as it was before
      }

      offread=digitalRead(off);
      if(offread==1){
        handle_off_Interrupt();
        break;
      }
    
      //Serial.println(count);
      if(count>=5000){
       // make the leds off
        for (int i=0;i<2;i++)
          digitalWrite(led[i],LOW);
      }
    
      if (digitalRead(sound[0])) {
        //check if it is not long click   
        if(check_pin(sound[0],serial_read, sequence)){
          digitalWrite(led[1],LOW);
          digitalWrite(led[0],HIGH);
          for(int i=0;i<5;i++){
            //Serial.print("for loop1: "); 
            Serial.println("From receive");
            Serial.println(1000L*volume_input+10*chanel+m[0]);
            delay(400);
          }
         delay(100);
         count=0;
         pcount=0;
        }
      sequence=0;  
      }
    
      if (digitalRead(sound[1])) {
      //check if it is not long click   
        if(check_pin(sound[1],serial_read, sequence)){
          digitalWrite(led[0],LOW);
          digitalWrite(led[1],HIGH);
          for(int i=0;i<5;i++){
            //Serial.print("for loop2: ");
            Serial.println("From filter"); 
            Serial.println(1000L*volume_input+10*chanel+m[1]);
            delay(400);
            }
          delay(100);
          count=0;
          pcount=0;
          }
      sequence=0;  
      } 

      offread=digitalRead(off);
      if(offread==1){
        handle_off_Interrupt();
        break;
      }
      //Serial.println(pcount);
      if(pcount>=150){
        // print in order to keep moniter full
        Serial.println("From loop");
        Serial.println(1000L*volume_input+10*chanel);
        x=2;
        pcount=0;
      }
      delay(10);
      count=count+1;
      pcount=pcount+1;
      x++;
      }
    
    //Serial.println(offcount);
    if(offcount==1){
    //Serial.println(offcount);    
    Serial.println(1000L*volume_input);
    delay(5000);
    }

    offread=digitalRead(off);
      if(offread==0){
        handle_off_Interrupt();
      }
    offcount++;  
    }
  
  int check_pin(int pin,int &reading, int &seq){
    reading=digitalRead(pin); 
    delay(60);
    /*Serial.print("reading=");
    Serial.print(reading);
    Serial.print(" seq=");
    Serial.println(seq);*/
    while(reading){
      seq=seq+1; 
      reading=digitalRead(pin);
      delay(30);
      /*Serial.print("reading=");
      Serial.print(reading);
      Serial.print(" seq=");
      Serial.println(seq);*/
      }
                 
   if(6<seq&&seq<=50){
      return 1;
      }
   return 0;
  }

  //to avoid analog noise
int check_analog_pin(int pin,int reading){
  while(1){ // want be out until stabilized
  int counter=1;
  int readinga[23];
  int diff[3];
  readinga[0]=analogRead(pin);
  /*
  Serial.print("readinga: ");
  Serial.print("first time ");
  Serial.println(readinga[0]);
  */
  delay(100);
  for (;counter<4;counter++){
      readinga[counter]=analogRead(pin);
      /*
      Serial.print("readinga: ");
      Serial.print("first for loop ");
      Serial.println(counter);
      Serial.println(readinga[counter]);
      Serial.println(readinga[counter-1]);
      */
      diff[counter-1]=abs(readinga[counter]-readinga[counter-1]);
      delay(100);
  }
  //Serial.print("out first for loop ");
  int i =0;
  for(;i<3;i++){
    //Serial.print("diff: ");
    //Serial.println(diff[i]);
    if(diff[i]>6) //it is not stabilized
      break;
    if(i==2){ //we are good
      //Serial.println("We are good\n mes: ");
      if (readinga[counter-1]>=reading+4 || readinga[counter-1]<=reading-4){
        //Serial.println(readinga[counter-1]);
        return readinga[counter-1];
      }
      else{
        //Serial.println(reading);
        return reading;
      }
    }
  }  
  i=0;
      
  while(counter<23){
    readinga[counter]=analogRead(pin);
    //Serial.print("readinga: ");
    //Serial.println(readinga[counter]);
    if(i==3){
      for(i=0;i<3;i++)
        diff[i]=abs(readinga[counter-3+i]-readinga[counter-4+i]);
      i =0;
      for(;i<3;i++){
        //Serial.print("diff: ");
        //Serial.println(diff[i]);
        if(diff[i]>6) //it is not stabilized
          break;
        if(i==2){ //we are good
          //Serial.println("We are good\n mes: ");
          if (readinga[counter-1]>=reading+4 || readinga[counter-1]<=reading-4){
            //Serial.println(readinga[counter-1]);
            return readinga[counter-1];
          }
          else{
           //Serial.println(reading);
           return reading;
          }
          }
        }  
      i=0;  
      }
      
    counter++; 
    i++;
    delay(100);
    }
  } 
  } 

  //to map the input
  int check_chanel(int reading){
    /*
     * the frequency spectrum
     * 0-204   ch1 palastine  =1
     * 205-323 noise1         =5
     * 324-425 ch2 normal     =2
     * 426-544 noise2         =6
     * 545-748 ch3 Dj         =3
     * 749-816 noise3         =7
     * 816-1020 ch4 recorded  =4
     */
    //Serial.print("chanel reading: ");
    //Serial.println(reading);
    if (reading <= 204)
      return 1;
    else if (reading >= 205 && reading <= 323)
      return 5;
    else if (reading >= 324 && reading <= 425)
      return 2;
    else if (reading >= 426 && reading <= 544)
      return 6;
    else if (reading >= 545 && reading <= 748)
      return 3;
    else if (reading >= 749 && reading <= 816)
      return 7;  
    else if (reading >= 816)
      return 4;
    else  //it is noise
      return 5;
  } 

  void handle_off_Interrupt(){
    //Serial.println("Interrupt");
    //Serial.println(off_state);
    if(off_state==false){ //if it was on
      Serial.println(1000L*volume_input);
      
      //off the leds
      for (int i=0;i<2;i++)
        digitalWrite(led[i],LOW);
      delay(1500);
    }
    else{ //if it was off 
      Serial.println("From interrupt");
      Serial.println(1000L*volume_input+10*chanel);
      //on the leds
      for (int i=0;i<2;i++)
        digitalWrite(led[i],HIGH);
     delay(1500);
     // off it again
     for (int i=0;i<2;i++)
      digitalWrite(led[i],LOW);     
    }
    off_state=!off_state;
    offcount=0;
    //Serial.println(off_state);
  }

   
