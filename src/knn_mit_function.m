%MATLAB code to generate 2D images for plant viruses, apply knn classification algorithm
clear;
clc;
X_comb = [];

%Genomes downloaded from NCBI database that belongs to 3 virus classes: Tobacco mosaic virus, Banana bunchy top virus, and Cauliflower mosaic virus
genome = {'HE818416' 'HE818417' 'HE818452' 'HE818453' 'HE818454' 'MT433346' 'MT433347' 'MT433348' 'MT433349' 'MT433350' 'AB863198' 'AB863199' 'AB863200' 'AB863201' 'AB863202'};

for i = 1:length(genome)
    disp(i);
    mitochondria = getgenbank(genome{i},'SequenceOnly',true);
    fimg = mit_to_img(mitochondria);
    S1 = reshape(fimg,[],1);
    X_comb = [X_comb,S1];
end
X = transpose(X_comb);
Y = genome;

Y = categorical(["Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Tobacco mosaic" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Banana bunchy" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ; "Cauliflower mossaic" ]);

Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);

disp(Mdl);

% checking md1 is trained by displaying class names

Mdl.ClassNames

% Checking the class probabilities in the trained Md1 model

Mdl.Prior

predictedY = resubPredict(Mdl);

cm = confusionchart(Y,predictedY);

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


