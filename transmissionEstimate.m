function transmission = transmissionEstimate(im, A , N)
if (~exist('N','var'))
  N = 15;
end
omega = 0.95; % the amount of haze we're keeping

im3 = zeros(size(im));
for ind = 1:3 
    im3(:,:,ind) = im(:,:,ind)./A(ind);
end

transmission = 1-omega*opendarkchannel(im3,N);
