**STS-CNN**
====
***********************************************************************************************************
***********************************************************************************************************

Matlab demo code for **"Q.zhang, Q.Yuan et al, Missing Data Reconstruction in Remote Sensing image with
 a Unified Spatial-Temporal-Spectral Deep Convolutional Neural Network" (IEEE TGRS, 2017. Under Review)**

by Qiang Zhang (whuqzhang@gmail.com)

If you use/adapt our code in your work (either as a stand-alone tool or as a component of any algorithm),
please cite our paper.

This code is for academic purpose only. Not for commercial/industrial activities.


**NOTE:

  This Matlab version is a re-implementation with STS-CNN, and is for the ease of understanding the algorithm. 
  This code is not optimized, and the speed is not representative. 
  The result can be slightly different from the paper due to transferring across platforms.


**Enviroment: 

  Window 7, Cuda 7.5, Caffe framework (Necessary, GPU mode better), Matlab R2014b. Place set this folder into "($Caffe_Dir)/examples/"
***********************************************************************************************************
***********************************************************************************************************


**Usage:

STSCNN_SLCOff_Demo.m - Demo code for SLC-Off

Cal_PSNRSSIM.m - calculate evaluation indexes

freadenvi.m - read ENVI data

enviwrite.m - write ENVI data

Folders:

Temporal1 and Temporal1 - test temporal images.

Mask - Mask File.

Model - Training model

results_SLC and figures_SLC - save results
