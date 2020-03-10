function Z = opHadj(im,ker)
%% opHadj     opérateur adjoint du flou 2D
%     Z = opH(IM,KER)   calcule l'adjoint de la convolution KER*IM, avec KER
%     un noyau de convolution au choix (possiblement créé avec fspecial()).
% 
% 
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       
%       ker = fspecial('gaussian',7,1.5);  
%       z = opHadj(im,ker);
% 
%       figure(1); clf;
%       subplot(121); imshow(im,[]);      title('image originale');
%       subplot(122); imshow(z,[]);       title('image floutée');
% 
%
%     Ex 2 (2D):
%       im = im2double(imread('cameraman.tif'));
%       
%       ker = [1 2 3; 4 5 6; 7 8 9]; 
%       ker = ker/sum(ker(:));
%       z = opHadj(im,ker);
% 
%       figure(2); clf;
%       subplot(121); imshow(im,[]);      title('image originale');
%       subplot(122); imshow(z,[]);       title('image floutée');
%%

Z = real(ifft2(conj(psf2otf(ker,size(im))).*fft2(im)));

end
