%% Augment Image based on H-matrix
% Input: Image, H-Matrix, image based on H
% Output: Augmented Imge
% Note: Run from augmented101.m
function[out_img]=augment(im,H,im_H)
im_mapp=double(im_H(:,1:3))*H';
im_mapp(:,1)=im_mapp(:,1)./im_mapp(:,3);
im_mapp(:,2)=im_mapp(:,2)./im_mapp(:,3);
im_mapp=abs(round(im_mapp+1));
newImage=zeros(max(im_mapp(:,1)),max(im_mapp(:,1)),3);
for i=1:length(im_mapp)
    r=im_mapp(i,2);
    c=im_mapp(i,1);
    newImage(r,c,1)=im_H(i,4);
    newImage(r,c,2)=im_H(i,5);
    newImage(r,c,3)=im_H(i,6);
end
newImage=uint8(newImage);
% imshow(newImage);
f(newImage==0)=NaN;
f=zeros(size(newImage));
f(:,:,1) = medfilt2(newImage(:,:,1));
f(:,:,2) = medfilt2(newImage(:,:,2));
f(:,:,3) = medfilt2(newImage(:,:,3));
h = fspecial('average', [3 3]);
f=imfilter(newImage,h);
% imshow(f);
bw=(newImage>0) & (newImage<255);
% bw=logical(newImage);
% Pad with zeros
difference = abs(size(im)-size(newImage));
mask = padarray(bw, [difference(1),difference(2)], 'post');
img_masked_pad = newImage .* uint8(bw);
[r,c,~]=size(im);
out_img = zeros(r,c,3);
for i = 1:r
    for j = 1:c
        if mask(i,j,:)
            out_img(i,j,:) = img_masked_pad(i,j,:);
        else
            out_img(i,j,:) = im(i,j,:);
        end
    end
end
figure, imshow(uint8(out_img))
end