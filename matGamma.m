function [varargout] = matGamma(siz,type)
%% matGamma     matrice Gamma de diff�rentiation d'ordre 1 ou 2
%       G = matGamma(SIZE,TYPE)     cr�e la matrice de taille SIZE de   
%       d�rivation de type TYPE
%       . SIZE = size(x) avec x le signal d'origine
%       . TYPE = 'identity','laplacian'
% 
%       D = matGamma(SIZE,'gradient')   cr�e la matrice de taille SIZE du 
%       gradient par diff�rences finies � droite en 1D
%       . SIZE = size(x) avec x le signal d'origine
% 
%       [Dx,Dy] = matGamma(SIZE,'gradient')   cr�e la matrice de taille SIZE 
%       du gradient par diff�rences finies � droite en 2D
%       . SIZE = size(x) avec x l'image d'origine non vectoris�e
%                                      
% 
%     Ex 1 (1D): 
%       t = [-10:.1:10]';
%       s = sin(t);
%       D = matGamma(size(s),'gradient');
% 
%       s_grad = D*s;
% 
%       figure(1); clf;
%       plot(t,s,'-',t,s_grad,'--');
%       legend('signal original','signal d�riv�');
% 
% 
%     Ex 2 (2D):
%       im = im2double(imread('cameraman.tif'));
%       [Dx,Dy] = matGamma(size(im),'gradient');
% 
%       im_gradx = reshape(Dx*im(:),size(im));
%       im_grady = reshape(Dy*im(:),size(im));
% 
%       figure(2); clf;
%       subplot(131); imshow(im,[]);       title('image originale');
%       subplot(132); imshow(im_gradx,[]); title('Gradient selon x de l''image');
%       subplot(133); imshow(im_grady,[]); title('Gradient selon y de l''image');
% 
% 
%     Ex 3 (2D):
%       im = im2double(imread('cameraman.tif'));
%       L  = matGamma(size(im),'laplacian');
% 
%       im_lap = reshape(L*im(:),size(im));
% 
%       figure(3); clf;
%       subplot(121); imshow(im,[]);     title('image originale');
%       subplot(122); imshow(im_lap,[]); title('Laplacien de l''image');
%%

dim = (min(siz) > 1) + 1;
if dim == 1, siz = sort(siz,'descend'); end

S = siz(1)*siz(2);

switch type
    case {'identity','Identity'}
        varargout(1) = {eye(S)};
        
    case {'gradient','Gradient'}
        Dx = spdiags([-ones(S,1) ones(S,1)], [0,siz(1)], S, S)/2;
        Dx(end-siz(1)+1:end,:) = 0;
        
        Dy = spdiags([-ones(S,1) ones(S,1)], [0,1], S, S)/2;
        Dy(siz(1):siz(1):end,:) = 0;
        
        switch dim
            case 1
                varargout(1) = {Dy};
                
            case 2
                varargout(1) = {Dx};
                varargout(2) = {Dy};
        end
        
    case {'laplacian','Laplacian'}
        a = repmat([0; ones(siz(1)-1,1)],[siz(2),1]);   a = [a(2:end); nan];
        b = repmat([ones(siz(1)-1,1); 0],[siz(2),1]);   b = [nan; b(1:end-1)];
        l = [zeros(siz(1),1); ones(S-siz(1),1)];        l = [l(siz(1)+1:end); nan(siz(1),1)];
        r = [ones(S-siz(1),1); zeros(siz(1),1)];        r = [nan(siz(1),1); r(1:end-siz(1))];
        
        Ly = spdiags([a b], [-1,1], S, S);
        Lx = spdiags([l r], [-siz(1),siz(1)], S, S);
        
        L = (dim==2)*Lx + Ly;
        L = L - spdiags(sum(L,2), 0, S, S);
        
        varargout(1) = {L};
        
    otherwise
        error('Type de diff�rentiation inconnu.');
end