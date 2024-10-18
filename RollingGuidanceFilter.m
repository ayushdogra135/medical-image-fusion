%
%   Rolling Guidance Filter 
%
%   res = RollingGuidanceFilter(I,sigma_s,sigma_r,iteration) filters image
%   "I" by removing its small structures. The borderline between "small"
%   and "large" is determined by the parameter sigma_s. The sigma_r is
%   fixed to 0.1. The filter is an iteration process. "iteration" is used
%   to control the number of iterations.
%   
%   Paras: 
%   @I         : input image, DOUBLE image, any # of channels
%   @sigma_s   : spatial sigma (default 0.7). Controlling the spatial 
%                weight of bilateral filter and also the filtering scale of
%                rolling guidance filter.
%   @sigma_r   : range sigma (default 0.5). Controlling the range weight of
%                bilateral filter. 
%   @iteration : the iteration number of rolling guidance (default 5).
%
%
%   Example
%   ==========
%   I = im2double(imread('image.png'));
%   res = RollingGuidanceFilter(I,0.7,0.5,5);
%   figure, imshow(res);
%
%
%   Note
%   ==========
%   This implementation filters multi-channel/color image by separating its
%   channels, so the result of this implementation will be different with
%   that in the corresponding paper. To generate the results in the paper,
%   please refer to our executable file or C++ implementation on our
%   website.
%
%   ==========
%   The Code is created based on the method described in the following paper:
%   [1] "Rolling Guidance Filter", Qi Zhang, Li Xu, Jiaya Jia, European 
%        Conference on Computer Vision (ECCV), 2014


function res = RollingGuidanceFilter(I,sigma_s,sigma_r,iteration)

if ~exist('iteration','var')
    iteration = 5;
end

if ~exist('sigma_s','var')
    sigma_s = 0.7;
end

if ~exist('sigma_r','var')
    sigma_r = 0.5;
end

res = I.*0; 

for i=1:iteration
    disp(['RGF iteration ' num2str(i) '...']);
    for c=1:size(I,3)
        G = res(:,:,c);
        res(:,:,c) = bilateralFilter(I(:,:,c),G,min(G(:)),max(G(:)),sigma_s,sigma_r);
    end
end

end
