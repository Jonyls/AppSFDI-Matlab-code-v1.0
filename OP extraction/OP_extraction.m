
function [Mua, Musp] = OP_extraction(sample_Rdc,sample_Rac,LUT_mua,LUT_musp)
%%  OP_extraction.m 
% Description: Compute optical properties (absorption and reduced
% scattering from a look-up table generated from Monte Carlo 
% See "Spatial Frequency Domain Imaging in 2019: Principles, Applications
% and Perspectives" - https://doi.org/10.1117/1.JBO.24.7.071613
%==========================================================================
% Input: 
% 1) sample_Rdc : sample diffuse reflectance fx=0
% 2) sample_Rac : sample diffuse reflectance fx>0
% 3) LUT_mua : LUT for absorption
% 4) LUT_musp : LUT for reduced scattering
%--------------------------------------------------------------------------
% Output:
% 1) Mua : Absorption
% 2) Musp : Reduced scattering
%==========================================================================
% Last update: v1.0 - 2020/05/14
% @author    : Enagnon Agu�nounon - faguenounon@unistra.fr
%==========================================================================
%% Optical properties extraction
[sY, sX] = size(LUT_mua); %%sY=707 sX=972
step = 0.001;
%[A,B]=Meshgrid(a,b)����size(b)Xsize(a)��С�ľ���A��B�����൱��a��һ���ظ����ӵ�size(b)�У���bת�ó�һ�����ظ����ӵ�size(a)��
[Xq,Yq] = meshgrid(0:step:((sX/1000)-step),0:step:((sY/1000)-step));
Mua = interp2(Xq,Yq,LUT_mua,sample_Rdc,sample_Rac,'linear',0);%%'bilinear',ʹ��˫���Բ�ֵ
Musp = interp2(Xq,Yq,LUT_musp,sample_Rdc,sample_Rac,'linear',0);

end