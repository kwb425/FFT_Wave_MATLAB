%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mouse motion callback
%
%                                                  Written by Kim, Wiback,
%                                                        2017.03.18. v1.1.
%                                                        2017.03.20. v1.2.
%                                                        2017.03.21. v1.3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% mouse_motion_callback(hobject , evendata, varargin) %%%%%%%%%%%%%%%%%%%
function mouse_motion_callback(hObject, ~, ~)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppermost_figure = hObject;
S = get(uppermost_figure, 'userdata'); % S.fg's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start condition -> 2 cases
% -> Otherwise return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Active only on S.ax_spec (start condition)
current_point = get(S.ax_spec, 'currentpoint');
S.x = round(current_point(1)); % Rounding for integer indexing
S.y = current_point(3);
% Stay in S.ax_spec.
if S.x <= S.nyquist && ...
        S.x >= min(xlim(S.ax_spec)) && ...
        S.y <= max(ylim(S.ax_spec)) && ...
        S.y >= min(ylim(S.ax_spec))
    
    %%% When the mouse is clicked around the left bar (case 1)
    if S.left_freq - S.minimum_box <= S.x ...
            && S.x <= S.left_freq + S.minimum_box ...
            && S.x + S.minimum_box <= S.right_freq
        % Change the left bar location.
        set(S.left_bar, 'xdata', ...
            repmat(S.x, 10, 1))
        % Change the inbetween area.
        set(S.inbetween_bars, 'xdata', ...
            [S.x, S.right_freq, S.right_freq, S.x])
        % Coordinate update for data manipulation
        S.left_freq = S.x;
        % Axes frequency coordinate -> Data index of the whole recorded wav
        S = freq_2_index(S);
        % The whole wav -> FFT (windowing unnecessary) -> Cut -> IFFT 
        S.spec_amp_pha_whole = fft(S.wav); % Amp + Phase
        % Make a copy, since this loop has to iterate infinitely.
        copy_spec_amp_pha_whole = S.spec_amp_pha_whole;
        % Since double sided, cut both side.
        copy_spec_amp_pha_whole(S.left_index:S.right_index) = 0;
        copy_spec_amp_pha_whole(...
            end-S.right_index+1:end-S.left_index+1) = 0;
        % IFFT
        wav_after_cut = ifft(copy_spec_amp_pha_whole);
        % Real part for plot
        wav_after_cut = real(wav_after_cut);
        % Saving for playing
        S.wav_cut = wav_after_cut;
        % Plot
        hold(S.ax_wav, 'off')
        plot(S.ax_wav, S.wav_cut);
        
        %%% When the mouse is clicked around the right bar (case 2)
    elseif S.right_freq - S.minimum_box <= S.x ...
            && S.x <= S.right_freq + S.minimum_box ...
            && S.left_freq <= S.x - S.minimum_box
        % Change the right bar location.
        set(S.right_bar, 'xdata', ...
            repmat(S.x, 10, 1))
        % Change the inbetween area.
        set(S.inbetween_bars, 'xdata', ...
            [S.left_freq, S.x, S.x, S.left_freq])
        % Coordinate update for data manipulation
        S.right_freq = S.x;
        % Axes frequency coordinate -> Data index of the whole recorded wav
        S = freq_2_index(S);
        % The whole wav -> FFT (windowing unnecessary) -> Cut -> IFFT 
        S.spec_amp_pha_whole = fft(S.wav); % Amp + Phase
        % Make a copy, since this loop has to iterate infinitely.
        copy_spec_amp_pha_whole = S.spec_amp_pha_whole;
        % Since double sided, cut both side.
        copy_spec_amp_pha_whole(S.left_index:S.right_index) = 0;
        copy_spec_amp_pha_whole(...
            end-S.right_index+1:end-S.left_index+1) = 0;
        % IFFT
        wav_after_cut = ifft(copy_spec_amp_pha_whole);
        % Real part for plot
        wav_after_cut = real(wav_after_cut);
        % Saving for playing
        S.wav_cut = wav_after_cut;
        % Plot
        hold(S.ax_wav, 'off')
        plot(S.ax_wav, S.wav_cut);
    end
    
    %%% Otherwise, return
else
    return
end

%%% UI change (+memory efficiency)
if strcmp(get(S.pb_pafter, 'enable'), 'off')
    set(S.pb_pafter, ...
        'enable', 'on')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(S.fg, 'userdata', S); % S.fg's userdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end