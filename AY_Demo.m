
%%% Ayush Dogra, Chirag Kamal Ahuja, and Sanjeev Kumar. "A multi?modality paradigm for CT and MRI fusion with applications of 
%%% quantum image processing." Concurrency and Computation: Practice and Experience 34, no. 20 (2022): e6610. https://doi.org/10.1002/cpe.6610

clc;
clear;
close all;

I1 = im2double(imread('images\image1.png'));
I2 = im2double(imread('images\image2.png'));
%% rolling guidance filter.
tic;
res1 = RollingGuidanceFilter(I1,0.7,0.5,5);
res2 = RollingGuidanceFilter(I2,0.7,0.5,5);
toc;

figure,imshow(I1);
figure,imshow(I2);

%% anisotropic diffusion filter.
 num_iter = 5;
   delta_t = 0.01;
   kappa = 9;
   option = 2;
   tic
   
  A1 = anisodiff2D(res1,num_iter,delta_t,kappa,option);
  A2= anisodiff2D(res2,num_iter,delta_t,kappa,option);

 D1=double(res1)-A1;
 D2=double(res2)-A2;
 toc
 
%% guided filter

r = 8;
eps = 0.082/2;

% base layer 1
p = A1;
q = zeros(size(A1));

q(:, :, 1) = guidedfilter(A1(:, :, 1), p(:, :, 1), r, eps);
q(:, :, 2) = guidedfilter(A1(:, :, 2), p(:, :, 2), r, eps);
q(:, :, 3) = guidedfilter(A1(:, :, 3), p(:, :, 3), r, eps);

x_enhanced = (A1 - q) * 5 + q;

% base layer 2

u = A2;
v = zeros(size(A2));

v(:, :, 1) = guidedfilter(A2(:, :, 1), u(:, :, 1), r, eps);
v(:, :, 2) = guidedfilter(A2(:, :, 2), u(:, :, 2), r, eps);
v(:, :, 3) = guidedfilter(A2(:, :, 3), u(:, :, 3), r, eps);

y_enhanced = (A2 - v) * 5 + v;

%%
% Karhunen-Loeve (KL) transform
tic
C1 = cov([D1(:) D2(:)]);
[V11, D11] = eig(C1);
if D11(1,1) >= D11(2,2)
  pca1 = V11(:,1)./sum(V11(:,1));
else  
  pca1 = V11(:,2)./sum(V11(:,2));
end
  
imf1 = pca1(1)*D1 + pca1(2)*D2;
 
% weighted linear superposition 

imf2=(0.5*x_enhanced+0.5*y_enhanced);
        
 
fuseimage=(double(imf1)+double(imf2));

toc
        figure, imshow((fuseimage), [])
        

        