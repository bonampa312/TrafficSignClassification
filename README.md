# Traffic Sign Recognition :no_entry:

## Integrator project II
### University of Antioquia - Medellín, Colombia

> Guía de elementos:
##### Database
Carpeta que contiene las imágenes usadas en el entrenamiento del modelo de predicción de señales de tránsito
##### HOG
Extracción de las características de las imágenes de la base de datos, para cada imagen extrae el histograma de gradientes orientados y lo almacena en una variable local de matlab, junto con las correspondientes clases de las imágenes.
##### GMMnPCA
Ejecuta el proceso de clasificación de las imágenes convertidas en características desde el script de la carpeta ´HOG´, se realiza un procesado con PCA y luego un proceso de clasificación por un modelo de mezclas gaussianas, luego se realiza una validación cruzada para verificar la eficiencia del modelo utilizado.
##### Classify
Script que actua como producto final, despliega una interfaz gráfica donde se puede elegir una señal de tránsito alojada en el equipo y utiliza los datos de los scripts en carpetas previas para realizar un proceso de clasificación a la señal elegida.

> Señales de tránsito que admite el sistema:

Límite 30km/h	
Límite 50km/h	
Límite 70km/h	
Límite 80km/h	
Límite 120km/h
Vehículo pesado a la izquierda
Carril de prioridad
Ceda el paso
Pare
Prohibido el paso
Carril derecho obligatorio

> Maria Camila Gómez Restrepo

> Santiago Romero Restrepo
