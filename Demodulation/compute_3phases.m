

function [MDC, MAC, Imagpart, Realpart] = compute_3phases(image)
%% compute_3phases.m
% Description: function to demodulate images with 3 phases (0?, 120?, 240?).
% Standard SFDI demodulation
% See "Spatial Frequency Domain Imaging in 2019: Principles, Applications
% and Perspectives" - https://doi.org/10.1117/1.JBO.24.7.071613
% =========================================================================
% Input: image(nPixelH,nPixelW,1,nPhase)
% Output: MDC, MAC, Imagpart (Imaginary part), Realpart (Real part)
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Luca Baratelli     - baratelli@unistra.fr
%              Enagnon Aguénounon - faguenounon@unistra.fr
%==========================================================================
im01 = single(image(:,:,1,1));
im02 = single(image(:,:,1,2));
im03 = single(image(:,:,1,3));

%% MDC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MDC = (im01+im02+im03)./3; %%%% MDC

%% MAC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AC =  2*((im01-im02).^2 +(im02-im03).^2 + (im03-im01).^2);
MAC = sqrt(AC)/3; %%%% MAC 

%% Imaginary part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Imagpart = sqrt(3)* (im01-im03); %%%% Imaginary part

%% Real part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Realpart = (2*im02-im01-im03); %%%% Real part

end
