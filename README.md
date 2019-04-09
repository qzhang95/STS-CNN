**STS-CNN**
====
***********************************************************************************************************
***********************************************************************************************************

Matlab demo code for **"Q.Zhang, Q.Yuan et al, Missing Data Reconstruction in Remote Sensing image with
 a Unified Spatial-Temporal-Spectral Deep Convolutional Neural Network" (IEEE TGRS, 2018)**

by Qiang Zhang, Wuhan University (whuqzhang@gmail.com)

**If you use/adapt our code in your work (either as a stand-alone tool or as a component of any algorithm),
please cite our paper.**

     @article{zhang2018,
     title={Missing data reconstruction in remote sensing image with a unified spatial--temporal--spectral deep convolutional neural network},
     author={Zhang, Qiang and Yuan, Qiangqiang and Zeng, Chao and Li, Xinghua and Wei, Yancong},
     journal={IEEE Trans. Geosci. Remote Sens.},
     volume={56},
     number={8},
     pages={4274--4288},
     year={Aug. 2018},
     publisher={IEEE}}

This code is for academic purpose only. Not for commercial/industrial activities.

***********************************************************************************************************
***********************************************************************************************************
**NOTE:**

  This Matlab version is a re-implementation with STS-CNN, and is for the ease of understanding the algorithm. 
  This code is not optimized, and the speed is not representative. 
  The result can be slightly different from the paper due to transferring across platforms.


**Enviroment:**

  Window 7, Cuda 7.5, Caffe framework (**Necessary**, GPU mode better), Matlab R2014b. Place set this folder into "($Caffe_Dir)/examples/"
***********************************************************************************************************
***********************************************************************************************************


**Usage:**

STSCNN_SLCOff_Demo.m - Demo code for SLC-Off

Cal_PSNRSSIM.m - calculate evaluation indexes

freadenvi.m - read ENVI data

enviwrite.m - write ENVI data

Folders:

Temporal1 and Temporal2 - test temporal images.

Mask - Mask File.

Model - Training model

results_SLC and figures_SLC - save results

***********************************************************************************************************
