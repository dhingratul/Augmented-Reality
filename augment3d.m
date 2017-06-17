%% Augment 3D object on an image
% Input: K, R, t , Image, Object
% Output: Displays the augmented image
% Note: Run from augmented101.m
function[]=augment3d(K,R,t,im,newObject)
H=K*[R t]*newObject';
H=H';
for i=1:length(H)
    H(i,:)=H(i,:)/H(i,3);
end
edge=[H(1,1:3) H(2,1:3);
    H(1,1:3) H(3,1:3);
    H(1,1:3) H(4,1:3);
    H(2,1:3) H(6,1:3);
    H(2,1:3) H(7,1:3);
    H(3,1:3) H(5,1:3);
    H(3,1:3) H(7,1:3);
    H(4,1:3) H(5,1:3);
    H(4,1:3) H(6,1:3);
    H(8,1:3) H(5,1:3);
    H(8,1:3) H(6,1:3);
    H(8,1:3) H(7,1:3);
    ];
edgeX = [edge(:,1),edge(:,4)]';
edgeY = [edge(:,2),edge(:,5)]';
% edgeZ = [edge(:,3),edge(:,6)]';
figure, imshow(im); hold on;
plot(edgeX,edgeY,'color',[1 0 0]);
plot(H(:,1),H(:,2),'bo');
hold off;
end