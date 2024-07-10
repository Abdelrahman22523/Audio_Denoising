clear;
clc;
global mc1      %chanel 1
global yr1      %y chanel 1
global mc2      %chanel 2
global yr2      %y chanel 2
global mc3      %chanel 3
global yr3      %y chanel 3
global mc4      %chanel 4
global yr4      %y chanel 4
global mn       %chanel noise
global yn       %y chanel noise
[yr2,fr]=audioread("saved audio\chanel\ch2normal.wav");
mc2=audioplayer(yr2,fr);
[yr3,fr]=audioread("saved audio\chanel\ch3DJ.wav");
mc3=audioplayer(yr3,fr);
[yr4,fr]=audioread("saved audio\chanel\ch4recorded.wav");
mc4=audioplayer(yr4,fr);
[yn,fr]=audioread("saved audio\chanel\noise.wav");
mn=audioplayer(yn,fr);
[yr1,fr]=audioread("saved audio\chanel\ch1palestine.wav");
mc1=audioplayer(yr1,fr);     
omr=mc1;            %the default is chanel 1

mrpos=omr.CurrentSample;
play(omr,mrpos);
pause(5);
[mrpos,yr,fr]=change_chanel(2,1,omr);
omr=audioplayer(yr,fr); 
play(omr,mrpos);
pause(5);
[mrpos,yr,fr]=change_chanel(3,2,omr);
omr=audioplayer(yr,fr); 
play(omr,mrpos);
pause(5);
[mrpos,yr,fr]=change_chanel(1,3,omr);
omr=audioplayer(yr,fr); 
play(omr,mrpos);
pause(5);
[mrpos,yr,fr]=change_chanel(2,1,omr);
omr=audioplayer(yr,fr); 
play(omr,mrpos);
pause(5);
pause(omr);

    function [pos,ynew,fnew] = change_chanel(ch,old_ch,old_m)
    global mc1      %chanel 1
    global yr1      %y chanel 1
    global mc2      %chanel 2
    global yr2      %y chanel 2
    global mc3      %chanel 3
    global yr3      %y chanel 3
    global mc4      %chanel 4
    global yr4      %y chanel 4
    global mn       %chanel noise
    global yn       %y chanel noise
    pause(old_m);
    old_pos=old_m.CurrentSample;    %save the current position
    if old_ch==2
        play(mc2,old_pos);
        pause(0.05);
        pause(mc2);
    elseif old_ch==3
        play(mc3,old_pos);
        pause(0.05);
        pause(mc3);
    elseif old_ch==4
        play(mc4,old_pos);
        pause(0.05);
        pause(mc4);
    else
        play(mn,old_pos);
        pause(0.05);
        pause(mn);
    end

  if ch==1
    ynew=yr1;
    fnew=mc1.SampleRate;
    pos=mc1.CurrentSample;
  elseif ch==2
    ynew=yr2;
    fnew=mc2.SampleRate;
    pos=mc2.CurrentSample;
  elseif ch==3
    ynew=yr3;
    fnew=mc3.SampleRate;
    pos=mc3.CurrentSample;
  elseif ch==4
    ynew=yr4;
    fnew=mc4.SampleRate;
    pos=mc4.CurrentSample;
  else
    ynew=yn;
    fnew=mn.SampleRate;
    pos=mn.CurrentSample;
  end
   
   end