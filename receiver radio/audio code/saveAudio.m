function varargout = saveAudio(varargin)
% SAVEAUDIO MATLAB code for saveAudio.fig
%      SAVEAUDIO, by itself, creates a new SAVEAUDIO or raises the existing
%      singleton*.
%
%      H = SAVEAUDIO returns the handle to a new SAVEAUDIO or the handle to
%      the existing singleton*.
%
%      SAVEAUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEAUDIO.M with the given input arguments.
%
%      SAVEAUDIO('Property','Value',...) creates a new SAVEAUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saveAudio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saveAudio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saveAudio

% Last Modified by GUIDE v2.5 14-Aug-2023 20:58:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saveAudio_OpeningFcn, ...
                   'gui_OutputFcn',  @saveAudio_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before saveAudio is made visible.
function saveAudio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saveAudio (see VARARGIN)

% Choose default command line output for saveAudio
global savefigure
handles.output = hObject;
savefigure=hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saveAudio wait for user response (see UIRESUME)
% uiwait(handles.savefigure);
%default name:
global filename
global ext
global closesavef
closesavef=0;
filename="savedAudio";
ext=".mp3";


% --- Outputs from this function are returned to the command line.
function varargout = saveAudio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nameb_Callback(hObject, eventdata, handles)
% hObject    handle to nameb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nameb as text
%        str2double(get(hObject,'String')) returns contents of nameb as a double
global filename
filename=get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function nameb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nameb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in extmenu.
function extmenu_Callback(hObject, eventdata, handles)
% hObject    handle to extmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns extmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from extmenu
global ext
menuv=get(hObject,'Value');

switch menuv
    case 2
        ext=".flac";
    case 3
        ext=".m4a";
    case 4
        ext=".oga";
    case 5
        ext=".ogg";
    case 6
        ext=".wav";
end

        
        
% --- Executes during object creation, after setting all properties.
function extmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okb.
function okb_Callback(hObject, eventdata, handles)
% hObject    handle to okb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global ext
global savedfile
global closesavef
global savefigure
savedfile=filename+ext;
closesavef=1;
set(savefigure,'visible','off');
