function [Dx_im, Dy_im] = opD(im)
%% opD     op�rateur de gradient par diff�rences finies � droite 2D
%     [DX_IM,DY_IM] = opD(IM)	calcule les gradients par diff�rences finies
%     � droite en 2D de l'image IM (non vectoris�e). DX_IM est le gradient
%     de IM par rapport � x (diff�rences finies horizontales), DY_IM est le 
%     gradient de IM par rapport � y (diff�rences finies verticales).
%     
%
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       [im_gradx,im_grady] = opD(im);
% 
%       figure(1); clf;
%       subplot(131); imshow(im,[]);       title('image originale');
%       subplot(132); imshow(im_gradx,[]); title('Gradient selon x de l''image');
%       subplot(133); imshow(im_grady,[]); title('Gradient selon y de l''image');
%%

Dx_im = [im(:,2:end) - im(:,1:end-1) , zeros(size(im,1),1)] ./ 2.;
Dy_im = [im(2:end,:) - im(1:end-1,:) ; zeros(1,size(im,2))] ./ 2.;

end