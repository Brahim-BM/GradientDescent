close all;
clear variables;


%% Gradient descent for the function x²

%Point initial
x0 = -4; % Initialisation point in the graphe of the cost function. 
list_x = [x0]; % Convergence of the sequence to the global minimum. 
list_abs = -5:0.1:5; X axis
x_carre = list_abs.^2; % F(x) function
%Threshold
epsilon = 0.1;

% Learning rate
gamma = 0.2;


for i = 1:100
    gradx = 2*x0; % Gradient of the cost function
    if abs(gradx) < epsilon % condition on the convergence of the sequence
        break
    end
    x0 = x0 - gamma*gradx; % We are searching for the global minimum.
    list_x = [list_x, x0]; % We add elements to the sequence.
end

figure(1)
hold on;
plot(list_abs, x_carre);
plot(list_x, list_x.^2, '*r');


%% Least mean squares : H = Id

z = [5,0.3,7,-12];
x = [1,4,2,-6];

y = x-z;

% Threshold

epsilon = 0.1;

% Learning rate

gamma = 0.2;

for i = 1:100
    grady = 2.*y;
    if abs(grady) < epsilon
        break
    end
    x = x - gamma*grady;
    y = x-z;
end

display('x avec H=Id');
x
figure(3);
plot(1:4,z,'r', 1:4,x,'b');

%% Gaussian noise H

z = ceil(rand(100,1)*255);
x = ceil(rand(100,1)*255);
figure(41);
plot(1:100,z,'b', 1:100,x,'r');

% Matrix H 
H = matH_1D(length(x),3,'gaussian',0.6);
[ligneH,colonneH] = size(H);

% Threshold
epsilon = 0.1;
% Learning rate
gamma = 0.5;
% Gradient corresponding to the data 
M = ones(ligneH,1);

for i = 1:10
    M = 2*(H')*H*x - 2*H'*z;
    if abs(M) < epsilon
        break
    end
    x = x - gamma*M;
end

figure(4);
plot(1:100,z,'b', 1:100,x,'r');

%% Tikhonov Regularization for 1D model

%z = [5;0.3;7;-12];
%x = [1;4;2;-6];
z = ceil(rand(100,1)*255);
x = ceil(rand(100,1)*255);

% Operators
%H = matH_1D(length(x),3,'gaussian',0.6);
H = matH(size(x),'gaussian',3);
D = matGamma(size(x),'gradient');
L = matGamma(size(x),'laplacian');

%gamma
gamma = 'gradient';
%Threshold
epsilon = 0.1;
%Learning rate
alpha = 0.2;
% Regularization operator for gamma = laplacien
lambda = 0.1;

for i = 1:10
    switch gamma
        case 'laplacien'
            grad = 2*(H')*H*x - 2*H'*z + 2*(L')*L*x;
        case 'gradient'
            grad = 2*(H')*H*x - 2*H'*z + 2*(D')*D*x;
        case 'identite'
            grad = 2*(H')*H*x - 2*H'*z + 2*lambda*x;
    end
    if abs(grad) < epsilon
        display('norme');
        break
    end
    x = x - alpha*grad;
end

figure(5)
plot(1:100,z,'b', 1:100,x,'r');

%% Tikhonov Regularization for 2D model

%x = ceil(rand(11*12,1)*255);
img = rgb2gray(imread('tilleul-arbre.jpg'));
%z = img(:,:,1);
z = opH(z, fspecial('gaussian',19,1.5));
[w, h] = size(z)
%z = z + rand(w,h)/10;
x = ones(w,h)/2;
% Opérateurs
%ker = 1/16*[1,2,1;2,4,2;1,2,1];
ker = fspecial('gaussian',19,1.2);
%ker = fspecial('gaussian',19,0.5);
%D = matGamma(size(x),'gradient');
%L = matGamma(size(x),'laplacian');
size(H)
%gamma
lambda = 1;
gamma = 'laplacien';
%Seuil 
epsilon = 0.1;
%alpha
alpha = 0.1;
% Regularization operator
lambda = 0.01;
size(x)
for i = 1:1000
    switch gamma
        case 'laplacien'
            %grad = 2*(H')*H*x - 2*H'*z + 2*(L')*L*x;
            grad = 2*opHadj(opH(x,ker),ker) - 2*opHadj(z,ker) + lambda*2*opLadj(opL(x));
        case 'gradient'
            [Dx, Dy] = opD(x);
            grad = 2*opHadj(opH(x,ker),ker) - 2*opHadj(z,ker) + lambda*2*opDadj(Dx,Dy);
        case 'identite'
            grad = 2*opHadj(opH(x,ker),ker) - 2*opHadj(z,ker) + lambda*2*lambda*x;
    end
    if abs(grad) < epsilon
        break
    end
    x = x - alpha*grad;
end

figure(10);
subplot(1,2,1);
imshow(z);
colorbar();
subplot(1,2,2);
imshow(x);

