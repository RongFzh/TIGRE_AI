%% DEMO 01: Describing your geometry
%
%  In TIGRE the geometry is stored in an structure. To see documentation
%  about geometry, run:
%     
%     doc('TIGRE/Geometry')
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% This file is part of the TIGRE Toolbox
% 
% Copyright (c) 2015, University of Bath and 
%                     CERN-European Organization for Nuclear Research
%                     All rights reserved.
%
% License:            Open Source under BSD. 
%                     See the full license at
%                     https://github.com/CERN/TIGRE/blob/master/LICENSE
%
% Contact:            tigre.toolbox@gmail.com
% Codes:              https://github.com/CERN/TIGRE/
% Coded by:           Ander Biguri 
%--------------------------------------------------------------------------
%%  Geometry definition
%
%                  Detector plane, behind
%              |-----------------------------|
%              |                             |
%              |                             |
%              |                             |
%  Centered    |                             |
%    at O      A V    +--------+             |
%              |     /        /|             |
%     A Z      |    /        / |*D           |
%     |        |   +--------+  |             |
%     |        |   |        |  |             |
%     |        |   |     *O |  +             |
%     *--->y   |   |        | /              |
%    /         |   |        |/               |
%   V X        |   +--------+        U       |
%              .--------------------->-------|
%
%            *S
%
%
%% Geometry structure:
%           -nVoxel:        3x1 matrix of number of voxels in the image
%           -sVoxel:        3x1 matrix with the total size in mm of the image
%           -dVoxel:        3x1 matrix with the size of each of the voxels in mm
%           -nDetector:     2x1 matrix of number of voxels in the detector plane
%           -sDetector:     2x1 matrix with the total size in mm of the detector
%           -dDetector:     2x1 matrix with the size of each of the pixels in the detector in mm
%           -DSD:           1x1 scalar value. Distance Source Detector, in mm
%           -DSO:           1x1 scalar value. Distance Source Origin.
%           -offOrigin:     3x1 matrix with the offset in mm of the centre of the image from the origin.
%           -offDetector:   2x1 matrix with the offset in mm of the centre
%           of the detector from the x axis

% Shows Geometry diagram
% showGeoCBCTDiagram(); % 无法下载图片，报错。

%% Example
%
%
%
% VARIABLE                                   DESCRIPTION                    UNITS
%-------------------------------------------------------------------------------------
% Distances
geo.DSD = 1536;                             % Distance Source Detector      (mm) 投影角为0时, 源在x轴正轴上, 投影角增大, 源逆时针旋转. 类似向量定义.
geo.DSO = 1000;                             % Distance Source Origin        (mm)
% Detector parameters
geo.nDetector=[512; 512];					% number of pixels              (px) 也就是投影矩阵的宽和高
geo.dDetector=[0.8; 0.8]; 					% size of each pixel            (mm) 像素大小
geo.sDetector=geo.nDetector.*geo.dDetector; % total size of the detector    (mm) 投影幅面
% Image parameters image指的是断层图不是投影图
geo.nVoxel=[256;256;256];                   % number of voxels              (vx)
geo.sVoxel=[256;256;256];                   % total size of the image       (mm)
geo.dVoxel=geo.sVoxel./geo.nVoxel;          % size of each voxel            (mm)
% Offsets
geo.offOrigin =[0; 0; 0];                   % Offset of image from origin   (mm) 用于偏中心重建？    物体中心偏移坐标【x,y,z】    
                                            % geo.offOrigin 尺寸可以是: 3x1 or 3xsize(angles,2)

geo.offDetector=[0; 0];                     % Offset of Detector            (mm) 平板中心偏移坐标[y,z]
                                            % These two can be also defined
                                            % per angle, geo.offDetector 尺寸可以是: 2x1 or 2xsize(angles,2)

% Auxiliary 
geo.accuracy=0.5;                           % Variable to define accuracy of
                                            % 'interpolated' projection
                                            % It defines the amoutn of
                                            % samples per voxel.
                                            % Recommended <=0.5             (vx/sample)

% Optional Parameters
% There is no need to define these unless you actually need them in your
% reconstruction
                                            
                                            
geo.COR=0;                                  % y direction displacement for  # 旋转中心的y方向偏置. 相当于不改变SID时改变了DSO? 设置这个参数的意义是什么?
                                            % centre of rotation
                                            % correction                   (mm)
                                            % This can also be defined per
                                            % angle.  
                                            % geo.COR 尺寸可以是: 1x1 or 1xsize(angles,2)
                                            
geo.rotDetector=[0;0;0];                 % Rotation of the detector, by  # plotgeometry未定义探测器旋转的绘制. 待确认此参数在投影和重建中是否有作用. 以X轴为轴的旋转是内部旋转.
                                            % X,Y and Z axis respectively. (rad)
                                            % This can also be defined per
                                            % angle     geo.rotDetector 尺寸可以是: 3x1 or 3xsize(angles,2)  
                                            
geo.mode='cone';                            % Or 'parallel'. Geometry type.  

%% Alternatively, you can generate default geometries as:

geoCone=defaultGeometry();
geoCone=defaultGeometry('mode','cone');
geoCone=defaultGeometry('nVoxel',[64;64;128]);
geoCone=defaultGeometry('nDetector',[512;128]);
geoParallel=defaultGeometry('mode','parallel');
% etc
%% Plot the geometry
                                            
plotgeometry(geo,0);                   
