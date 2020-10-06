function [MDC, MAC, Imagpart, Realpart] = compute_7phases(image)
%% compute_7phases.m
% Description: function to demodulate image with 7 phases (0°, 90°, 180°, 270°, 360°, 450°, 540°).
% High-quality SFDI demodulation
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
%%
I1 = single(image(:,:,1,1));
I2 = single(image(:,:,1,2));
I3 = single(image(:,:,1,3));
I4 = single(image(:,:,1,4));
I5 = single(image(:,:,1,5));
I6 = single(image(:,:,1,6));
I7 = single(image(:,:,1,7));

a17 = I1-I7;
a35 = I3-I5;
a26 = I2-I6;

b17 = I1+I7;
b35 = I3+I5;
b26 = I2+I6;  

%% MDC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First version with 4 phases only: usually gives better image quality for MDC due to
%phase noise in 7 phases method
MDC = (I1 +I2 +I3 +I4)./4; %%%% MDC with 4 phases

%% MDC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Second version with 7 phases
%  cosalpha3 = (b35 - b17)./(2*(b26 - (2.*I4))); 
%  MDC = sqrt((I4 - ((b35- (2.*I4))./(2* (cosalpha3 - 1))) ).^2);  %%%% MDC with 7 phases


%% Imaginary part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Imagpart = a17-(3.*a35);   %%%% Imaginary part

%% Real part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Realpart = ( 2.*((b26-(2.*I4)))  );  %%%% Real part

%% MAC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AC = ( Imagpart.^2 + Realpart.^2 );
MAC = sqrt(AC)/8; %%%% MAC 

end