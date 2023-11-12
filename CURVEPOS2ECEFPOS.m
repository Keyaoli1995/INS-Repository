function [varargout] = CURVEPOS2ECEFPOS(varargin)
% CURVEPOS2ECEFPOS 曲线坐标转地固系笛卡尔坐标/地固系笛卡尔坐标转曲线坐标
% 输入：可变输入，若最后提供参数'trans'，则需要提供四个参数，前三个依次为xebe,yebe,zebe;单位：m
%              若最后提供的参数不是'trans',则需要提供三个参数，依次为纬度、经度、高度输入°
% 输出：可变输入，若最后提供参数'trans'，则三个输出依次为纬度、经度、高度。单位：°;
%               若最后提供的参数不是'trans',则输出三个参数，依次为依次为xebe,yebe,zebe°单位：m
% Copyright(c) 2023, by original author KY.LI, All rights reserved.
% Author: KY.LI.
% Changsha, Hunan Province P.R.China.
% 10/11/2023

global glp;
if ischar(cell2mat(varargin(end)))
    if strcmp(cell2mat(varargin(end)),'trans') && nargin == 4
        x = cell2mat(varargin(1));
        y = cell2mat(varargin(2));
        z = cell2mat(varargin(3));
        Longi = atan2(y,x);
        k1 = sqrt(1 - glp.e^2) * abs (z);
        k2 = glp.e^2 * glp.R0;
        beta = sqrt(x^2 + y^2);
        E = (k1 - k2) / beta;
        F = (k1 + k2) / beta;
        P = 4/3 * (E*F + 1);
        Q = 2 * (E^2 - F^2);
        D = P^3 + Q^2;
        V = (sqrt(D) - Q)^(1/3) - (sqrt(D) + Q)^(1/3);
        G = 0.5 * (sqrt(E^2 + V) + E);
        T = sqrt(G^2 + (F - V * G) / (2 * G - E)) - G;
        Lati = sign(r_eb_e(3)) * atan((1 - T^2) / (2 * T * sqrt (1 - e^2)));
        RE = Cal_RE(Lati);
        hb = sqrt(x^2+y^2)/cos(Lati)-RE;
        varargout{1} = rad2deg(Lati);
        varargout{2} = rad2deg(Longi);
        varargout{3} = hb;
    elseif ~strcmp(cell2mat(varargin(end)),'trans')
        error('未能识别的参数:''%s'',您是否想输入：CURVEPOS2ECEFPOS(%s,%s,%s,''trans'')',...
            inputname(4), inputname(1), inputname(2), inputname(3));
    else
        error('输入了错误的参数数目，请检查函数输入\n');
    end
elseif isnumeric(cell2mat(varargin(end))) && nargin == 3
    Lati = deg2rad(cell2mat(varargin(1)));
    Longi = deg2rad(cell2mat(varargin(2)));
    hb = cell2mat(varargin(3));
    RE = Cal_RE(Lati);
    x = (RE + hb) * cos(Lati) * cos(Longi);
    y = (RE + hb) * cos(Lati) * sin(Longi);
    z = ((1 - glp.e) * RE + hb) * sin(Lati);
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
elseif ~isnumeric(cell2mat(varargin(end)))
    error('输入了错误的参数类型，请检查\n');
else
    error('输入了错误的参数数目，请检查函数输入\n');
end