function [out, t]= dehaze(I,level,N, t0)
if (~exist('t0','var'))
  t0 = 0.3;
end

if (~exist('N','var'))
  N = 8;
end

d = 2.^level;

dark = opendarkchannel(I,N);
A = atmlight(I,dark);

transmission = transmissionEstimate(I, A);

jointImg = rgb2gray(I);
transmission = guidedfilter(jointImg, transmission ,ceil(30/d), 0.0001);
t= RF(transmission,10,0.1,3,jointImg);

out = recover(I, t, A, t0);
end



