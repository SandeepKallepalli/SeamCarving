clear all
close all
colorImage=imresize(imread('tower.jpg'),0.5);
Image=rgb2gray(colorImage);
OriginalImage=colorImage;
OrigImage=colorImage;

for count=1:100
    edgeImage=imgradient(rgb2gray(colorImage));
    [sizex,sizey]=size(edgeImage);
    mask(1,:)=edgeImage(1,:);
    animate=colorImage;
    for i = 2 : sizex
        mask(i,1)=min(mask(i-1,1),mask(i-1,2)) + edgeImage(i,1);
        for j = 2 : sizey-1
            mask(i,j) = min(mask(i-1,j-1),min(mask(i-1,j),mask(i-1,j+1))) + edgeImage(i,j);
        end
        j=sizey;
        mask(i,j) = min(mask(i-1,j-1),mask(i-1,j)) + edgeImage(i,j);
    end
    [minValue,minIndex]=min(mask(sizex,:));
    for i= fliplr(1:sizex-1)
        j=minIndex;
%         animate(i,minIndex)=255;
        animate(i,minIndex,:)=[255 0 0];
        if j == 1
            [minValue,minIndex]=min(mask(i,j:j+1));
            minIndex=j+minIndex-1;
        elseif j == sizey
            [minValue,minIndex]=min(mask(i,j-1:j));
            minIndex=j+minIndex-2;
        else
            [minValue,minIndex]=min(mask(i,j-1:j+1));
            minIndex=j+minIndex-2;
        end
        colorImage(i,minIndex:sizey-1,:)=colorImage(i,minIndex+1:sizey,:);
        colorImage(i,sizey)=0;
    end
    colorImage(:,sizey,:)=[];
    Image(:,sizey)=[];
    edgeImage(:,sizey)=[];
    mask(:,sizey)=[];
    disp(count);
    imshow(uint8(padarray(animate,[size(OrigImage,1)-size(animate,1) size(OrigImage,2)-size(animate,2)],0,'post')));
%     title(size(colorImage,2));
end
colorImage=permute(colorImage,[2,1,3]);
OrigImage=colorImage;
for count=1:50
    edgeImage=imgradient(rgb2gray(colorImage));
    [sizex,sizey]=size(edgeImage);
    mask2(1,:)=edgeImage(1,:);
    animate=colorImage;
    for i = 2 : sizex
        mask2(i,1)=min(mask2(i-1,1),mask2(i-1,2)) + edgeImage(i,1);
        for j = 2 : sizey-1
            mask2(i,j) = min(mask2(i-1,j-1),min(mask2(i-1,j),mask2(i-1,j+1))) + edgeImage(i,j);
        end
        j=sizey;
        mask2(i,j) = min(mask2(i-1,j-1),mask2(i-1,j)) + edgeImage(i,j);
    end
    [minValue,minIndex]=min(mask2(sizex,:));
    for i= fliplr(1:sizex-1)
        j=minIndex;
%         animate(i,minIndex)=255;
        animate(i,minIndex,:)=[255 0 0];
        if j == 1
            [minValue,minIndex]=min(mask2(i,j:j+1));
            minIndex=j+minIndex-1;
        elseif j == sizey
            [minValue,minIndex]=min(mask2(i,j-1:j));
            minIndex=j+minIndex-2;
        else
            [minValue,minIndex]=min(mask2(i,j-1:j+1));
            minIndex=j+minIndex-2;
        end
        colorImage(i,minIndex:sizey-1,:)=colorImage(i,minIndex+1:sizey,:);
        colorImage(i,sizey)=0;
    end
    colorImage(:,sizey,:)=[];
    Image(:,sizey)=[];
    edgeImage(:,sizey)=[];
    mask2(:,sizey)=[];
    disp(count);
    imshow(permute(uint8(padarray(animate,[size(OriginalImage,2)-size(animate,1) size(OriginalImage,1)-size(animate,2)],0,'post')),[2,1,3]));
%     title(size(colorImage,2));
end
colorImage=permute(colorImage,[2,1,3]);
figure
subplot(2,1,1)
imshow(OriginalImage);
[sizex,sizey]=size(OriginalImage);
subplot(2,1,2)
imshow(colorImage);
title(size(colorImage,1));