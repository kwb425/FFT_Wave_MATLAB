%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record button callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.15. v1.1.
%                                                        2017.03.16. v1.2.
%                                                        2017.03.18. v1.3.
%                                                        2017.03.20. v1.4.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% pb_record_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%%
function pb_record_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = get(hObject, 'parent');
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%
% Intializing
%%%%%%%%%%%%%
if strcmp(get(S.pb_record, 'string'), 'Record')
    
    %%% UI change
    set(S.pb_record, ...
        'string', 'Recording', ...
        'enable', 'off')
    
    %%% Start!
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(S.record_obj, 'userdata', S) % S.record_obj's userdata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    record(S.record_obj)
    
    
    
    %%%%%%%%%%
    % Stopping
    %%%%%%%%%%
elseif strcmp(get(S.pb_record, 'string'), 'Stop')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    uppermost_recorder = S.record_obj;
    S = get(uppermost_recorder, 'userdata'); % S.record_obj's userdata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Killing the recorder
    stop(S.record_obj)
    
    %%% UI change
    set(S.pb_record, ...
        'string', 'Averaging', ...
        'enable', 'off')
    
    %%% Preparing for cutting
    S = prepare_cut(S);
    
    %%% UI change
    set(S.pb_record, ...
        'string', 'Adjust!')
    set(S.pb_pbefore, ...
        'enable', 'on')
    set(S.pb_reset, ...
        'enable', 'on')
    
    %%% Necessary callbacks ready
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(S.fg, 'userdata', S) % S.fg's userdata
    set(S.fg, 'windowbuttondownfcn', @mouse_down_callback)
    set(S.fg, 'windowbuttonupfcn', @mouse_up_callback)
    set(S.pb_pbefore, 'callback', @pb_pbefore_callback)
    set(S.pb_pafter, 'callback', @pb_pafter_callback)
    set(S.pb_reset, 'callback', @pb_reset_callback)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end