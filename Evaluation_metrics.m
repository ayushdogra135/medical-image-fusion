close all;
clear all;
clc;

arr=['A';'B'];
for m=1:2
   string=arr(m);
  %    
   inp_image=strcat('images\med256',string,'.png');
  %    

   x{m}=imread(inp_image);
   if(size(x{m},3)==3)
      x{m}=rgb2gray(x{m});
   end
end
[M,N]=size(x{m});

xfused= imread ('fuse.png');

xfused= rgb2gray(xfused);

figure,imshow(x{1})
figure,imshow(x{2})   
figure,imshow(xfused) 

fusion_perform_fn(xfused,x);
   