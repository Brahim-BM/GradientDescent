function Z = opDadj(im1,im2)
%% opDadj     op�rateur adjoint du gradient par diff�rences finies � droite 2D
%     Z = opDadj(IM1,IM2)	calcule l'adjoint du gradient (i.e. la divergence)
%     du couple d'images IM1, IM2 (non vectoris�es et de m�me tailles).
%     Si IM1 est la d�riv�e d'une image IM par rapport � x, et IM2 est la 
%     d�riv�e de IM par rapport � y, alors Z est le Laplacien (V4) de IM.
%     
%
%     Ex 1 (2D):
%       im = im2double(imread('cameraman.tif'));
%       [im_gradx,im_grady] = opD(im);
%       z = opDadj(im_gradx,im_grady);
% 
%       figure(1); clf;
%       subplot(121); imshow(im,[]);       title('image originale');
%       subplot(122); imshow(z,[]);        title('divergence du gradient de l''image');
%%

Z = - [im1(:,1), im1(:,2:end-1) - im1(:,1:end-2), -im1(:,end-1)] ./ 2. ...
    - [im2(1,:); im2(2:end-1,:) - im2(1:end-2,:); -im2(end-1,:)] ./ 2.;

end