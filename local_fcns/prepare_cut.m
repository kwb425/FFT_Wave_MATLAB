%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cutting prepartion (not callback)
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.18. v1.1.
%                                                        2017.03.20. v1.2.
%                                                        2017.03.21. v1.3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Ready-to-cut %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = prepare_cut(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = varargin{1};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%
% Average spectrum
%%%%%%%%%%%%%%%%%%

%%% Calculating with visual effect
spec_amp_sum = 0; % Dummy for below plot
for each_spectrum = 1:length(S.spec_amp_handles)
    set(S.spec_amp_handles(each_spectrum), 'color', 'red')
    drawnow
    % Pause for visual effect
    pause(0.2)
    % Stacking
    spec_amp_sum = ...
        spec_amp_sum + S.spec_amp(:, each_spectrum); 
    delete(S.spec_amp_handles(each_spectrum))
end

%%% Plotting the average spectrum
% Averaging
S.spec_amp_average = ...
    spec_amp_sum / length(S.spec_amp); 
% Resetting everything
reset(S.ax_spec)
% Plotting
plot(S.ax_spec, ...
    S.nyquist_x_axis, ...
    S.spec_amp_average, ...
    'b');
title(S.ax_spec, 'Average Spectrum', 'fontsize', 15)
xlabel(S.ax_spec, '\fontsize{12}\color{red}frequency')
ylabel(S.ax_spec, '\fontsize{12}\color{red}relative amp')

%%% Boxing
bottom = min(get(S.ax_spec, 'ylim'));
top = max(get(S.ax_spec, 'ylim'));
S.left_bar = line(S.ax_spec, ...
    repmat(S.left_freq, 10, 1), ...
    linspace(bottom, top, 10), ...
    'color', 'red', ...
    'linewidth', S.linewidth);
S.right_bar = line(S.ax_spec, ...
    repmat(S.right_freq, 10, 1), ...
    linspace(bottom, top, 10), ...
    'color', 'red', ...
    'linewidth', S.linewidth);
S.inbetween_bars = patch(...
    [S.left_freq, S.right_freq, S.right_freq, S.left_freq], ...
    [bottom, bottom, top, top], ...
    'red', ...
    'facealpha', 0.5); % Translucent boxing



%%%%%%%%%%%%%%%%
% For later IFFT
%%%%%%%%%%%%%%%%
% Whole recording unit's length 
S.wav_length_whole = length(S.wav);
% For later data manipulation (not for plot this time)
S.nyquist_x_axis_whole = ...
    S.sr * (1:S.wav_length_whole/2) / S.wav_length_whole; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varargout{1} = S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end