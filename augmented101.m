%% Augmenting an Image
clear all; close all;
load Homographies
im=imread('2.jpg'); %9+4+8+6=27
im_H=[];
% scale=0.5;
scale=[210 NaN]; %keep the aspect ratio
im=imresize(im,scale);
[r,c,~]=size(im);
% imshow(im);
im=im+1;
im=imrotate(im,-90);
for i=1:c
    for j=1:r
        im_H=[im_H;i j 1 im(i,j,1) im(i,j,2) im(i,j,3)];
    end
end
im2=imread('images2.png'); augment(im2,H_2_n,im_H);pause(0.5);
im9=imread('images9.png'); augment(im9,H_9_n,im_H);pause(0.5);
im12=imread('images12.png');augment(im12,H_12_n,im_H);pause(0.5);
im20=imread('images20.png');augment(im20,H_20_n,im_H);pause(0.5)
%% 3.2
side=10;
object=[0 0 0 1;
    3*side 0 0 1;
    0 3*side 0 1;
    0 0 3*side 1;
    0 3*side 3*side 1;
    3*side 0 3*side 1;
    3*side 3*side 0 1;
    3*side 3*side 3*side 1
    ];
disp(object);
newObject(:,1)=object(:,3); newObject(:,2)=object(:,2);
newObject(:,3)=object(:,1); newObject(:,4)=object(:,4);
objectEdge=[newObject(1,1:3) newObject(2,1:3);
    newObject(1,1:3) newObject(3,1:3);
    newObject(1,1:3) newObject(4,1:3);
    newObject(2,1:3) newObject(6,1:3);
    newObject(2,1:3) newObject(7,1:3);
    newObject(3,1:3) newObject(5,1:3);
    newObject(3,1:3) newObject(7,1:3);
    newObject(4,1:3) newObject(5,1:3);
    newObject(4,1:3) newObject(6,1:3);
    newObject(8,1:3) newObject(5,1:3);
    newObject(8,1:3) newObject(6,1:3);
    newObject(8,1:3) newObject(7,1:3);
    ];
edgeX = [objectEdge(:,1),objectEdge(:,4)]';
edgeY = [objectEdge(:,2),objectEdge(:,5)]';
edgeZ = [objectEdge(:,3),objectEdge(:,6)]';
% figure, plot3(newObject(:,1),newObject(:,2),newObject(:,3),'o'); hold on
% plot3(edgeX,edgeY,edgeZ,'color',[1 0 0]); hold off
% augment3d
im2=imread('images2.png');augment3d(A,R_2,t_2,im2,newObject);pause(0.5);
im9=imread('images9.png');augment3d(A,R_9,t_9,im9,newObject);pause(0.5);
im12=imread('images12.png');augment3d(A,R_12,t_12,im12,newObject);pause(0.5);
im20=imread('images20.png');augment3d(A,R_20,t_20,im20,newObject);