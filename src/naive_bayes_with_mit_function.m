%MATLAB code to generate 2D images for plant viruses, apply naive bayes classification algorithm

clear;
clc;
X_comb = [];

%Genomes downloaded from NCBI database that belongs to 3 virus classes: Tobacco mosaic virus, Banana bunchy top virus, and Cauliflower mosaic virus
genome = {'HE818416' 'HE818417' 'HE818452' 'HE818453' 'HE818454' 'JF957688' 'JF957689' 'JF957690' 'JF957691' 'JF957692' 'AB863198' 'AB863199' 'AB863200' 'AB863201' 'AB863202'}

fimgs = [];
for i = 1:length(genome)
    mitochondria = getgenbank(genome{i},'SequenceOnly',true);
    fimg = mit_to_img(mitochondria);
    S1 = reshape(fimg,[],1);
    X_comb = [X_comb,S1];
end
X1 = transpose(X_comb);
X=[];
for i = 1:size(X1, 2)
    if(~any(X1(:,i)==0))
        X = [X,X1(:,i)];
    end
end

Y = categorical(["Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ]);

%Apply fitcnb MATLAB function
Mdl = fitcnb(X, Y);

disp(Mdl);

Mdl.ClassNames

Mdl.Prior

Mdl.DistributionParameters

isLabels1 = resubPredict(Mdl);

ConfusionMat1 = confusionchart(Y,isLabels1);

%function to generate 2D gray scale images for plant virus genomes
function f = mit_to_img(mitochondria) 
    seq= mitochondria(1:400);
    img(500,500) = 50; %% define image
    simg=size(img);
    x=simg(1)/2; y=simg(2)/2; % initial position
    s=size(seq);
    %A T G C
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
