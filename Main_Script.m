%%  Main_Script.m 
% Description: Sample script to extract optical properties from raw images
% and using all functions (demodulaiton, calibration, optical properties
% extraction)
% See "Spatial Frequency Domain Imaging in 2019: Principles, Applications
% and Perspectives" - https://doi.org/10.1117/1.JBO.24.7.071613
%==========================================================================
%DO NOT FORGET TO SPECIFY THE DESIRED SPATIAL FREQUENCY AS WELL AS LINK TO
%THE APPROPRIATE CALIBRATION AND SAMPLE IMAGES
%==========================================================================
% Input: 
% Raw images
%--------------------------------------------------------------------------
% Output:
% 1) Mua : Absorption
% 2) Musp : Reduced scattering
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Enagnon Agu@nounon - faguenounon@unistra.fr
%==========================================================================
clear all
close all
addpath('.\Demodulation');
addpath('.\OP extraction');

%% Demodulation 7 phases DATA
% Calibration phantom
% load('.\Data\Calibration_phantom\PH7_calibration_0_0.mat')
% [MDC_Calibration, MAC, Imagpart, Realpart] = compute_7phases(mesdata);
% load('.\Data\Calibration_phantom\PH7_calibration_0_2.mat')
% [MDC, MAC_Calibration, Imagpart_Calibration, Realpart_Calibration] = compute_7phases(mesdata);
% Phase_Calibration = atan2(Imagpart_Calibration,Realpart_Calibration);
% 
% % Hand sample
% load('.\Data\Hand\PH7_hand_0_0.mat')
% [MDC_Hand, MAC, Imagpart, Realpart] = compute_7phases(mesdata);
% load('.\Data\Hand\PH7_hand_0_2.mat')
% [MDC, MAC_Hand, Imagpart_Hand, Realpart_Hand] = compute_7phases(mesdata);
% Phase_Hand = atan2(Imagpart_Hand,Realpart_Hand);

%% Demodulation 3 phases DATA
% Calibration phantom
load('.\Data\Calibration_phantom\PH3_calibration_0_0.mat')
[MDC_Calibration, MAC, Imagpart, Realpart] = compute_3phases(mesdata);%%只用到MDC_Calibration
load('.\Data\Calibration_phantom\PH3_calibration_0_3.mat')
[MDC, MAC_Calibration, Imagpart_Calibration, Realpart_Calibration] = compute_3phases(mesdata);%%MAC_Calibration
Phase_Calibration = atan2(Imagpart_Calibration,Realpart_Calibration);%%实部和虚部四象限反正切

% Hand sample
load('.\Data\Hand\PH3_hand_0_0.mat')
[MDC_Hand, MAC, Imagpart, Realpart] = compute_3phases(mesdata);%%MDC_Hand
load('.\Data\Hand\PH3_hand_0_3.mat')
[MDC, MAC_Hand, Imagpart_Hand, Realpart_Hand] = compute_3phases(mesdata);%%MAC_Hand
Phase_Hand = atan2(Imagpart_Hand,Realpart_Hand);

%% Demodulation 1 phase DATA % Filtering
%% Calibration phantom
% load('.\Data\Calibration_phantom\PH3_calibration_0_2.mat');
% data_1phase = mesdata(:,:,1,1);
% [mask_DC, mask_AC, mask_PH] = design_mask(data_1phase);
% [MDC_Calibration, MAC_Calibration, Imagpart, Realpart] = compute_1phase(data_1phase,mask_DC,mask_AC,mask_PH);
% Phase_Calibration = atan2(Imagpart,Realpart);
% 
% % Hand sample
% load('.\Data\Hand\PH3_hand_0_2.mat');
% data_1phase = mesdata(:,:,1,1);
% [MDC_Hand, MAC_Hand, Imagpart, Realpart] = compute_1phase(data_1phase,mask_DC,mask_AC,mask_PH);
% Phase_Hand = atan2(Imagpart,Realpart);

%% OP extraction
% Load calibration phantom diffuse reflectance
load('.\Data\Calibration_phantom\calibs_rdc_rac.mat');
fx = 0.3; % spatial frequency
% fx = 0.3; % spatial frequency
calibs_rdc = calibs_rdc_rac(1);%%[0.6141]
calibs_rac = calibs_rdc_rac((fx*10) + 1);%%[0.1111]
% Load LUTs
load('.\OP extraction\LUT\LUT_mua_fx_03.mat');
load('.\OP extraction\LUT\LUT_musp_fx_03.mat'); 
% Diffuse reflectance
[sample_Rdc, sample_Rac] = compute_Rd(MDC_Calibration,MAC_Calibration,MDC_Hand,MAC_Hand,calibs_rdc,calibs_rac);
% Optical properties
[Mua, Musp] = OP_extraction(sample_Rdc,sample_Rac,LUT_mua_fx_03,LUT_musp_fx_03);
