function [ey] = encrypt_audio(oy,el)
[n]=randn(size(oy))*el;   %encryption level
ey=oy+n;
end

