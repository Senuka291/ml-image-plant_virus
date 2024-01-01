%MATLAB code to generate 2D images for plant viruses, apply kmeans classification algorithm

clear;
clc;
X_comb = [];

%Genomes downloaded from NCBI database that belongs to 3 virus classes: Tobacco mosaic virus, Banana bunchy top virus, and Cauliflower mosaic virus
genome = {'HE818416' 'HE818417' 'HE818452' 'HE818453' 'HE818454' 'MT433346' 'MT433347' 'MT433348' 'MT433349' 'MT433350' 'AB863198' 'AB863199' 'AB863200' 'AB863201' 'AB863202'}

fimgs = []; 
for i = 1:length(genome)
    mitochondria = getgenbank(genome{i},'SequenceOnly',true);
    fimg = mit_to_img(mitochondria);
    S1 = reshape(fimg,[],1);
    X_comb = [X_comb,S1];
end 
X = transpose(X_comb);

%Calculate for k=2,3,4
[cidx, ctrs] = kmeans(X, 3);

%Apply kmeans MATLAB function
clust = kmeans(X,3);

%Silhoutte graph is generated after using kmeans function
[s,h] = silhouette(X,clust,'Euclidean')

%function to generate 2D gray scale images for plant virus genomes
function f = mit_to_img(mitochondria) 
    seq= mitochondria(1:400);
    img(500,500) = 50; %% define image
    simg=size(img);
    x=simg(1)/2; y=simg(2)/2; % initial position
    s=size(seq);
    for i=1:1:400
        if seq(i)=='A'
            y=y+1;
            img(x,y)=img(x,y)+50;
        elseif seq(i)=='T'
            y=y-1;
            img(x,y)=img(x,y)+50;
        elseif seq(i)== 'G'
            x=x-1;
            img(x,y)=img(x,y)+50;
        elseif seq(i)=='C'
            x=x+1;
            img(x,y)=img(x,y)+50;
        end
    end
   
    fimg=rescale(img);
    imshow(fimg);
    f = fimg;
end
