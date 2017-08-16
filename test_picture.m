clc;
clear;
%handle_image('test',224,224);
load('imdb2');
im=imread('testimg.jpg');
im=imresize(im,[224,224]);
[x,y]=classify(convnet,im);
imshow(im);
title(strcat(string(x),string(max(y))));

%% test
%%为了节约显存，单独读取每一张图片进行测试，这样测试会比较慢 
Imagepath = fullfile('image','test');
Testdata = imageDatastore(Imagepath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
len=length(Testdata.Files);
%len = 10;
sum1 = 0;
for i= 1:len
    im=imread(char(Testdata.Files(i)));
%     imshow(im);
%     title(num2str(i));
    [YTest,score] =classify(convnet,im);
    if YTest==Testdata.Labels(i)
        sum1 = sum1+1;
    end
    if YTest == 'lowquality'
        lowpath=fullfile('lowimage_trained',strcat(num2str(score(1)),'.jpg'));
        imwrite(im,lowpath);
    elseif
        YTest == 'highquality'
        lowpath=fullfile('highimage_trained',strcat(num2str(score(1)),'.jpg'));
        imwrite(im,lowpath);
    end
    disp(i);
end
accuracy = sum1/len;