% Importar una imagen seleccionada por el usuario
[filename, pathname]=uigetfile({'*.jpg';'*.ppm';'*.png';'*.jpeg'},'Select An Image');
% Obtener la ruta absoluta de la imagen
fullPath = strcat(pathname,filename);
% Importar la imagen como una variable
img = imread(fullPath);
% Vector vac�o para guardar las caracter�sticas que
% se le extraigan a la imagen
caracteristicas = [];
% Redimensi�n de la imagen
img = imresize(img, [300 300]);
figure(1);imshow(img);
% Se extraen las caracter�sticas del histograma de vectores de soporte
[Xsample, fig] = extractHOGFeatures(img);
% Se cargan los par�metros correspondientes al modelo de predicci�n
load('vectorPropio.mat')
load('valorPropio.mat')
% Se cargan las etiquetas de las se�ales de tr�nsito
load('labels.mat')
% Se cargan los datos de entrenamiento del modelo, extra�dos de las
% im�genes de la base de datos
load('HOGFeatures.mat');
load('clases.mat');
Xtrain = caracteristicas;
Ytrain = clases;

porcentaje = 0;
x=0;
% Con el m�todo PCA se ordenan descendentemente las caracter�sticas con
% mayor peso, se establece un margen de 0.90 para tomar la caracter�sticas
% a ser usadas entre el total extra�das por HOG
while porcentaje<0.90
    x=x+1;
    porcentaje = porcentaje + (valorPropio(x)/sum(valorPropio));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se seleccionan las caracter�sticas de las muestras de entrenamiento
% y la que se quiere evaluar, correspondientes a las caracter�sticas
% seleccionadas por el c�lculo en el valor propio
Xtest = Xsample*vectorPropio(:,1:x);
Xtrain = Xtrain*vectorPropio(:,1:x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se normalizan las muestras para evitar que haya polarizaci�n en los
% datos debido a la diferencia en los valores, tambi�n se encuentran media
% y desviaci�n est�ndar de los datos
[Xtrain, mu, sigma] = zscore(Xtrain);
Xtest = (Xtest-repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

% Se entrena el modelo de predicci�n como un modelo de mezclas gaussianas
% utilizando los datos de las muestras de entrenamiento, y se muestra el
% valor de la evaluaci�n de la muestra que se quiere clasificar
[classification] = classify(Xtest, Xtrain, Ytrain, 'linear');

% Se selecciona el nombre de la muestra seg�n la clasificaci�n hecha
text = ['La se�al de tr�nsito es: '+labels(classification)];
disp(text);
