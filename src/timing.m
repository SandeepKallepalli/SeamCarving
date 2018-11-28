%% Fixed Number of Seams to remove
clear all
close all
OrigImage=imread('../seamImages/timing.jpg');
sizex=size(OrigImage,1);
for i=1:10
    colorImage=imresize(OrigImage,i/5);
    for j = 10:20:90
        t=cputime;
        seamFunction(colorImage,j,j);
        time(i,j)=cputime-t;
    end    
end
plot(sizex*(1:10)/5,time(:,1),sizex*(1:10)/5,time(:,2),sizex*(1:10)/5,time(:,3),sizex*(1:10)/5,time(:,4));
xlabel('Size');
ylabel('Time Taken')

%% Fixed ratio of image to remove 
clear all
close all
OrigImage=imread('../seamImages/timing.jpg');
sizex=size(OrigImage,1);
for i=3:7
    colorImage=imresize(OrigImage,i/5);
        t=cputime;
        seamFunction(colorImage,214,214);
        time1(i)=cputime-t;
end
plot(sizex*(3:7)/5,time1(:));
xlabel('Size');
ylabel('Time Taken')

%% 2 seams removal by scaling by two
clear all
close all
OrigImage=imresize(imread('../seamImages/tower.jpg'),1);
sizex=size(OrigImage,1);
sizey=size(OrigImage,1);
t=cputime;
colorImage=seamFunction(OrigImage,0.5*sizex,0.01*sizey);
time1=cputime-t;
disp(size(colorImage));
colorImage1=colorImage;
t=cputime;
colorImage=imresize(OrigImage,0.5);
colorImage=seamFunction(colorImage,0.5*0.5*sizex,0.01*0.5*sizey);
colorImage=imresize(colorImage,1/0.5);
time2=cputime-t;
disp(size(colorImage));
figure;
subplot(1,2,1)
imshow(colorImage1);
subplot(1,2,2)
imshow(colorImage);