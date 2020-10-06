
function [sample_Rdc, sample_Rac] = compute_Rd(phantom_Mdc,phantom_Mac,sample_Mdc,sample_Mac,calib_Rdc, calib_Rac)
%%  compute_Rd.m 
% Description: Compute diffuse reflectance at low (DC) and high (AC)
% spatial frequencies
% See "Spatial Frequency Domain Imaging in 2019: Principles, Applications
% and Perspectives" - https://doi.org/10.1117/1.JBO.24.7.071613
%==========================================================================
% Input: 
% 1) phantom_Mdc : MDC calibration image
% 2) phantom_Mac : MAC calibration image
% 3) sample_Mdc : MDC sample image
% 4) sample_Mac : MAC sample image
% 5) calib_Rdc : calibration diffuse reflectance fx=0
% 6) calib_Rac : calibration diffuse reflectance fx>0
%--------------------------------------------------------------------------
% Output:
% 1) sample_Rdc : sample diffuse reflectance fx=0
% 2) sample_Rac : sample diffuse reflectance fx>0
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Enagnon Aguénounon - faguenounon@unistra.fr
%==========================================================================

%% DC part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sample_Rdc = calib_Rdc * (sample_Mdc./phantom_Mdc);
%% AC part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sample_Rac = calib_Rac * (sample_Mac./phantom_Mac);