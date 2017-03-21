%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Play (before) button callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.18. v1.1.
%                                                        2017.03.20. v1.2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% pb_pbefore_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%
function pb_pbefore_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = get(hObject, 'parent');
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%
% Playing
%%%%%%%%%
soundsc(S.wav, get(S.record_obj, 'samplerate'))
end