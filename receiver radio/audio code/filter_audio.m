function [fy] = filter_audio(oy,f,show,mode)
%FILTER_AUDIO Summary of this function goes here
%   Detailed explanation goes here
if mode==1
[fy]=wavelet_filter(oy,show);
elseif mode==2
[fy]=FIR_filter(oy,f,show);
elseif mode==3
[fy]=IIR_filter(oy,f,show);
end
end

