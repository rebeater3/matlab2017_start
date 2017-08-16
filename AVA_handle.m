%% 让AVA第16列是均分
clear;
clc;
AVA=load('AVA.txt');
AVA_score=AVA(:,3:12);
b=0;
for i=1:10
b=b+AVA_score(:,i)*i;
end
c=sum(AVA_score,2);
m=b./c;
AVA(:,16)=m;
% AVA_index = AVA == str2double('1359');
% sum(AVA_index)
%AVA(AVA_index,16)
pathhigh=fullfile('image','test','highquality');
pathlow=fullfile('image','test','lowquality');
%% 把4万张中的大于8的放到一个文件夹
for i=1:50000
    if i== 6497 ||i==6947%这两张有问题
        i=i+1;
    end
    if i<10001
        j=i;
        path1 = dir(fullfile('imgs','1-10000','*.jpg'));
        filename=fullfile('imgs','1-10000',path1(i).name);
   elseif i<20001
        j=i-10000;
        path1 = dir(fullfile('imgs','20001-30000','*.jpg'));
        filename=fullfile('imgs','20001-30000',path1(i-10000).name);
    elseif i<30001
        j=i-20000;
        path1 = dir(fullfile('imgs','20001-30000','*.jpg'));
        filename=fullfile('imgs','20001-30000',path1(i-20000).name);
    elseif i<40001
        j=i-30000;
          path1 = dir(fullfile('imgs','30001-40000','*.jpg'));
          filename=fullfile('imgs','30001-40000',path1(i-30000).name); 
    elseif i<50001
        j=i-40000;
          path1 = dir(fullfile('imgs','30001-40000','*.jpg'));
          filename=fullfile('imgs','30001-40000',path1(i-40000).name);
    end
        im = imread(filename);
        s=size(im);
        s=s(1)*s(2);
        if s>224*224%只要大于50176的
%              AVA_index = AVA == str2double(path1(i).name);
                pathhigh=fullfile('image','test','highquality',path1(j).name);
                   pathlow=fullfile('image','test','lowquality',path1(j).name);
               num=str2double(strrep(path1(j).name,'.jpg',[]));
                local = find(AVA(:,2)==num);
             if AVA(local,16)> 6.4
                imwrite(im, pathhigh);
             elseif AVA(local,16)< 4.3
                 imwrite(im, pathlow); 
             end
             disp(AVA(local,16));  
        end 
end

% %% test_set
% a=load('./aesthetics_image_lists/animal_test.jpgl','r');
% b=load('./aesthetics_image_lists/architecture_test.jpgl','r');
% c=load('./aesthetics_image_lists/cityscape_test.jpgl','r');
% d=load('./aesthetics_image_lists/floral_test.jpgl','r');
% e=load('./aesthetics_image_lists/fooddrink_test.jpgl','r');
% f=load('./aesthetics_image_lists/landscape_test.jpgl','r');
% g=load('./aesthetics_image_lists/portrait_test.jpgl','r');
% h=load('./aesthetics_image_lists/stilllife_test.jpgl','r');
% test_set_20000=[a;b;c;d;e;f;g;h];
% test_set_19930=ones(19930,4);
% j=1;
% for i = 1:20000
%     num=find(AVA(:,2)==test_set_20000(i));
%     if(num)
%         if (AVA(num,16)>=5)
%             
%             test_set_19930(j,:)=[AVA(num,1) AVA(num,2) AVA(num,16) 0];
%         else 
%             test_set_19930(j,:)=[AVA(num,1) AVA(num,2) AVA(num,16) 1];
%         end
%         j=j+1;
%     end
% end
% test_set_19930=sortrows(test_set_19930);
% 
% % train_set 舍弃[4:6] (无资源的102036和189774都在train[4:6]里)
% j=1;
% train_set_52815=ones(52815,4);
% for i = 1:255530
%     num=find(test_set_19930(:,2)==AVA(i,2));
%     if(isempty(num))
%         if (AVA(i,16)>=6)
%             train_set_52815(j,:)=[AVA(i,1) AVA(i,2) AVA(i,16) 0];
%             j=j+1;
%         else if (AVA(i,16)<4)
%             train_set_52815(j,:)=[AVA(i,1) AVA(i,2) AVA(i,16) 1];
%             j=j+1;
%             end
%         end
%     end
% end
% 
% %% 写入train_set
% txt=fopen('train.txt','wt');
% j=1;
% for i = 1:52815
%     if train_set_52815(i,1)>j*10000
%         j=j+1;
%     end
%     str=strcat('Imgs/',num2str(j*10000-9999),'-',num2str(j*10000),'/',num2str(train_set_52815(i,2)),'.jpg',{32},num2str(train_set_52815(i,4)));
%     fprintf(txt,'%s',str{1});
%     fprintf(txt,'\n');
% end
% 
% % 写入test_set
% txt=fopen('val.txt','wt');
% j=1;
% for i = 1:19930
%     if test_set_19930(i,1)>j*10000
%         j=j+1;
%     end
%     str=strcat('Imgs/',num2str(j*10000-9999),'-',num2str(j*10000),'/',num2str(test_set_19930(i,2)),'.jpg',{32},num2str(test_set_19930(i,4)));
%     fprintf(txt,'%s',str{1});
%     fprintf(txt,'\n');
% end
% 
% %% 10%
% newAVA=sortrows(AVA,16);
% low=newAVA(1:100,1:2);
% high=newAVA(901:1000,1:2);
% fid=fopen('low.txt','wt');
% for i=1:1:100
% for j=1:1:2
% if j==2
% fprintf(fid,'%g\n',low(i,j));
% else
% fprintf(fid,'%g\0',low(i,j));
% end
% end
% end
% fclose(fid);