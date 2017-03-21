%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All parameters (not callback)
% 
% Notice: all the parameters are frame-based units, only the ones with 
%         "_whole" flag are whole-recording-based units.
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.20. v1.1.
%                                                        2017.03.21. v1.2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = params



%%%%%%%%%%%
% Constants
%%%%%%%%%%%

%%% For recording & displaying
S.sr = 44100; % Sample rate for second
S.frame_size = S.sr * 1/2; % Size of frame 500ms
S.frame_shift_size = S.sr * 5/100; % Size of frame shift 50ms
S.nyquist = S.sr * 1/2; % Nyquist frequency
S.nyquist_x_axis = ...
    S.sr * (1:S.frame_size/2) / S.frame_size; % Nyquist for plotting
S.interval = 0.1; % Interval for each record_obj_callback
S.max_buffer = 29; % To prevent blow up
S.window = hamming(length(S.frame_size)); % Windowing, hann() works too.

%%% For cutting
S.linewidth = 4; % For left & right bars
S.minimum_box = round(S.nyquist/12); % Minimum size of box



%%%%%%%%%%%
% Variables
%%%%%%%%%%%

%%% For recording & displaying & playing
S.wav = []; % To stack original waves
S.spec_amp = []; % To stack spectrums (amplitude only)
S.spec_amp_plot_index = 0; % For later spectrum plotting (amplitude only)
S.spec_amp_handles = []; % To stack spectrums handles (amplitude only)
S.wav_plot_last_position = 1; % For later wave plotting
S.wav_plot_last_length = 0; % For later wave plotting
S.memory_buffer = 0; % For later use, preventing blow-up
S.iter = 0; % Number of iteration we're on
S.exit = 0; % Quit control

%%% For cutting
S.spec_amp_average = []; % To store average spectrum (amplitude only)
% Mapping function: S.left_freq, S.right_freq 
%                   -> freq_2_index 
%                   -> S.left_index, S.right_index
S.left_freq = round(S.nyquist/4); % For plot (rounding for indexing)
S.right_freq = round(S.nyquist/3); % For plot (rounding for indexing)
S.left_index = 0; % For data manipulation
S.right_index = 0; % For data manipulation
S.left_bar = []; % To move the left bar
S.right_bar = []; % To move the right bar
S.inbetween_bars = []; % To change the inbetween boxed area
S.wav_length_whole = 0; % For later IFFT
S.nyquist_x_axis_whole = 0; % For later IFFT
S.spec_amp_pha_whole = 0; % Whole recording's spectrum (amplitude + phase)
S.wav_cut = []; % For later play (after cutting)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varargout{1} = S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end