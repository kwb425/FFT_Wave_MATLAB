%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Play (after) button callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.20. v1.1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% pb_pafter_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%%
function pb_pafter_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = get(hObject, 'parent');
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%
% Playing
%%%%%%%%%
soundsc(S.wav_cut, get(S.record_obj, 'samplerate'))
end