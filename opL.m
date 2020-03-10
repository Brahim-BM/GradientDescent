function L_im = opL(im)
%% opL     opérateur de Laplacien V4 2D
%     L_IM = opL(IM)	calcule le Laplacien V4 2D de l'image IM (non 
%     vectorisée). 
%     
%
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       im_lap = opL(im);
% 
%       figure(1); clf;
%       subplot(121); imshow(im,[]);     title('image originale');
%       subplot(122); imshow(im_lap,[]); title('Laplacien de l''image');
%%

ker = [0 1 0; 1 -4 1; 0 1 0]; % V4
%ker = [1 1 1; 1 -8 1; 1 1 1]; % V8

L_im = real(ifft2(psf2otf(ker,size(im)).*fft2(im)));

end