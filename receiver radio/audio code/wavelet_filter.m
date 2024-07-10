function [denoised_audio] = wavelet_filter(original_audio, showgraph)
    original_audio = original_audio(:, 1);
    %{
    % Add white Gaussian noise
    noisy_audio = awgn(original_audio, 15, 'measured');
    %}

    % Parameters
    wavelet_name = 'db4';  % Choose a wavelet (e.g., 'db4')
    level = 9;            % Decomposition level
    threshold_type = 's';  % Soft thresholding ('s') or hard thresholding ('h')
    threshold_value = 0.101; % Adjust this threshold value based on your signal

    % Perform wavelet decomposition
    [c, l] = wavedec(original_audio, level, wavelet_name);

    % Thresholding
    c_thresh = wthresh(c, threshold_type, threshold_value);

    % Reconstruct the denoised signal
    denoised_audio = waverec(c_thresh, l, wavelet_name);

    % Plot the original and denoised signals if showgraph is true
    if showgraph
        %close all;
        figure();
        subplot(2, 1, 1);
        plot(original_audio,'Color', 'b');
        title('Original Noisy Signal');

        subplot(2, 1, 2);
        plot(denoised_audio,'Color', 'b');
        title('Denoised Signal');
    end
    %{
    % Play the original and denoised signals
    original_player = audioplayer(original_audio, fs);
    denoised_player = audioplayer(denoised_audio, fs);
    
    play(original_player);
    pause(5); % Pause to allow the first sound to finish
    pause(original_player);
    pause(1);
    play(denoised_player);
    pause(5); % Pause to allow the first sound to finish
    pause(denoised_player);
    %}
end
