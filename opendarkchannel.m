
%  This is the reference implementation of the open dark channel
%  described in the paper:
% 
%   Scene-adaptive Single Image Dehazing via Opening Dark Channel Model
%   IET image processing, vol. 10, no. 11, pp, 877-884, 2016
%   Efficient single image dehazing and denoising: An efficient multi-scale correlated wavelet approach
%   Computer Vision and Image Understanding. Volume 162 (2017), Pages 23-33.
% Copyright @ He Zhang and Xin Liu, 2017.

function dark=opendarkchannel(I, N)
    if (~exist('N','var'))
        N = 7;
    end  
    if (isempty(N))
        N = 7;
    end
    dc = min(I, [], 3);
    se = strel('square', N);
    dark = imopen(dc, se);
return;