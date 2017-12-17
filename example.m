% Matlab demo code for "Efficient Single Image Dehazing and Denosing: An Efficient Multi-scale Correlated Wavelet Approach" (CVIU 2017)
% 
% created by He Zhang (hezhang91@gmail.com)
% 
% Copyright @ He Zhang and Xin Liu, 2017.
% This software is free for academic usage under the permissive BSD license. If you publish results obtained using this software, please cite our paper.

% @article{liu2017efficient,
%   title={Efficient single image dehazing and denoising: An efficient multi-scale correlated wavelet approach},
%   author={Liu, Xin and Zhang, He and Cheung, Yiu-ming and You, Xinge and Tang, Yuan Yan},
%   journal={Computer Vision and Image Understanding},
%   volume={162},
%   pages={23--33},
%   year={2017}
% }
% 
% @article{liu2016scene,
%   title={Scene-adaptive single image dehazing via opening dark channel model},
%   author={Liu, Xin and Zhang, He and Tang, Yuan Yan and Du, Ji-Xiang},
%   journal={IET Image Processing},
%   volume={10},
%   number={11},
%   pages={877--884},
%   year={2016}
% }


clear all; close all; clc;

f = im2double(imread('image/hqu_village.png'));
%f = im2double(imread('image/cone_0.02.png'));
%f = im2double(imread('image/tiananmen.png'));
d = waveletdehaze(f);
%% Increase exposure
adj_percent = [0.001, 0.999];
img_dehazed = adjust(d,adj_percent);
imshow([f img_dehazed])
