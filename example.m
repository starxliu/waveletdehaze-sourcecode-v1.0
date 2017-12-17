% Matlab demo code for "Efficient Single Image Dehazing and Denosing: An Efficient Multi-scale Correlated Wavelet Approach" (CVIU 2017)
% 
% created by He Zhang (hezhang91@gmail.com)
% 
% Copyright @ He Zhang and Xin Liu, 2017.
% This software is free for academic usage under the permissive BSD license. If you publish results obtained using this software, please cite our paper.

clear all; close all; clc;

f = im2double(imread('image/hqu_village.png'));
%f = im2double(imread('image/cone_0.02.png'));
%f = im2double(imread('image/tiananmen.png'));
d = waveletdehaze(f);
%% Increase exposure
adj_percent = [0.001, 0.999];
img_dehazed = adjust(d,adj_percent);
imshow([f img_dehazed])