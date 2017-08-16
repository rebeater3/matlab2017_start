clc;
clear;
 handle_image('test',800,800);
Imagepath = fullfile('image','train');
Imagedata = imageDatastore(Imagepath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
% display some samples
  figure;
perm = randperm(1000,20);
for i = 1:20
    subplot(4,5,i);
    imshow(Imagedata.Files{perm(i)});
end  
 % Check the number of images in each category.
 CountLabel = Imagedata.countEachLabel;
 %Check the size of the first image in digitData .
 img = readimage(Imagedata,1);
imagesize = size(img);
%define the convolutional neural network archtectu
layers = [imageInputLayer([800 800 3],'Normalization','none');
          convolution2dLayer(5,24);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);

          convolution2dLayer(5,24);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2); 
          
          convolution2dLayer(5,48);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          
          convolution2dLayer(5,96);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2); 

          fullyConnectedLayer(30);
          reluLayer();
          fullyConnectedLayer(2);
          softmaxLayer();
          classificationLayer()];
      
      
options = trainingOptions('sgdm',...
      'LearnRateSchedule','piecewise',...
      'LearnRateDropFactor',0.2,... 
      'LearnRateDropPeriod',5,... 
      'MaxEpochs',30,... 
      'MiniBatchSize',8,...
     'InitialLearnRate',0.00001);

%start training!!!
convnet = trainNetwork(Imagedata,layers,options);
save imdb_ava.mat convnet
%load('imdb2.mat');
%% test

Imagepath = fullfile('image','test');
Testdata = imageDatastore(Imagepath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
 YTest = classify(convnet,Testdata);
TTest = Testdata.Labels;
accuracy = sum(YTest == TTest)/numel(TTest);