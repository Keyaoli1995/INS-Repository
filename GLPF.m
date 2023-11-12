function glp = GLPF(R0,f,wie)
% glpf 全局变量的定义
% 输入1：Re 地球赤道半径
% 输入2：f  
% 输入3：Wie 地球自转角速度
% 若未输入参数，则默认使用WGS-84坐标系
% Copyright(c) 2023, by original author KY.LI, All rights reserved.
% Author: KY.LI.
% Changsha, Hunan Province P.R.China.
% 8/11/2023

global glp
if ~exist('Re','var'), R0 = []; end
if ~exist('f','var'), f = []; end
if ~exist('wie','var'), wie = []; end
if isempty(R0), R0 = 6378137; end
if isempty(f), f = 1/298.257223563; end
if isempty(wie), wie = 7.2921151467e-5; end
glp.R0 = R0;   %单位：m
glp.f = f;     %扁率
glp.wie = wie; %单位：rad/s
glp.wie_vector = [0,0,wie]';
glp.e = sqrt(2*f-f^2);
end
