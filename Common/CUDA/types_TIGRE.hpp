/*-------------------------------------------------------------------------
 *
 * Header CUDA functions for texture-memory interpolation based projection
 *
 *
 * CODE by       Ander Biguri
 *               Sepideh Hatamikia (arbitrary rotation)
---------------------------------------------------------------------------
---------------------------------------------------------------------------
Copyright (c) 2015, University of Bath and CERN- European Organization for 
Nuclear Research
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, 
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation 
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
 ---------------------------------------------------------------------------

Contact: tigre.toolbox@gmail.com
Codes  : https://github.com/CERN/TIGRE
--------------------------------------------------------------------------- 
 */

#ifndef TYPES_CBCT
#define TYPES_CBCT
struct  Geometry {
    // ToDo: image每一层设计一个旋转中心偏移量.
    // Geometry assumptions:
    //  -> Origin is at (0,0,0). Image center is there +offOrig
    //  -> at angle 0, source + image centre (without the offset) + detector centre (without offset) 
    //     are aligned in the Y_Z plane.
    //  -> detector is orthonormal to projection plane.
    
    //Parameters part of the image geometry
    int   nVoxelX, nVoxelY, nVoxelZ; // 扫描物体各方向的体素数量
    float sVoxelX, sVoxelY, sVoxelZ; // 扫描物体的尺寸, mm
    float dVoxelX, dVoxelY, dVoxelZ; // 单个体素的尺寸, mm
    float *offOrigX,*offOrigY,*offOrigZ;
    float* DSO;
    // Parameters  of the Detector.
    int   nDetecU, nDetecV;         // 探测器各方向的pixel数量
    float sDetecU, sDetecV;         // 探测器幅面, mm
    float dDetecU, dDetecV;         // 探测器pixel尺寸, mm
    float *offDetecU, *offDetecV;
    float* DSD;
    float* dRoll;                   // 探测器偏转角度
    float* dPitch;
    float* dYaw;
    // The base unit we are working with in mm. 
    float unitX;
    float unitY;
    float unitZ;
    
    //rotation angle for e uler (ZYZ) 
    // 一个geo只代表一个投影角, 为何offOrigX要设计成长度为nangles的向量?
    float alpha;                    // 投影角
    float theta;                    // 投影角
    float psi;                      // 投影角
    
    // Centre of Rotation correction.
    float* COR;                     // 旋转中心的y方向偏置
    //Maximum length of cube
    float maxLength;
    //User option
    float accuracy;
};

 struct Point3D{
    float x;
    float y;
    float z;
};

struct Point3Ddouble{
    double x;
    double y;
    double z;

    // cast to float member function for "copying" Point3Ddouble to Point3D
    Point3D to_float()
    {
        Point3D castToFloat;
        castToFloat.x = (float)x;
        castToFloat.y = (float)y;
        castToFloat.z = (float)z;
        return(castToFloat);
    }
};

#endif