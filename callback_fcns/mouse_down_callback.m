%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mouse down callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.18. v1.1.
%                                                        2017.03.20. v1.2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% mouse_down_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%
function mouse_down_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = hObject;
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
set(S.fg, 'windowbuttonmotionfcn', @mouse_motion_callback) % Activating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end