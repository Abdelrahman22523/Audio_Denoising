function varargout = audio_player(varargin)
%deploytool  guide
% AUDIO_PLAYER MATLAB code for audio_player.fig
%      AUDIO_PLAYER, by itself, creates a new AUDIO_PLAYER or raises the existing
%      singleton*.
%
%      H = AUDIO_PLAYER returns the handle to a new AUDIO_PLAYER or the handle to
%      the existing singleton*.
%
%      AUDIO_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO_PLAYER.M with the given input arguments.
%
%      AUDIO_PLAYER('Property','Value',...) creates a new AUDIO_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audio_player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audio_player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audio_player

% Last Modified by GUIDE v2.5 29-Jan-2024 23:35:16

% Begin initialization code - DO NOISET EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audio_player_OpeningFcn, ...
                   'gui_OutputFcn',  @audio_player_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end
% End initialization code - DO NOISET EDIT

%output_values = (input_values - input_min) * (output_max - output_min) / (input_max - input_min) + output_min;

% --- Executes just before audio_player is made visible.
function audio_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audio_player (see VARARGIN)

% Choose default command line output for audio_player
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global vfact    %volume factor
global efact    %encryption factor
global rate
global orate    %orignal rate
global ostate
global estate
global fstate
global dstate
global rstate
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global m        %the music state 0=Orignal ,1 = encrypted , 2= filtered
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global playm
global file
global path
global closesavef
closesavef=0;
path="saved audio\";
file="1orignal.wav";
[oy,f]=audioread(path+file);
efact=0.01;
rate=1;
orate=1;
vfact=1;
fmode=1;
ostate=1;
estate=0;
fstate=0;
dstate=1;
rstate=1;
m=0;
playm=0;
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
[fy]=filter_audio(oy,f,0,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
set(handles.oradio,'value',1);
set(handles.eradio,'value',0);
set(handles.fradio,'value',0);
set(handles.dradio,'value',1);
set(handles.rradio,'value',0);
mpos=om.CurrentSample;

set(handles.loc,'string',path);
set(handles.fileb,'string',file);
set(handles.rateb,'string',rate);
set(handles.noiseb,'string',efact);
set(handles.volb,'string',vfact);
set(handles.volrb,'string',100);
set(handles.receiverb,'string',"On standby");
set(handles.vol,'value',0.5);
set(handles.noise,'value',0.1);
set(handles.saveb,'visible',"off");
set(handles.noise,'visible',"off");
set(handles.noiseb,'visible',"off");
set(handles.noiseT,'visible',"off");
set(handles.fmenu,'visible',"off");
set(handles.receiverb,'visible',"off");
set(handles.receiverT,'visible',"off");
set(handles.returnb,'visible',"off");
set(handles.volrT,'visible',"off");
set(handles.volrb,'visible',"off");
set(handles.persentT,'visible',"off");
set(handles.chanelsT,'visible',"off");
set(handles.radioT1,'visible',"off");
set(handles.radioT2,'visible',"off");
set(handles.radiofb,'visible',"off");
set(handles.freqT,'visible',"off");
set(handles.radio_slider,'visible',"off");

ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread("The_9_Sines_audio_denoisng_resources\audioLogo.png");
imagesc(bg);
set(ah,'handlevisibility','off','visible','off');

end
% UIWAIT makes audio_player wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = audio_player_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes during object creation, after setting all properties.
function noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function volb_Callback(hObject, eventdata, handles)
% hObject    handle to volb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volb as text
%        str2double(get(hObject,'String')) returns contents of volb as a double
end

% --- Executes during object creation, after setting all properties.
function volb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes during object creation, after setting all properties.
function vol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function volrb_Callback(hObject, eventdata, handles)
% hObject    handle to volrb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volrb as text
%        str2double(get(hObject,'String')) returns contents of volrb as a double
end

% --- Executes during object creation, after setting all properties.
function volrb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volrb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function noiseb_Callback(hObject, eventdata, handles)
% hObject    handle to noiseb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noiseb as text
%        str2double(get(hObject,'String')) returns contents of noiseb as a double
end

% --- Executes during object creation, after setting all properties.
function noiseb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiseb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function loc_Callback(hObject, eventdata, handles)
% hObject    handle to loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc as text
%        str2double(get(hObject,'String')) returns contents of loc as a double
end

% --- Executes during object creation, after setting all properties.
function loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function fileb_Callback(hObject, eventdata, handles)
% hObject    handle to fileb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileb as text
%        str2double(get(hObject,'String')) returns contents of fileb as a double
end

% --- Executes during object creation, after setting all properties.
function fileb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function rateb_Callback(hObject, eventdata, handles)
% hObject    handle to rateb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rateb as text
%        str2double(get(hObject,'String')) returns contents of rateb as a double
end

% --- Executes during object creation, after setting all properties.
function rateb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rateb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles noiseT created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function receiverb_Callback(hObject, eventdata, handles)
% hObject    handle to receiverb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of receiverb as text
%        str2double(get(hObject,'String')) returns contents of receiverb as a double

end

% --- Executes during object creation, after setting all properties.
function receiverb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to receiverb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on slider movement.
function radio_slider_Callback(hObject, eventdata, handles)
% hObject    handle to radio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function radio_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global vfact    %volume factor
global efact    %encryption factor
global rate     %speed of sound
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global mpos     %the position of the music
global playm    %check if you play or not
global file
global path
[file,path]=uigetfile('*.*');
mp=strcat(path,file);
[oy ,f]=audioread(mp);
stop(om);
stop(em);
stop(fm);
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
[fy]=filter_audio(oy,f,0,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
playm=0;
mpos=om.CurrentSample;
set(handles.loc,'string',path);
set(handles.fileb,'string',file);
end

% --- Executes on button press in dradio.
function dradio_Callback(hObject, eventdata, handles)
% hObject    handle to dradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dradio
global vfact    %volume factor
global efact    %encryption factor
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm
global mpos     %the position of the music
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global dstate
global rstate
global orate
pause(0.05);
set(handles.dradio,'value',1);
dstate=1;
set(handles.locT,'visible',"on");
set(handles.loc,'visible',"on");
set(handles.filenameT,'visible',"on");
set(handles.fileb,'visible',"on");
set(handles.rateT,'visible',"on");
set(handles.XT,'visible',"on");
set(handles.rateb,'visible',"on");
if m==1 || m==2
set(handles.saveb,'visible',"off");
end
set(handles.play,'visible',"on");
set(handles.pause,'visible',"on");
set(handles.resume,'visible',"on");
set(handles.stop,'visible',"on");
set(handles.slow,'visible',"on");
set(handles.fast,'visible',"on");
set(handles.select,'visible',"on");
set(handles.oradio,'visible',"on");
set(handles.eradio,'visible',"on");
set(handles.fradio,'visible',"on");
set(handles.receiverb,'visible',"off");
set(handles.receiverT,'visible',"off");
set(handles.returnb,'visible',"off");
set(handles.volrT,'visible',"off");
set(handles.volrb,'visible',"off");
set(handles.persentT,'visible',"off");
set(handles.chanelsT,'visible',"off");
set(handles.radioT1,'visible',"off");
set(handles.radioT2,'visible',"off");
set(handles.radiofb,'visible',"off");
set(handles.freqT,'visible',"off");
set(handles.radio_slider,'visible',"off");
if rstate==1 
    rstate=0;
    set(handles.rradio,'value',0);
    if m==0
        mpos= om.CurrentSample; 
    elseif m==1
        mpos= em.CurrentSample;
    elseif m==2
        mpos= fm.CurrentSample;
    end
    %default mode:
    efact=0.01;
    rate=orate;
    vfact=1;
    om=audioplayer(vfact.*oy,rate.*f);
    ey=encrypt_audio(oy,efact);
    em=audioplayer(vfact.*ey,rate.*f);
    [fy]=filter_audio(oy,f,0,fmode);
    fm=audioplayer(vfact.*fy,rate.*f);
    play(om,mpos);
    pause(om);              %just to save the position
    play(em,mpos);
    pause(em);              %just to save the position
    play(fm,mpos);
    pause(fm);              %just to save the position
    if playm==1 %playing
        switch m
            case 0
                play(om,mpos);
            case 1
                play(em,mpos);
            case 2
                play(fm,mpos);      
        end
    end
end

set(handles.rateb,'string',rate);
set(handles.noiseb,'string',efact);
set(handles.volb,'string',vfact);
set(handles.vol,'value',0.5);
set(handles.noise,'value',0.1);
set(handles.volT,'visible',"on");
set(handles.volb,'visible',"on");
set(handles.vol,'visible',"on");
if m==1
set(handles.noiseT,'visible',"on");
set(handles.noiseb,'visible',"on");
set(handles.noise,'visible',"on");
end
if m==2
set(handles.fmenu,'visible',"on");    
end

end

% --- Executes on button press in returnb.
function returnb_Callback(hObject, eventdata, handles)
% hObject    handle to returnb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dread
global fmr
global omr
pause(0.05);
stop(fmr);
stop(omr);
set(handles.dradio,'visible',"on");
dread=1;
end

% --- Executes on button press in rradio.
function rradio_Callback(hObject, eventdata, handles)
% hObject    handle to rradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rradio
global playm
global om       %orignal music
global omr      %orignal music received
global em       %encrypted music
global fm       %filtered music
global fmr      %filtered music received
global dstate
global rstate
global dread
global mc1      %chanel 1 FM
global yr1      %y chanel 1
global mc2      %chanel 2 FM
global yr2      %y chanel 2
global mc3      %chanel 3 FM
global yr3      %y chanel 3
global mc4      %chanel 4 FM
global yr4      %y chanel 4
global mc5      %chanel 1 AM
global yr5      %y chanel 1
global mc6      %chanel 2 AM
global yr6      %y chanel 2
global mc7      %chanel 3 AM
global yr7      %y chanel 3
global mc8      %chanel 4 AM
global yr8      %y chanel 4
global mn       %chanel noise
global yn       %y chanel noise
global choffset
%reading the chanels
pause(0.05);
[yr2,fr]=audioread("saved audio\chanel\ch2FMnormal.wav");
mc2=audioplayer(yr2,fr);
[yr3,fr]=audioread("saved audio\chanel\ch3FMDJ.wav");
mc3=audioplayer(yr3,fr);
[yr4,fr]=audioread("saved audio\chanel\ch4FMmotivation.wav");
mc4=audioplayer(yr4,fr);
[yr5,fr]=audioread("saved audio\chanel\ch1AMstory.wav");
mc5=audioplayer(yr5,fr);
[yr6,fr]=audioread("saved audio\chanel\ch2AMrelax.wav");
mc6=audioplayer(yr6,fr);
[yr7,fr]=audioread("saved audio\chanel\ch3AMnews.wav");
mc7=audioplayer(yr7,fr);
[yr8,fr]=audioread("saved audio\chanel\ch4AMrbaodcast.wav");
mc8=audioplayer(yr8,fr);
[yn,fr]=audioread("saved audio\chanel\noise.wav");
mn=audioplayer(yn,fr);
[yr1,fr]=audioread("saved audio\chanel\ch1FMreflection.wav");
mc1=audioplayer(yr1,fr);
yr=yr1;
omr=mc1;            %the default is chanel 1

pause(0.05);
set(handles.dradio,'visible',"off");
set(handles.volT,'visible',"off");
set(handles.volb,'visible',"off");
set(handles.vol,'visible',"off");
set(handles.noiseT,'visible',"off");
set(handles.noiseb,'visible',"off");
set(handles.noise,'visible',"off");
set(handles.fmenu,'visible',"off");    
set(handles.locT,'visible',"off");
set(handles.loc,'visible',"off");
set(handles.filenameT,'visible',"off");
set(handles.fileb,'visible',"off");
set(handles.rateT,'visible',"off");
set(handles.XT,'visible',"off");
set(handles.rateb,'visible',"off");
set(handles.play,'visible',"off");
set(handles.pause,'visible',"off");
set(handles.resume,'visible',"off");
set(handles.stop,'visible',"off");
set(handles.slow,'visible',"off");
set(handles.fast,'visible',"off");
set(handles.saveb,'visible',"off");
set(handles.select,'visible',"off");
set(handles.oradio,'visible',"off");
set(handles.eradio,'visible',"off");
set(handles.fradio,'visible',"off");
set(handles.receiverb,'visible',"on");
set(handles.receiverT,'visible',"on");
set(handles.returnb,'visible',"on");
set(handles.rradio,'value',1);
set(handles.receiverb,'string',"Intializing...");
set(handles.volrT,'visible',"on");
set(handles.volrb,'visible',"on");
set(handles.persentT,'visible',"on");
set(handles.chanelsT,'visible',"on");
set(handles.freqT,'string',"Frequency (FM)");
set(handles.chanelsT, 'String', {'Channels frequencies (FM):', ...
                   '  140MHz Channel 1 Reflection', ...
                   '  248MHz Channel 2 Normal   ', ...
                   '    356MHz Channel 3 DJ             ', ...
                   '    462MHz Channel 4 Motivation '});
set(handles.radioT1,'visible',"on");
set(handles.radioT2,'visible',"on");
set(handles.radiofb,'visible',"on");
set(handles.freqT,'visible',"on");
set(handles.radio_slider,'visible',"on");
startfreq=100;
endfreq=500;
freqoffset=0;
set(handles.radioT1,'string',int2str(startfreq)+"MHz");
set(handles.radioT2,'string',int2str(endfreq)+"MHz");
pause(0.05);
rstate=1;
stop(om);
stop(em);
stop(fm);
[fyr]=filter_audio(yr1,fr,0,1);
fmr=audioplayer(fyr,fr);
playm=0;    %stop
dread=0;
mrpos=omr.CurrentSample;  %restart
mr=0;       %which music is playing
playmr=0;   %check if it is playing
ch=1;       %default chanel
old_ch=1;
choffset=10;
old_mapped=100;
vol_in_mapped=100;
slider=0;
old_slider=0;
frequency=140;
set(handles.radiofb,'string',frequency+freqoffset);
slider= ((frequency - 100) / (500 - 100)) * (1 - 0) + 0;

while old_slider~=floor(100*slider)
    pause(0.01);    %change the volume smoothly
    if old_slider>100*slider
        old_slider=old_slider-1;
    elseif old_slider<100*slider
        old_slider=old_slider+1;
    end
        set(handles.radio_slider,'Value',old_slider/100);
end

ch=0;       %intial chanel
old_ch=0;
        
if dstate==1
    dread=0;
    delete(instrfind);
    arduino=serial('COM10','BaudRate',9600,'DataBits',8);
    fopen(arduino);
    set(handles.receiverb,'string',"On standby");
    vol_in=513; %default value
    while dread==0
        dstate=0;
        set(handles.dradio,'value',0);
        mes=floor(0.15);   %default
        %changing the chanels
        if ch~=old_ch && ch~=0
            [mrpos,yr,fr]=change_chanel(ch,old_ch,omr);
            if old_ch==0
                set(handles.receiverb,'string',"On standby");
            end
            omr=audioplayer(vol_in_mapped.*yr,fr);
            [fyr]=filter_audio(yr,fr,0,1);
            fmr=audioplayer(fyr,fr);
            
            if ch>=choffset
                freqoffset=1000;
                set(handles.radioT1,'string',int2str(startfreq+freqoffset)+"kHz");
                set(handles.radioT2,'string',int2str(endfreq+freqoffset)+"kKHz");
                set(handles.freqT,'string',"Frequency (AM)");
                set(handles.chanelsT, 'String', {'Chanels frequencies (AM):', ...
                   '1140kHz Chanel 1 Story', ...
                   '1248kHz Chanel 2 Relax  ', ...
                   '      1356kHz Chanel 3 News         ', ...
                   '    1462kHz Chanel 4 Baodcast '});
            else
                freqoffset=0;
                set(handles.radioT1,'string',int2str(startfreq+freqoffset)+"MHz");
                set(handles.radioT2,'string',int2str(endfreq+freqoffset)+"MHz");
                set(handles.freqT,'string',"Frequency (FM)");
                set(handles.chanelsT, 'String', {'Channels frequencies (FM):', ...
                   '  140MHz Channel 1 Reflection', ...
                   '  248MHz Channel 2 Normal   ', ...
                   '    356MHz Channel 3 DJ             ', ...
                   '    462MHz Channel 4 Motivation '});
            end
            
            if playmr==1    %we changed while playing
                %we need to map: the min input is 100 max is 500, output is min=0 max=1
                slider= ((frequency - 100) / (500 - 100)) * (1 - 0) + 0;
                disp("play from change chanel\n");
                pause(0.5);
                if mr==1
                    play(omr,mrpos);
                elseif mr==2
                    play(fmr,mrpos); 
                end
            end
            frequency=chanel_map(ch);
            set(handles.radiofb,'string',frequency+freqoffset);
            slider= ((frequency - 100) / (500 - 100)) * (1 - 0) + 0;

            while old_slider~=floor(100*slider)
                pause(0.01);    %change the volume smoothly
                if old_slider>100*slider
                    old_slider=old_slider-1;
                elseif old_slider<100*slider
                  old_slider=old_slider+1;
                end
                set(handles.radio_slider,'Value',old_slider/100);
            end

        end
        
        while rem(mes,10)~=1 && rem(mes,10)~=2 && dread==0
        pause(0.01);
        mes=fscanf(arduino);
        mes=floor(str2double(mes))
        %mes=mes;
        
        if rem(mes,1000)==0 %off mode
            mr=0;
            playmr=0;
            pause(0.05);
            stop(mc1);
            stop(mc2);
            stop(mc3);
            stop(mc4);
            stop(mn);
            stop(omr);
            stop(fmr);
            mrpos=omr.CurrentSample;
        end
        if mr==1
            mrpos= omr.CurrentSample; 
        elseif mr==2
            mrpos= fmr.CurrentSample;
        end
        
        old_vol=vol_in;
        if isnan(mes)
            vol_in=old_vol; %as it didn't change (steady state)
        else
            vol_in=floor(mes/1000);
        end
        %we need to map: the min input is 0 max is 1023, output min=0 max=2
        vol_in_mapped= ((vol_in - 0) / (1023 - 0)) * (2 - 0) + 0;
        if mrpos == 1 && playmr ==1
            %it will loop
            stop(omr);
            stop(fmr);
            mrpos=omr.CurrentSample; %to start again
            disp("play from loop\n");
            pause(0.5);
            if mr==1
                play(omr,mrpos); 
            elseif mr==2
                play(fmr,mrpos);
            end
        end
        if (vol_in>old_vol+1 || vol_in<old_vol-1) && mr~=0  %it got changed while playing
            pause(0.01);
            if mr==1
                mrpos= omr.CurrentSample;
                pause(omr);
            elseif mr==2
                mrpos= fmr.CurrentSample;
                pause(fmr);
            end
            omr=audioplayer(vol_in_mapped.*yr,fr);
            [fyr]=filter_audio(vol_in_mapped.*yr,fr,0,1);
            fmr=audioplayer(fyr,fr);
            disp("play from change volume\n");
            pause(0.5);
            if mr==1
                play(omr,mrpos);
            elseif mr==2
                play(fmr,mrpos);
            end
        end
        
        while old_mapped~=floor(100*vol_in_mapped)
        pause(0.01);    %change the volume smoothly
        if     old_mapped>100*vol_in_mapped
            old_mapped=old_mapped-1;
        elseif old_mapped<100*vol_in_mapped
            old_mapped=old_mapped+1;
        end
        set(handles.volrb,'string',old_mapped);
        end
        
        old_mapped=floor(100*vol_in_mapped);

        old_ch=ch;

        if isnan(mes)
            ch=old_ch; %as it didn't change (steady state)
        else
            ch=floor(rem(mes,1000)/10);
        end
        if ch~=old_ch || ch==0
            break;
        end
        
        end
        
        if ch==0 %it is off
            set(handles.receiverb,'string',"Off");
            continue;
        end
        pause(0.01);
        if mr==1
            mrpos= omr.CurrentSample; 
        elseif mr==2
            mrpos= fmr.CurrentSample;
        end

        if rem(mes,10) ==1 && mr~=1
            mr=1;
            playmr=1;
            set(handles.receiverb,'string',"Recevied");
            disp("play from change mode\n");
            pause(0.5);
            pause(fmr);
            play(omr,mrpos);
        else if rem(mes,10)==2 && mr~=2
            mr=2;
            playmr=1;
            set(handles.receiverb,'string',"Filtered");
            disp("play from change mode\n");
            pause(0.5);
            pause(omr);
            play(fmr,mrpos); 
            end
        end
    end
end
% Call the rradio_Callback function
stop(fmr);
stop(omr);
fclose(arduino);
if dread==1
dradio_Callback(handles.rradio, eventdata, handles);
end
end

    function [pos,ynew,fnew] = change_chanel(ch,old_ch,old_m)
    global mc1      %chanel 1 FM
    global yr1      %y chanel 1
    global mc2      %chanel 2 FM
    global yr2      %y chanel 2
    global mc3      %chanel 3 FM
    global yr3      %y chanel 3
    global mc4      %chanel 4 FM
    global yr4      %y chanel 4
    global mc5      %chanel 1 AM
    global yr5      %y chanel 1
    global mc6      %chanel 2 AM
    global yr6      %y chanel 2
    global mc7      %chanel 3 AM
    global yr7      %y chanel 3
    global mc8      %chanel 4 AM
    global yr8      %y chanel 4
    global mn       %chanel noise
    global yn       %y chanel noise
    pause(old_m);
    old_pos=old_m.CurrentSample;    %save the current position
    if old_ch==0 %it was off
        pause(0.05);
    elseif old_ch==1
        play(mc1,old_pos);
        pause(0.05);
        pause(mc1);
    elseif old_ch==2
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
    elseif old_ch==11
        play(mc5,old_pos);
        pause(0.05);
        pause(mc5);
    elseif old_ch==12
        play(mc6,old_pos);
        pause(0.05);
        pause(mc6);
    elseif old_ch==13
        play(mc7,old_pos);
        pause(0.05);
        pause(mc7);
    elseif old_ch==14
        play(mc8,old_pos);
        pause(0.05);
        pause(mc8);
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
  elseif ch==11
    ynew=yr5;
    fnew=mc5.SampleRate;
    pos=mc5.CurrentSample;
  elseif ch==12
    ynew=yr6;
    fnew=mc6.SampleRate;
    pos=mc6.CurrentSample;
  elseif ch==13
    ynew=yr7;
    fnew=mc7.SampleRate;
    pos=mc7.CurrentSample;
  elseif ch==14
    ynew=yr8;
    fnew=mc8.SampleRate;
    pos=mc8.CurrentSample;
  else
    ynew=yn;
    fnew=mn.SampleRate;
    pos=mn.CurrentSample;
  end
   
    end
   
    function [f] = chanel_map(ch)
        global choffset
        %{
        the map:
        ch=1 f=140
        ch=2 f=248
        ch=3 f=356
        ch=4 f=462
        ch=5 f=204
        ch=6 f=292
        ch=7 f=410
        %}
        if ch>choffset
            ch_mapped=ch-choffset;
        else
            ch_mapped=ch;
        end
        if ch_mapped==1
            f=140;
        elseif ch_mapped==2
            f=248;
        elseif ch_mapped==3
            f=356;
        elseif ch_mapped==4
            f=462;
        elseif ch_mapped==5
            f=204;
        elseif ch_mapped==6
            f=292;
        elseif ch_mapped==7
            f=410;
        end
    end

% --- Executes on button press in oradio.
function oradio_Callback(hObject, eventdata, handles)
% hObject    handle to oradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of oradio
global estate
global fstate
global ostate
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music 
global playm
set(handles.oradio,'value',1);
ostate=1;
m=0;
if (estate==1)||(fstate==1)  %if it is on it will not do anything
    set(handles.eradio,'value',0);
    set(handles.fradio,'value',0);

    if estate==1
        mpos=em.CurrentSample;  %save it before you stop it
        stop(em);
    elseif fstate==1
        mpos=fm.CurrentSample;  %save it before you stop it
        stop(fm);       
    end
    estate=0;
    fstate=0;

    play(om,mpos);
    pause(om);              %just to save the position
    if playm==1
        play(om,mpos);
    end
end

set(handles.fmenu,'visible',"off");
set(handles.noise,'visible',"off");
set(handles.noiseb,'visible',"off");
set(handles.noiseT,'visible',"off");
end

% --- Executes on button press in eradio.
function eradio_Callback(hObject, eventdata, handles)
% hObject    handle to eradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eradio
global estate
global fstate
global ostate
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music 
global playm
set(handles.eradio,'value',1);
estate=1;
m=1;

if (ostate==1)||(fstate==1)  %if it is on it will not do anything
    set(handles.oradio,'value',0);
    set(handles.fradio,'value',0);

    if ostate==1
        mpos=om.CurrentSample;  %save it before you stop it
        stop(om);
    elseif fstate==1
        mpos=fm.CurrentSample;  %save it before you stop it
        stop(fm);    
    end
    ostate=0;
    fstate=0;

    play(em,mpos);
    pause(em);              %just to save the position
    if playm==1
        play(em,mpos);
    end
end

set(handles.fmenu,'visible',"off");
set(handles.saveb,'visible',"on");
set(handles.noise,'visible',"on");
set(handles.noiseb,'visible',"on");
set(handles.noiseT,'visible',"on");
end

% --- Executes on button press in fradio.
function fradio_Callback(hObject, eventdata, handles)
% hObject    handle to fradio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fradio
global ostate
global estate
global fstate
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global f
global oy
global fy
global fmode    %which filter will be used
global vfact    %volume factor
global rate
global mpos     %the position of the music 
global playm
set(handles.fradio,'value',1);
fstate=1;
m=2;

if (ostate==1)||(estate==1)  %if it is on it will not do anything
    set(handles.oradio,'value',0);
    set(handles.eradio,'value',0);

    if ostate==1
        mpos=om.CurrentSample;  %save it before you stop it
        stop(om);
    elseif estate==1
        mpos=em.CurrentSample;  %save it before you stop it
        stop(em);    
    end
    ostate=0;
    estate=0;
    [fy]=filter_audio(oy,f,1,fmode);
    fm=audioplayer(vfact.*fy,rate.*f);
    play(fm,mpos);
    pause(fm);              %just to save the position
    if playm==1
        play(fm,mpos);
    end
end

set(handles.fmenu,'visible',"on");
set(handles.saveb,'visible',"on");
set(handles.noise,'visible',"off");
set(handles.noiseb,'visible',"off");
set(handles.noiseT,'visible',"off");
end

% --- Executes on selection change in fmenu.
function fmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fmenu
global vfact
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global f
global oy
global fy
global fmode    %which filter will be used

if m==0
    mpos= om.CurrentSample; 
elseif m==1
    mpos= em.CurrentSample;
elseif m==2
    mpos= fm.CurrentSample;    
end

fmode=get(hObject,'Value');    %filter selection 1=wave, 2=FIR
%we need to filter the music
om=audioplayer(vfact.*oy,rate.*f);
[fy]=filter_audio(oy,f,1,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
play(om,mpos);
play(fm,mpos);
pause(om);
pause(fm);

if playm==1 %playing
    play(fm,mpos);    
end

end

% --- Executes during object creation, after setting all properties.
function fmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global playm
global mpos     %the position of the music
stop(em);
stop(om);
stop(fm);
mpos=om.CurrentSample;  %restart
if m==0
    play(om);
elseif m==1
    play(em);
elseif m==2
    play(fm);
end
playm=1;
end

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global playm
global mpos     %the position of the music
pause(em);
pause(om);
pause(fm);
if m==0
    mpos=om.CurrentSample;
elseif m==1
    mpos=em.CurrentSample;
elseif m==2
    mpos=fm.CurrentSample;    
end
playm=0;
end

% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music 
global playm
if m==0
    play(om,mpos);
elseif m==1
    play(em,mpos);
elseif m==2
    play(fm,mpos);
end
playm=1;
end

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global playm
global mpos     %the position of the music
stop(em);
stop(om);
stop(fm);
playm=0;    %stop
mpos=om.CurrentSample;  %restart
end

% --- Executes on button press in fast.
function fast_Callback(hObject, eventdata, handles)
% hObject    handle to fast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vfact    %volume factor
global efact    %encryption factor
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global dstate
global orate
set(handles.dradio,'value',0);
dstate=0;

if m==0
    mpos= om.CurrentSample; 
elseif m==1
    mpos= em.CurrentSample;
elseif m==2
    mpos= fm.CurrentSample;
end

rate=rate+0.2*orate;
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
[fy]=filter_audio(oy,f,0,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
play(om,mpos);
play(em,mpos);
play(fm,mpos);
pause(om);
pause(em);  
pause(fm);  
if playm==1 %playing
    switch m
        case 0
            play(om,mpos);
        case 1
            play(em,mpos);
        case 2
            play(fm,mpos);    
    end
end
set(handles.rateb,'string',rate);
set(handles.saveb,'visible',"on");
end

% --- Executes on button press in slow.
function slow_Callback(hObject, eventdata, handles)
% hObject    handle to slow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vfact    %volume factor
global efact    %encryption factor
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global dstate
global orate
set(handles.dradio,'value',0);
dstate=0;

if m==0
    mpos= om.CurrentSample; 
elseif m==1
    mpos= em.CurrentSample;
elseif m==2
    mpos= fm.CurrentSample;    
end

rate=rate-0.2*orate;
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
[fy]=filter_audio(oy,f,0,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
play(om,mpos);
play(em,mpos);
play(fm,mpos);
pause(om);
pause(em);
pause(fm);
if playm==1 %playing
    switch m
        case 0
            play(om,mpos);
        case 1
            play(em,mpos);
        case 2
            play(fm,mpos);    
    end
end
set(handles.rateb,'string',rate);
set(handles.saveb,'visible',"on");

end

% --- Executes on slider movement.
function vol_Callback(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global vfact    %volume factor
global efact    %encryption factor
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global f
global oy
global ey
global fy
global fmode    %which filter will be used
global dstate
set(handles.dradio,'value',0);
dstate=0;

if m==0
    mpos= om.CurrentSample; 
elseif m==1
    mpos= em.CurrentSample;
elseif m==2
    mpos= fm.CurrentSample;
end

vr=get(hObject,'Value');    %volume read
if vr>=0.5  %increase the vol
   %we need to map as the min input is 0.5 max is 1, output min=1 max=5
   vfact=((vr-0.5)/0.5)*(5-1)+1;
else
   %we need to map as the min input is 0 max is 0.5, output min=0 max=0.2
   vfact=((vr-0)/0.5)*(0.5)+0;
end
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
[fy]=filter_audio(oy,f,0,fmode);
fm=audioplayer(vfact.*fy,rate.*f);
play(om,mpos);
play(em,mpos);
play(fm,mpos);
pause(om);
pause(em);
pause(fm);
if playm==1 %playing
    switch m
        case 0
            play(om,mpos);
        case 1
            play(em,mpos);
        case 2
            play(fm,mpos);    
    end
end
set(handles.volb,'string',vfact);
set(handles.saveb,'visible',"on");
end

% --- Executes on slider movement.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global vfact
global efact    %encryption factor
global rate     %speed of sound
global playm
global m
global om       %orignal music
global em       %encrypted music
global fm       %filtered music
global mpos     %the position of the music
global f
global oy
global ey
global dstate
set(handles.dradio,'value',0);
dstate=0;

if m==0
    mpos= om.CurrentSample; 
elseif m==1
    mpos= em.CurrentSample;
elseif m==2
    mpos= fm.CurrentSample;    
end

nr=get(hObject,'Value');    %noise read
%we need to map as the min input is 0 max is 1, output min=0 max=0.1
efact=((nr-0)/1)*(0.1-0)+0;
om=audioplayer(vfact.*oy,rate.*f);
ey=encrypt_audio(oy,efact);
em=audioplayer(vfact.*ey,rate.*f);
play(om,mpos);
play(em,mpos);
pause(om);
pause(em);
if playm==1 %playing
    play(em,mpos);    
end
set(handles.noiseb,'string',efact);
set(handles.saveb,'visible',"on");
set(handles.noise,'visible',"on");
set(handles.noiseb,'visible',"on");
set(handles.noiseT,'visible',"on");
end

% --- Executes on button press in saveb.
function saveb_Callback(hObject, eventdata, handles)
% hObject    handle to saveb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vfact
global rate     %speed of sound
global f
global oy
global ey
global fy
global m
global om
global em
global fm       %filtered music
global closesavef
global savedfile
global ext
sm=audioplayer(vfact*oy,rate*f); %saved audio
msgbox("Choose the path to save the audio","Attention");
pause(3);
path=uigetdir();
savefigure=openfig("saveAudio.fig");
while closesavef==0
    %to delay
    pause(0.5);
end
closesavef=0; %to restart
close(savefigure);
savedfilep=path+"\"+savedfile; %file path
%normal audio
if m==0
    audiowrite(savedfilep,vfact*oy,rate*f);
elseif m==1
    audiowrite(savedfilep,vfact*ey,rate*f);
    sm=audioplayer(vfact*ey,rate*f);
elseif m==2
    audiowrite(savedfilep,vfact*fy,rate*f);
    sm=audioplayer(vfact*fy,rate*f);    
end
msgbox("The audio is saved","Message");
pause(3);
pause(om);
pause(em);
pause(fm);
stop(sm);
play(sm);
pause(5);
pause(sm);
end
