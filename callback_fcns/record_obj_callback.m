%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recorder's callback
%
% Notice:
% "drawnow" command is window for other function interruption,
% so whichever line you put "drawnow", and at the same time if you have
% a intteruptible callback (like push button), this recorder
% callback will be interrupted at the very line you put "drawnow".
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.15. v1.1.
%                                                        2017.03.20. v1.2.
%                                                        2017.03.21. v1.3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% record_obj_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%%%
function record_obj_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_recorder = hObject;
S = get(uppermost_recorder, 'userdata'); % S.record_obj's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%
% Count up
%%%%%%%%%%
S.iter = S.iter + 1;
S.memory_buffer = S.memory_buffer + 1;
S.spec_amp_plot_index = S.spec_amp_plot_index + 1;



%%%%%%%%%%%%%%%%%%%
% Wave Manipulation
%%%%%%%%%%%%%%%%%%%

%%% Breaking
% Extacting audio until current point
wav_until_now = getaudiodata(S.record_obj);
% Do not escape this loop until we have enough audio data to frame.
while length(wav_until_now) < 1.7*S.frame_size
    wav_until_now = getaudiodata(S.record_obj);
end

%%% Framing
wav_frame = wav_until_now(...
    (((S.iter-1)*S.frame_shift_size)+1): ...
    (((S.iter-1)*S.frame_shift_size)+1)+S.frame_size-1); % For exact size

%%% FFT
% With windowing
double_sided_spectrum = fft(wav_frame.*S.window);
% Double sided -> Single sided
single_sided_spectrum = 2 * double_sided_spectrum(1:S.frame_size/2);
% Normalization
single_sided_spectrum = abs(single_sided_spectrum / S.frame_size);
% Data saving (at every iteration)
S.spec_amp = ...
    [S.spec_amp, single_sided_spectrum]; % Only amplitude



%%%%%%
% Plot
%%%%%%

%%% View settings
if S.spec_amp_plot_index == 1 % At very first run
    hold(S.ax_wav, 'on')
    hold(S.ax_spec, 'on')
    view(S.ax_spec, [0, -0.1, 0.01])
end

%%% Wave plotting every iteration (new-parts-no-overlapping-conctenated)
length_to_plot = length(wav_until_now) - S.wav_plot_last_length;
plot(S.ax_wav, ...
    S.wav_plot_last_position:...
    S.wav_plot_last_position+length_to_plot-1, ... % For exact size
    wav_until_now(end-length_to_plot+1:end), ...
    'b');
% Data saving to avoid overlapping (at every iteration)
S.wav_plot_last_length = length(wav_until_now);
S.wav_plot_last_position = S.wav_plot_last_position+length_to_plot;

%%% Spectrum plotting every iteration (frame-wise-overlapping-concatenated)
single_sided_spectrum_handle = plot3(S.ax_spec, ...
    S.nyquist_x_axis, ...
    repmat(S.spec_amp_plot_index, length(S.nyquist_x_axis), 1), ...
    single_sided_spectrum, ...
    'b');
% Kill the ylabel for view ease.
set(S.ax_spec, 'ylabel', []) 
% Data saving for later use (at every iteration)
S.spec_amp_handles = ...
    [S.spec_amp_handles, ...
    single_sided_spectrum_handle]; % Only amplitude plot handle



%%%%%%%%%%%%%%
% Heavy memory
%%%%%%%%%%%%%%
if S.memory_buffer > S.max_buffer
    
    %%% UI change
    set(S.pb_record, ...
        'string', 'Buffering', ...
        'enable', 'off') % Disabling the button -> One can not push
    drawnow % -> This line can't be interrupt by pb_record (or anything)

    %%% Exit control
    S.exit = 1;
    
    %%% Data saving for later use (at every record)
    S.wav = [S.wav; wav_until_now]; % For later play & IFFT
    
    %%% Memory loosening
    S.iter = 0; % Re-initialization
    S.memory_buffer = 0; % Re-initialization
    S.wav_plot_last_length = 0; % Re-initialization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(S.record_obj, 'userdata', S); % S.record_obj's userdata
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    stop(S.record_obj) % Stop and re-run.
    record(S.record_obj) % Stop and re-run.
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(S.record_obj, 'userdata', S); % S.record_obj's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%
% Exit conrtrol
%%%%%%%%%%%%%%%

%%% UI change
if S.exit == 1 % Enough data gathered, can exit from now on
    set(S.pb_record, ...
        'string', 'Stop', ...
        'enable', 'on')
    % Can be interrupt by pb_record, but it's already at very 
    % end of the callback (above UI change raised by set() should be 
    % already overwritten by the interrupting function at the time
    % when program prompt get backs to below drawback command.).
    drawnow
end
end