
%% ������ͼƬ����󳤺Ϳ�
%���غ�������󳤺Ϳ�
%ͳһ���е��ļ���С�������Ҷ�ͼ��ת��ΪRGB�����ﲻҪ��̫�����ױ��Դ�
%����style�����á�test����'train'
function [maxsize_wide,maxsize_high]=handle_image(style,wide,high)
maxsize_wide = 0;
maxsize_high = 0;
% size3 = zeros(1,1000);
 path1 = dir(fullfile('image',style,'highquality','*jpg'));
 path2 = dir(fullfile('image',style,'lowquality','*jpg'));
for i = 1 : length(path1)+length(path2)
    if i<= length(path1)
          filename=fullfile('image',style,'highquality',path1(i).name);
    else
         filename=fullfile('image',style,'lowquality',path2(i-length(path1)).name);
    end
    im =imread(filename);
     si=size(im);
%      size3(i) =si(3);
    if maxsize_wide <si(1)
         maxsize_wide = si(1);
    end
    if maxsize_wide <si(2)
        maxsize_high = si(2);
    end
end
disp(strcat('�����=',num2str(maxsize_wide),'���߶�=',num2str(maxsize_high)));
%% ͳһ��С
% 
for i = 1 : length(path1)+length(path2)
    if i<= length(path1)
          filename=fullfile('image',style,'highquality',path1(i).name);
    else
         filename=fullfile('image',style,'lowquality',path2(i-length(path1)).name);
    end
    im =imread(filename);
    im = imresize(im,[wide,high]);%
    imwrite(im,filename);
   
    %imshow(im);
    % title(num2str(i));
    disp(strcat('%',num2str(100*i/( length(path1)+length(path2)))));
    p=size(size(im));
% %     �������Ҷ�ͼ
    if p(2)<3         %ά��С��3
       [rows,cols]=size(im);
     r=zeros(rows,cols);
     g=zeros(rows,cols);
     b=zeros(rows,cols);
    r=double(im);
    g=double(im);
    b=double(im);
    rgb=cat(3,r,g,b);
    rgb = uint8(rgb);
    imwrite(rgb,filename);
   % imshow(rgb);
    %   imshow(rgb);
    end
end
% %% ������ͼƬ�ŵ���Ӧ�ļ���
% A =load('image/test_label.txt');
% for i = 1:195
%     if A(i,2) == 2
%         filename = fullfile('image','test',strcat(num2str(A(i,1)),'.jpg'));
%         im =imread(filename);
%         imwrite(im,fullfile('image','test','lowquality',strcat(num2str(A(i,1)),'.jpg')));
%     end
%         if A(i,2) == 1
%               filename = fullfile('image','test',strcat(num2str(A(i,1)),'.jpg'));
%               im =imread(filename);
%               imwrite(im,fullfile('image','test','highquality',strcat(num2str(A(i,1)),'.jpg')));
%         end
% end


