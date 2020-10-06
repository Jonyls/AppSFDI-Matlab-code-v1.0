
function [mask_DC, mask_AC, mask_PH] = design_mask(phantom_ssop)
%% design_mask.m 
% Description: design the filters to extract DC, AC and phase components from a 
% SSOP high frequency image. The DC filter is a bandpass filter, while the
% AC filter is a  high pass filter.
% See "Single snapshot of optical properties image quality improvement
% using anisotropic 2D windows filtering" - https://doi.org/10.1117/1.JBO.24.7.071611
%==========================================================================
% Input: 
% 1) phantom_ssop(nPixelH,nPixelW) = high frequency SSOP image of sample
%--------------------------------------------------------------------------
% Output:
% 1) mask_DC(nPixelH,nPixelW) = band pass filter mask for the DC component.
% 2) mask_AC(nPixelH,nPixelW) = high pass filter mask for the AC component.
% 2) mask_PH(nPixelH,nPixelW) = phase filter mask.
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Luca Baratelli     - baratelli@unistra.fr
%              Enagnon Aguénounon - faguenounon@unistra.fr
%==========================================================================
%%
[taille_y, taille_x] = size(phantom_ssop);

phantom_fft = fft2(phantom_ssop);

% Find spatial frequency 
Wimage1 = abs(phantom_fft(1,:));
ampmax  = max(Wimage1(1,10:(taille_x/2)));
[row1, col1] = find(Wimage1(1,1:(taille_x/2)) == ampmax); % col = cutoff freq

%% DC part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sine filter

q = col1(1);

p_x      = floor((q/2.25)*1.88);        
xcentrer = - p_x : 1 : p_x;
x        = xcentrer + p_x;              % center the mask on the x axis (DC)

p_y      = floor(taille_y*0.4999);
ycentrer = - p_y : 1 : p_y;
y        = ycentrer + p_y;              % center the mask on the y axis (DC)

N = 2*p_x + 1;
L = N-1;

M = 2*p_y + 1;
K = M - 1;

slope4    = sin((pi*x)/(N-1));          % generate the sinusoid on x (1D)
slope4bis = sin((pi*y)/(M-1));          % generate the sinusoid on y (1D)

win_2D_sine = slope4bis'*slope4;       % generate the 2D filter (DC)

imview_DC = zeros(taille_y,taille_x);

imview_DC((taille_y/2)+1-p_y:(taille_y/2)+1+p_y,(taille_x/2)+1-p_x:(taille_x/2)+1+p_x) = win_2D_sine;

mask_DC = imview_DC;

%% AC part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blackman filter 

q = col1(1);

p_x      = floor(q/1.3);
xcentrer = - p_x : 1 : p_x;
x        = xcentrer + p_x;              % center the filter on x axis (AC)

p_y      = floor(taille_y*0.4999);
ycentrer = - p_y : 1 : p_y;
y        = ycentrer + p_y;              % center the filter on y axis (AC)

N = 2*p_x + 1;
L = N - 1;

M = 2*p_y + 1;
K = M - 1;

alpha = 0.16;     % Define the parameters of the Blackman filter
a0 = (1-alpha)/2; % 7938/18608 for exact blackman
a1 = 1/2;         % 9240/18608
a2 = alpha/2;     % 1430/18608

slope7    = a0 - a1*cos((2*pi*x)/(N-1)) + a2*cos((4*pi*x)/(N-1)); % generate 1D slope on x axis
slope7bis = a0 - a1*cos((2*pi*y)/(M-1)) + a2*cos((4*pi*y)/(M-1)); % generate 1D slope on y axis

win_2D_blackman = slope7bis'*slope7;  % generate the 2D filter

imview_AC =  zeros(taille_y,taille_x);

pos = floor(q*1)-1;
imview_AC((taille_y/2)+1-p_y:(taille_y/2)+1+p_y,(taille_x/2)+1+pos-p_x:(taille_x/2)+1+pos+p_x) = win_2D_blackman;

imview_AC(:,1:(taille_x/2)+1) = 0;
imview_AC(:,(taille_x/2)+1+pos:taille_x) = 1;

mask_AC = imview_AC;


%% PH part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blackman filter 

q1 = col1(1);
p_x = floor(q1/1.3);
xcentrer = -p_x : 1 : p_x; 
x = xcentrer+p_x;              % center the filter on x axis (AC)

p_y = p_x;
ycentrer = -p_y : 1 : p_y;
y = ycentrer+p_y;              % center the filter on y axis (AC)

N= 2*p_x+1;
L = N-1;

M= 2*p_y+1;
K = M-1;

alpha = 0.16;
a0 = (1-alpha)/2; % 7938/18608 for exact blackman
a1 = 1/2;         % 9240/18608
a2 = alpha/2;     % 1430/18608

slope7 = a0 - a1*cos((2*pi*x)/(N-1)) + a2*cos((4*pi*x)/(N-1));    % generate 1D slope on x axis
slope7bis = a0 - a1*cos((2*pi*y)/(M-1)) + a2*cos((4*pi*y)/(M-1)); % generate 1D slope on y axis

win_2D_blackman = slope7bis'*slope7; % generate the 2D filter

imview_PH =  zeros(taille_y,taille_x);

pos = floor(q1*1)-1;
imview_PH((taille_y/2)+1-p_y:(taille_y/2)+1+p_y,(taille_x/2)+1+pos-p_x:(taille_x/2)+1+pos+p_x) = win_2D_blackman;

mask_PH = imview_PH;
end


