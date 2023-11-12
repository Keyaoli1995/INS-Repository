function RN = Cal_RE(Lati)
% Cal_RE 求解卯酉圈曲率半径
% INPUT：Lati 当地大地纬度单位：°
% OUTPUT： RE 当地卯酉圈曲率半径
% Copyright(c) 2023, by original author KY.LI, All rights reserved.
% Author: KY.LI.
% Changsha, Hunan Province P.R.China.
% 8/11/2023
global glp
RN = glp.R0/sqrt(1-glp.e^2*sin(deg2rad(Lati))^2);
end