function H_im = opH(im,ker)
%% opH     opérateur de flou 2D
%     H_IM = opH(IM,KER)     calcule la convolution KER*IM, avec KER un
%     noyau de convolution au choix (possiblement créé avec fspecial()).
% 
% 
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       
%       ker = fspecial('gaussian',7,1.5);  
%       im_blur = opH(im,ker);
% 
%       figure(1); clf;
%       subplot(121); imshow(im,[]);      title('image originale');
%       subplot(122); imshow(im_blur,[]); title('image floutée');
% 
%
%     Ex 2 (2D):
%       im = im2double(imread('cameraman.tif'));
%       
%       ker = [1 2 3; 4 5 6; 7 8 9]; 
%       ker = ker/sum(ker(:));
%       im_blur = opH(im,ker);
% 
%       figure(2); clf;
%       subplot(121); imshow(im,[]);      title('image originale');
%       subplot(122); imshow(im_blur,[]); title('image floutée');
%%


H_im = real(ifft2(psf2otf(ker,size(im)).*fft2(im)));

end