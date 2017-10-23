clear all, close all, clc
caracteristicas = [];
clases = [];
carpetas = readFolders(pwd);
for fold = carpetas
    folder = strcat(fold{1},'\');
    ext = str2num(fold{1}(end-1:end));
    strFiles = strcat(folder,'*.ppm');
    files = dir(strFiles);
    for file = files'
        name = strcat(folder,file.name);
        img = imread(name);
        img = imresize(img, [300 300]);
        [vect, fig] = extractHOGFeatures(img);
        caracteristicas = [caracteristicas; vect];
        clases = [clases; ext];
%       figure;imshow(img);hold on;plot(fig);
    end
end
