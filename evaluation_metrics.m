clc;
clear;
close all;

arr=['A';'B'];
for m=1:2
   string=arr(m);
  %    
   inp_image=strcat('images\image',string,'.png'); % read two source images
  %    

   x{m}=imread(inp_image);
   if(size(x{m},3)==3)
      x{m}=rgb2gray(x{m});
   end
end
[M,N]=size(x{m});

xfused= imread ('fused.png'); % read fused image
xfused= rgb2gray(xfused);
 

fusion_perform_fn(xfused,x);
   