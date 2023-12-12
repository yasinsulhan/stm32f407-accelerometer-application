function varargout = arayuz_3(varargin)
% ARAYUZ_3 MATLAB code for arayuz_3.fig
%      ARAYUZ_3, by itself, creates a new ARAYUZ_3 or raises the existing
%      singleton*.
%
%      H = ARAYUZ_3 returns the handle to a new ARAYUZ_3 or the handle to
%      the existing singleton*.
%
%      ARAYUZ_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARAYUZ_3.M with the given input arguments.
%
%      ARAYUZ_3('Property','Value',...) creates a new ARAYUZ_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before arayuz_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to arayuz_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help arayuz_3

% Last Modified by GUIDE v2.5 11-Dec-2023 12:58:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arayuz_3_OpeningFcn, ...
                   'gui_OutputFcn',  @arayuz_3_OutputFcn, ...
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


% --- Executes just before arayuz_3 is made visible.
function arayuz_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arayuz_3 (see VARARGIN)

% Choose default command line output for arayuz_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes arayuz_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = arayuz_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val = get(handles.popupmenu1,'Value')

if(val == 1)
    set(handles.edit4,'String',"COM1 Port has been chosen.");

elseif(val == 2)
    set(handles.edit4,'String',"COM2 Port has been chosen.");

elseif(val == 3)
    set(handles.edit4,'String',"COM3 Port has been chosen.");

elseif(val == 4)
    set(handles.edit4,'String',"COM4 Port has been chosen.");

elseif(val == 5)
    set(handles.edit4,'String',"COM5 Port has been chosen.");

elseif(val == 6)
    set(handles.edit4,'String',"COM6 Port has been chosen.");   
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(handles.popupmenu1,'Value')

% disp(deneme);
% öncelikle bir tane "true" boolean degiskeni olustur. Ardından, stop butonuna
% basılırsa degisken "false olsun" false oldugu anda ise donguden çıkıp
% baglı olunan portu kapatsın.

if(value == 4)
    
    
    % set(handles.edit4,'String',"COM4 Port has been connected.",'ForegroundColor',"#77AC30",'fontweight',"bold");
    delete(instrfindall);
    comport=serial('COM4','BaudRate',9600,'DataBits',8);
    set(comport,'Parity','none');
    fopen(comport);
    x=1;
    
    set(handles.edit4,'String',"COM4 Port has been connected.",'ForegroundColor',"#77AC30",'fontweight',"bold");
    
    while(1)
        
        
        axis([0 400 -4500 4500]);
    
        x=x+1;
        if(x>400)
            f=400;
        end 
        
        if(x<401)
            f=x;
        end
        
        % if(push_button1_control == 1)
        %     break
        % end

        y1(f)=fscanf(comport,'%d');
        y2(f)=fscanf(comport,'%d');
        y3(f)=fscanf(comport,'%d');

        x_axis = y1(f);
        y_axis = y2(f);
        z_axis = y3(f);
    
        set(handles.edit1,'String',num2str(x_axis));
        set(handles.edit2,'String',num2str(y_axis));
        set(handles.edit3,'String',num2str(z_axis));

        plot(y1,'b','linewidth',1);
        grid on;    
        hold on;
        plot(y2,'r','linewidth',1);
        grid on;
        hold on;
        plot(y3,'g','linewidth',1);
        grid on;
        hold on;    
        legend('X Axis','Y Axis','Z Axis');
        drawnow;
    
        hold off;
        if(x>=400)
            loop=0;
            while(loop<399)
                loop=loop+1;
                y1(loop)=y1(loop+1);
                y2(loop)=y2(loop+1);
                y3(loop)=y3(loop+1);
            end

        end
    end
    
        fclose(comport);
        delete(comport);
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
