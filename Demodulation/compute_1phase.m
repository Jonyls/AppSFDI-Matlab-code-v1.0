function [MDC, MAC, Imagpart, Realpart] = compute_1phase(image, mask_DC, mask_AC, mask_PH)
%% compute_1phase.m
% Description: function to demodulate an image with a single phase.
% SSOP Filtering
% See "Single snapshot of optical properties image quality improvement
% using anisotropic 2D windows filtering" - https://doi.org/10.1117/1.JBO.24.7.071611
% =========================================================================
% Input: image(nPixelH,nPixelW)
% Output: MDC, MAC, Imagpart (Imaginary part), Realpart (Real part)
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Luca Baratelli     - baratelli@unistra.fr
%              Enagnon Aguénounon - faguenounon@unistra.fr
%==========================================================================
%%
im01 = image;

%% FFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im01_fft = fft2(im01);

%% MDC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MDC = abs (ifft2(mask_DC.* fftshift(im01_fft))); %%%% MDC 

%% MAC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MAC = abs (ifft2(mask_AC.* fftshift(im01_fft))); %%%% MAC 

%% Imaginary part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Imagpart = imag(ifft2(im01_fft.* fftshift(mask_PH)));%%%% Imaginary part

%% Real part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Realpart = real(ifft2(im01_fft.* fftshift(mask_PH)));%%%% Real part

end