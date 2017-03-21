%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mouse up callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.18. v1.1.
%                                                        2017.03.20. v1.2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% mouse_up_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%%%
function mouse_up_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = hObject;
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
set(S.fg, 'windowbuttonmotionfcn', {}) % De-activating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end