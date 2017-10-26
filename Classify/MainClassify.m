% Importar una imagen seleccionada por el usuario
[filename, pathname]=uigetfile({'*.jpg;*.ppm;*.png;*.jpeg'},'Select An Image');
% Obtener la ruta absoluta de la imagen
fullPath = strcat(pathname,filename);
% Importar la imagen como una variable
img = imread(fullPath);
% Vector vacï¿½o para guardar las caracterï¿½sticas que
% se le extraigan a la imagen
caracteristicas = [];
% Redimensiï¿½n de la imagen
img = imresize(img, [300 300]);
figure(1);imshow(img);
% Se extraen las caracterï¿½sticas del histograma de vectores de soporte
[Xsample, fig] = extractHOGFeatures(img);
% Se cargan los parï¿½metros correspondientes al modelo de predicciï¿½n
load('vectorPropio.mat')
load('valorPropio.mat')
% Se cargan las etiquetas de las seï¿½ales de trï¿½nsito
load('labels.mat')
% Se cargan los datos de entrenamiento del modelo, extraï¿½dos de las
% imï¿½genes de la base de datos
load('HOGFeatures.mat');
load('clases.mat');
Xtrain = caracteristicas;
Ytrain = clases;

porcentaje = 0;
x=0;
% Con el mï¿½todo PCA se ordenan descendentemente las caracterï¿½sticas con
% mayor peso, se establece un margen de 0.90 para tomar la caracterï¿½sticas
% a ser usadas entre el total extraï¿½das por HOG
while porcentaje<0.90
    x=x+1;
    porcentaje = porcentaje + (valorPropio(x)/sum(valorPropio));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se seleccionan las caracterï¿½sticas de las muestras de entrenamiento
% y la que se quiere evaluar, correspondientes a las caracterï¿½sticas
% seleccionadas por el cï¿½lculo en el valor propio
Xtest = Xsample*vectorPropio(:,1:x);
Xtrain = Xtrain*vectorPropio(:,1:x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se normalizan las muestras para evitar que haya polarizaciï¿½n en los
% datos debido a la diferencia en los valores, tambiï¿½n se encuentran media
% y desviaciï¿½n estï¿½ndar de los datos
[Xtrain, mu, sigma] = zscore(Xtrain);
Xtest = (Xtest-repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

% Se entrena el modelo de predicciï¿½n como un modelo de mezclas gaussianas
% utilizando los datos de las muestras de entrenamiento, y se muestra el
% valor de la evaluaciï¿½n de la muestra que se quiere clasificar
[classification] = classify(Xtest, Xtrain, Ytrain, 'linear');

% Se selecciona el nombre de la muestra segï¿½n la clasificaciï¿½n hecha
text = ['El señal es ',labels{classification}];
disp(text);
