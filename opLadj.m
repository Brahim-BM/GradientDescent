function Z = opLadj(im)
%% opLadj     opérateur adjoint du Laplacien V4 2D
%     Z = opL(IM)	calcule l'adjoint du Laplacien V4 2D de l'image IM (non 
%     vectorisée). 
%     
%
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       z  = opLadj(im);
% 
%       figure(1); clf;
%       subplot(121); imshow(im,[]);     title('image originale');
%       subplot(122); imshow(z,[]);     title('adjoint du Laplacien de l''image');
%%

ker = [0 1 0; 1 -4 1; 0 1 0]; % V4
%ker = [1 1 1; 1 -8 1; 1 1 1]; % V8

Z = real(ifft2(conj(psf2otf(ker,size(im))).*fft2(im)));

end