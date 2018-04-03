%% Description
% =========================================================================
% Test code for Spatial-Temporal-Spectral Convolutional Neural Networks (STS-CNN)
%
% Reference
%   Qiang Zhang, Qiangqiang Yuan, Chao Zeng, Xinghua Li, Yancong Wei.
%   Missing Data Reconstruction in Remote Sensing image with a Unified Spatial-Temporal-Spectral Deep Convolutional Neural Network.
%   IEEE Transactions on Geoscience and Remote Sensing, 2018.
%
% Qiang Zhang
% School of Geodesy and Geomatics, Wuhan University, P. R. China.
% For any question, please send email to whuqzhang@gmail.com.
% =========================================================================

warning off all;
clc; clear;

%% Datasets
folderTest  = fullfile('Temporal1'); %%% test dataset1: Spatial data
folderTest_2  = fullfile('Temporal2'); %%% test dataset2: Temporal data

%% Displaying and Saving Parameters
showResult  = 1; % showResult=1, unshowResult=0
saveResults = 0; % saveResults=1, unsaveResults=0
pauseTime   = 0; % pause time of the results
patchsize=400;

%% Mask File
Mask1=imread('Mask/Mask_SLC1.tif');
Mask1=Mask1(:, :, 1)./255;
a1=single(Mask1);
Mask1(:,:,1)=a1;
Mask1(:,:,2)=a1;
Mask1(:,:,3)=a1;
Mask1(:,:,4)=a1;
Mask1(:,:,5)=a1;
Mask1(:,:,6)=a1;
Mask1=single(Mask1);

%% Model and Network
def  = 'Model/STS-CNN_SLCOff.prototxt';
model= 'Model/STS-CNN_SLCOff_iterations_900000.caffemodel';

%% Read Images
ext         =  {'*.jpg','*.png','*.bmp' ,'*.tif', '*.hdr'};
filePaths   =  [];
filePaths_2   =  [];
for i = 1 : length(ext)
    filePaths = cat(1,filePaths, dir(fullfile(folderTest,ext{i})));
    filePaths_2 = cat(1,filePaths_2, dir(fullfile(folderTest_2,ext{i})));
end
num=length(filePaths);

% PSNR and SSIM
PSNRs = zeros(1,length(filePaths));
SSIMs = zeros(1,length(filePaths));
count=0;

for ii = 201:1:205
    count=count+1;
    % read images
    image  = freadenvi(fullfile(folderTest, num2str(ii))); 
    image2 = freadenvi(fullfile(folderTest_2, num2str(ii)));   
    label  = single(image); % single
    input_2  = single(image2); % single 
    input= single(label.*Mask1);
    temp=input;
    input_replace=input+(1-Mask1).*input_2;  
    
    % output = netforward(input, input_2, def, model);
    caffe.reset_all();
    caffe.set_mode_gpu();
    net = caffe.Net(def, model, 'test');
    
    for c=1: 1: 3
        for i=1: patchsize : 400
            for j=1: patchsize : 400
                patch1=input(i:i+patchsize-1,  j:j+patchsize-1, c);
                patch2=input_2(i:i+patchsize-1,  j:j+patchsize-1, c);
                mask_p=  Mask1(i:i+patchsize-1,  j:j+patchsize-1, c);              
                output1 = net.forward({patch1, patch2});
                output = output1{1,1};
                temp(i:i+patchsize-1,  j:j+patchsize-1, c)=output;
            end
        end
    end
         
    output2 = temp(:, :, 1:3).*(1-Mask1(:, :, 1:3))+input(:, :, 1:3);
%  	output = output+input(:, :, 4);
% 	output2 = netforward_skip(input(:, :, 4), input_2,input_replace, def, model);
%   output2 = (1-a).*output+input(:, :, 4);
%   output2 = netforward_skip(input(:, :, 5), input_2,input_replace, def, model);
%   output2 = (1-a).*output+input(:, :, 5);
% 	output3 = netforward_skip(input(:, :, 6), input_2,input_replace, def, model);
%   output3 = (1-a).*output+input(:, :, 6);

    % Calculate mPSNR and mSSIM and CC
    [PSNRCur1, SSIMCur1, CC1] = Cal_PSNRSSIM(output2(: ,:, 1),label(:, :, 1), 0,0);
    [PSNRCur2, SSIMCur2, CC2] = Cal_PSNRSSIM(output2(: ,:, 2),label(:, :, 2), 0,0);
    [PSNRCur3, SSIMCur3, CC3] = Cal_PSNRSSIM(output2(: ,:, 3),label(:, :, 3), 0,0);
    PSNRCur=(PSNRCur1 + PSNRCur2 + PSNRCur3) / 3.0;
    SSIMCur=(SSIMCur1 + SSIMCur2 + SSIMCur3) / 3.0;
    CC =(CC1 + CC2 + CC3) / 3.0;    
    if showResult            
        imshow(cat(2,im2uint8(label(:, :, 1:3)), im2uint8(input_2(:, :, 1:3)), im2uint8(input(:, :, 1:3)), im2uint8(output2)));
        title([num2str(PSNRCur,'mPSNR:%2.4f'),'dB','    ',num2str(SSIMCur,'mSSIM:%2.4f') ,'    ',num2str(CC,'CC:%2.4f')])
        drawnow;       
        if saveResults           
            savefilename_GT=['results_SLC/', num2str(count), '_GT', '.png'];
            savefilename_T2=['results_SLC/', num2str(count), '_Temporal2', '.png'];
            savefilename_Noise=['results_SLC/', num2str(count), '_Missing', '.png'];
            savefilename_Output=['results_SLC/', num2str(count), '_Output', '.png'];
            savefilename_All=['figures_SLC/', num2str(count), '_Inpainting', '.png'];            
            imwrite(im2uint8(label(:, :, 1:3)), savefilename_GT);
            imwrite(im2uint8(input_2(:, :, 1:3)), savefilename_T2);
            imwrite(im2uint8(input(:, :, 1:3)), savefilename_Noise);
            imwrite(im2uint8(output2), savefilename_Output);
            % print(1, '-dpng', savefilename_All);
            saveas(1, savefilename_All);
        end      
        pause(pauseTime)
    end
    PSNRs(i) = PSNRCur;
    SSIMs(i) = SSIMCur;
end

% disp([mean(PSNRs),mean(SSIMs)]);
