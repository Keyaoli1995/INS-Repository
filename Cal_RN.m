function RN = Cal_RN(Lati)
% Cal_RN 求解子午面曲率半径
% INPUT：Lati 当地大地纬度单位：°
% OUTPUT： RN 当地子午面曲率半径
% Copyright(c) 2023, by original author KY.LI, All rights reserved.
% Author: KY.LI.
% Changsha, Hunan Province P.R.China.
% 8/11/2023
global glp
RN = (glp.R0*(1-glp.e^2))/((1-glp.e^2*sin(deg2rad(Lati))^2)^1.5);
end