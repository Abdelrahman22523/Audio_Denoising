function [denoised_audio] = IIR_filter(original_audio,f, showgraph)
%IIR_FILTER Summary of this function goes here
%filterOrder = input("Enter a filter order : "); % Filter order
 filterOrder=1;
 %cutoffFrequency = input("Enter a cut-off frequency  : "); % Cutoff frequency in Hz
 cutoffFrequency=1500;
 %Filter_Design = input("Enter the needed filter design  : ", 's');%Choose ['butterworth', 'chebyshev1', 'chebyshev2' & 'elliptic']
 Filter_Design="elliptic";
     % Normalize cutoff frequency
     normalizedCutoff = cutoffFrequency/(f/2);
 [b, a] = Filter_Designer(Filter_Design, filterOrder, normalizedCutoff);

% Apply the IIR filter to the audio signal
denoised_audio = filter(b, a, original_audio);

 function [b, a] = Filter_Designer(Filter_Design, filterOrder, normalizedCutoff)
 switch Filter_Design
         case 'butterworth'
             [b, a] = butter(filterOrder, normalizedCutoff, 'low');
         case 'chebyshev1'
             % Additional parameters can be added for Chebyshev Type I
             [b, a] = cheby1(filterOrder, 0.5, normalizedCutoff, 'low');
         case 'chebyshev2'
             % Additional parameters can be added for Chebyshev Type II
             [b, a] = cheby2(filterOrder, 20, normalizedCutoff, 'low');
         case 'elliptic'
             % Additional parameters can be added for elliptic filter
             [b, a] = ellip(filterOrder, 0.5, 20, normalizedCutoff, 'low');
         otherwise
             error('Unsupported filter type. Choose from Butterworth, Chebyshev1, Chebyshev2, or Elliptic.');
 end
 end



% Plot the original and denoised signals if showgraph is true
    if showgraph
        figure;
        subplot(2, 1, 1);
        plot(original_audio,'Color', 'r');
        title('Original Noisy Signal');

        subplot(2, 1, 2);
        plot(denoised_audio,'Color', 'r');
        title('Denoised Signal');
    end
    
end

