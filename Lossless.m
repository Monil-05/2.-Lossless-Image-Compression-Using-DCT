clc;
clear all;
close all;
for ii=1:11 %Run the for loop n times for n number of images. The image name should be in the format: "(m)" where 0<m<n %
    I1=imread(['(',num2str(ii),').JPG']);
    figure();
    subplot(2,2,1);
    imshow(I1);
    Size1=dir(['(',num2str(ii),').JPG']);
    Size=(Size1.bytes)/1024;
%For first channel in rgb image%
    I=I1(:,:,1);
    I=im2double(I);
    T=dctmtx(8);
    B=blkproc(I,[8 8],'P1*x*P2',T,T');
    I2=blkproc(B,[8 8],'P1*x*P2',T',T);
 %For second channel in rgb image%
    I=I1(:,:,2);
    I=im2double(I);
    T=dctmtx(8);
    B=blkproc(I,[8 8],'P1*x*P2',T,T');
    I3=blkproc(B,[8 8],'P1*x*P2',T',T);
%For third channel in rgb image%
    I=I1(:,:,3);
    I=im2double(I);
    T=dctmtx(8); 
    B=blkproc(I,[8 8],'P1*x*P2',T,T');
    I4=blkproc(B,[8 8],'P1*x*P2',T',T);
%----------------------%
    L=cat(3,I2,I3,I4);
    imwrite(L,['Compressed_Image(',num2str(ii),').JPG'],'JPG');
    Size3=dir(['Compressed_Image(',num2str(ii),').JPG']);
    Size2=(Size3.bytes)/1024;
    x=(Size-Size2)*100/Size;
    fprintf('The size of original image is %f KB and compressed image is %f KB\n',Size,Size2);
    fprintf('Compression ratio is %f',x);
    N=imread(['Compressed_Image(',num2str(ii),').JPG']);
    subplot(2,2,2);
    imshow(N);
    diff_img=N-I1;
    subplot(2,2,3);
imshow(diff_img,[]);
thresholdImage=diff_img > 20;
sum_of_all_pixels=sum(sum(thresholdImage));
min_diff=1000;
if sum_of_all_pixels > min_diff
fprintf('Images are Diff.');
display(sum_of_all_pixels);
else
fprintf('Same Images');
end
end
