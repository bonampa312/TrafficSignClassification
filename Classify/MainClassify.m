% Importar una imagen seleccionada por el usuario
[filename, pathname]=uigetfile({'*.jpg';'*.ppm';'*.png';'*.jpeg'},'Select An Image');
% Obtener la ruta absoluta de la imagen
fullPath = strcat(pathname,filename);
% Importar la imagen como una variable
img = imread(fullPath);
% Vector vacío para guardar las características que 
% se le extraigan a la imagen
caracteristicas = [];
% Redimensión de la imagen
img = imresize(img, [300 300]);
figure(1);imshow(img);
% Se extraen las características del histograma de vectores de soporte
[Xsample, fig] = extractHOGFeatures(img);
% Se cargan los parámetros correspondientes al modelo de predicción
load('vectorPropio.mat')
load('valorPropio.mat')
% Se cargan las etiquetas de las señales de tránsito
load('labels.mat')
% Se cargan los datos de entrenamiento del modelo, extraídos de las
% imágenes de la base de datos
load('HOGFeatures.mat');
load('clases.mat');
Xtrain = caracteristicas;
Ytrain = clases;

porcentaje = 0;
x=0;
% Con el método PCA se ordenan descendentemente las características con
% mayor peso, se establece un margen de 0.90 para tomar la características
% a ser usadas entre el total extraídas por HOG
while porcentaje<0.90
    x=x+1;
    porcentaje = porcentaje + (valorPropio(x)/sum(valorPropio));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se seleccionan las características de las muestras de entrenamiento 
% y la que se quiere evaluar, correspondientes a las características 
% seleccionadas por el cálculo en el valor propio
Xtest = Xsample*vectorPropio(:,1:x);
Xtrain = Xtrain*vectorPropio(:,1:x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se normalizan las muestras para evitar que haya polarización en los
% datos debido a la diferencia en los valores, también se encuentran media
% y desviación estándar de los datos
[Xtrain, mu, sigma] = zscore(Xtrain);
Xtest = (Xtest-repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

% Se entrena el modelo de predicción como un modelo de mezclas gaussianas
% utilizando los datos de las muestras de entrenamiento, y se muestra el
% valor de la evaluación de la muestra que se quiere clasificar
[classification] = classify(Xtest, Xtrain, Ytrain, 'linear');

% Se selecciona el nombre de la muestra según la clasificación hecha
text = ['La señal de tránsito es: '+labels(classification)];
disp(text);