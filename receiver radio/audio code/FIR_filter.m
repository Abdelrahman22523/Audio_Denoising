function [denoised_audio] = FIR_filter(original_audio,f, showgraph)
%FIR_FILTER Summary of this function goes here

%{
% ----------------------- Original Audio -----------------------

% Display the original audio waveform
figure;
subplot(5, 1, 1);
plot(inputAudio);
title('Original Audio');
xlabel('Time (s)');
ylabel('Amplitude');
%}
% ----------------------- FIR Filter Design and Application -----------------------

% Design the FIR filters
firFilterOrder = 8; % Adjust the filter order as needed
firCutoffFrequency = 2000/f; % Adjust the cutoff frequency as needed

% Design FIR filter with Kaiser window
kaiserWindow = kaiser(firFilterOrder+1, 4);
kaiserFilter = fir1(firFilterOrder, firCutoffFrequency, 'low', kaiserWindow);   

%{
% Design FIR filter with Hamming window
hammingWindow = hamming(firFilterOrder+1);
hammingFilter = fir1(firFilterOrder, firCutoffFrequency, 'low', hammingWindow);
%}

% Apply the FIR filters to the noisy audio signal
denoised_audio = filter(kaiserFilter, 1, original_audio);

% Plot the original and denoised signals if showgraph is true
    if showgraph
        figure;
        subplot(2, 1, 1);
        plot(original_audio,'Color', 'm');
        title('Original Noisy Signal');

        subplot(2, 1, 2);
        plot(denoised_audio,'Color', 'm');
        title('Denoised Signal');
    end

%filteredAudioHamming = filter(hammingFilter, 1, inputAudio);
%{
% ----------------------- FIR Filtered Audio Waveforms -----------------------

% Display Kaiser filtered audio waveform
subplot(5, 1, 2);
plot(filteredAudioKaiser);
title('Kaiser Filtered Audio');
xlabel('Time (s)');
ylabel('Amplitude');

% Display Hamming filtered audio waveform
subplot(5, 1, 3);
plot(filteredAudioHamming);
title('Hamming Filtered Audio');
xlabel('Time (s)');
ylabel('Amplitude');
%}

%{
% ----------------------- Measure MSE, SNR, and PSNR -----------------------

% Calculate SNR for Kaiser filtered audio
cleanPower_Kaiser = mean(inputAudio.^2);
noiseSignal_Kaiser = inputAudio - filteredAudioKaiser;
noisePower_Kaiser = mean(noiseSignal_Kaiser.^2);
SNR_Kaiser = 10 * log10(cleanPower_Kaiser / noisePower_Kaiser);

% Calculate MSE (Mean Squared Error) for Kaiser filtered audio
mseValue_Kaiser = sum((inputAudio - filteredAudioKaiser).^2) / length(inputAudio);

% Calculate PSNR (Peak Signal-to-Noise Ratio) for Kaiser filtered audio
maxAmplitude_Kaiser = max(abs(inputAudio));
psnrValue_Kaiser = 10 * log10((maxAmplitude_Kaiser.^2) / mseValue_Kaiser);

% Display the results for Kaiser filtered audio
fprintf('Kaiser Filter:\n');
fprintf('SNR: %.2f dB\n', SNR_Kaiser);
fprintf('MSE: %f\n', mseValue_Kaiser);
fprintf('PSNR: %f dB\n', psnrValue_Kaiser);

% Calculate SNR for Hamming filtered audio
cleanPower_Hamming = mean(inputAudio.^2);
noiseSignal_Hamming = inputAudio - filteredAudioHamming;
noisePower_Hamming = mean(noiseSignal_Hamming.^2);
SNR_Hamming = 10 * log10(cleanPower_Hamming / noisePower_Hamming);

% Calculate MSE (Mean Squared Error) for Hamming filtered audio
mseValue_Hamming = sum((inputAudio - filteredAudioHamming).^2) / length(inputAudio);

% Calculate PSNR (Peak Signal-to-Noise Ratio) for Hamming filtered audio
maxAmplitude_Hamming = max(abs(inputAudio));
psnrValue_Hamming = 10 * log10((maxAmplitude_Hamming.^2) / mseValue_Hamming);

% Display the results for Hamming filtered audio
fprintf('Hamming Filter:\n');
fprintf('SNR: %.2f dB\n', SNR_Hamming);
fprintf('MSE: %f\n', mseValue_Hamming);
fprintf('PSNR: %f dB\n', psnrValue_Hamming);
%}

%{
% Play the original audio
original_audio_player = audioplayer(inputAudio, Fs);
play(original_audio_player);
pause(5);
stop(original_audio_player);

% Play the filtered audio with Kaiser filter
kaiser_audio_player = audioplayer(filteredAudioKaiser, Fs);
play(kaiser_audio_player);
pause(5);
stop(kaiser_audio_player);

% Play the filtered audio with Hamming filter
hamming_audio_player = audioplayer(filteredAudioHamming, Fs);
play(hamming_audio_player);
pause(5);
stop(hamming_audio_player);
%}

end

