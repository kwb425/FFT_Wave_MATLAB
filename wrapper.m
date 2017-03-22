%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fast Fourier Transform on Waves (real-time)
% This is wrapper file.
% 
% Notices:
% 1. S is mother (uppermost) structure.
% 2. All callbacks -> will be using "userdata" for information control.
%    Others -> will be using "usual function structure (input & output)".
% 3. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Codes in these strips -> information flow between functions.
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    This, will be helpful to understand how this program works.
% 4. Hierarchical structure of this program:
%                  S.fg                 <- parallel ->     S.record_obj
%    axes, buttons, etc (+callbacks)    <- parallel -> @real_time_analysis
% 5. According to 4, S.fg's userdata is "NOT SAME AS" that of S.record_obj.
% 6. Running sequence: Framing & Windowing on whole wav 
%                      (minimizing spectral leakage so one can better 
%                       distinguish filter from source, and
%                       notice unnecessary noises)
%                  -> respective FFT on the each frame
%                  -> Averaging 
%                  -> User specified range of frequency to be cut (USRFC)
%                  -> FFT on whole recored unit (whole wav)
%                  -> Cutting (using USRFC)
%                  -> IFFT 
%                  -> Display & Play
%   
%                                                  Written by Kim, Wiback,
%                                                        2017.03.12. v1.1.
%                                                        2017.03.13. v1.2.
%                                                        2017.03.14. v1.3.
%                                                        2017.03.15. v1.4.
%                                                        2017.03.16. v1.5.
%                                                        2017.03.18. v1.6.
%                                                        2017.03.20. v1.7.
%                                                        2017.03.21. v1.8.
%                                                        2017.03.22. v1.9.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Wrapper %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wrapper



%%%%%%%%%%%%%%%%
% Pre-processing
%%%%%%%%%%%%%%%%

%%% Including methods
addpath('local_fcns') 
addpath('callback_fcns')

%%% Kill everything other than this GUI.
kill



%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = params;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%
% GUI shell
%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = GUI_figure(S);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%
% Recorder
%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = record_obj(S);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Getting the record button ready
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(S.fg, 'userdata', S) % S.fg's userdata 
set(S.pb_record, 'callback', @pb_record_callback)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
