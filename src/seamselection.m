clear all
close all
colorImage=imresize(imread('../images/tower.jpg'),1);
Image=rgb2gray(colorImage);
edgeImage=imgradient(Image);
[sizex,sizey]=size(edgeImage);   
positionMat(:,1:sizey,1)=repmat((1:sizex)',1,sizey);
positionMat(1:sizex,:,2)=repmat(1:sizey,sizex,1);
len=150;
for count=1:len
    edgeImage=imgradient(rgb2gray(colorImage));
    [sizex,sizey]=size(edgeImage);
    mask(1,:)=edgeImage(1,:);
    for i = 2 : sizex
        mask(i,1)=min(mask(i-1,1),mask(i-1,2)) + edgeImage(i,1);
        for j = 2 : sizey-1
            mask(i,j) = min(mask(i-1,j-1),min(mask(i-1,j),mask(i-1,j+1))) + edgeImage(i,j);
        end
        j=sizey;
        mask(i,j) = min(mask(i-1,j-1),mask(i-1,j)) + edgeImage(i,j);
    end
    [minValue,minIndex]=min(mask(sizex,:));
    seams(count,positionMat(sizex,minIndex,1))=positionMat(sizex,minIndex,2);
    for i= fliplr(1:sizex-1)
        j=minIndex;
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
%         seams(count,i)=positionMat(i,minIndex);
        seams(count,positionMat(i,minIndex,1))=positionMat(i,minIndex,2);
        colorImage(i,minIndex:sizey-1,:)=colorImage(i,minIndex+1:sizey,:);
        positionMat(i,minIndex:sizey-1,:)=positionMat(i,minIndex+1:sizey,:);
        colorImage(i,sizey)=0;
    end
    colorImage(:,sizey,:)=[];
    positionMat(:,sizey,:)=[];
    Image(:,sizey)=[];
    edgeImage(:,sizey)=[];
    mask(:,sizey)=[];
    disp(count);
%     imshow(uint8(padarray(animate,[size(OrigImage,1)-size(animate,1) size(OrigImage,2)-size(animate,2)],0,'post')));
end
colorImage=imresize(imread('../images/tower.jpg'),1);
[sizex,sizey,sizez]=size(colorImage);
for i = 1:sizex
    for j = fliplr(1:len)
        colorImage(i,seams(j,i),:)=[255 0 0];
    end    
end    
imshow(colorImage);