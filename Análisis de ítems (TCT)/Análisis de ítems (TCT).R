#===========================================================================#
#                           Análisis de ítems: TCT                          #
#                          Valentina Cardona Saldaña                        #
#===========================================================================#

#======================================#
####    1. Directorio de trabajo    ####
#======================================#
getwd()
#setwd("D:/Usuario/Downloads")

#======================================#
####   2. Instalación de paquetes   ####
#======================================#
install.packages("easypackages")
library(easypackages)
install_packages("readxl", "CTT", "psychometric")
libraries("readxl", "CTT", "psychometric")

#======================================#
####    3. Importación de datos     ####
#======================================#
datos <- read_excel("Datos/DatosAI.xlsx", sheet = "Datos")
claves <- read_excel("Datos/DatosAI.xlsx", sheet = "Claves")
datospoly <- read_excel("Datos/DatosAI.xlsx", sheet = "DatosPoly")

#======================================#
####   4. Transformación de datos   ####
#======================================#
# calificar respuestas de ítems de acuerdo a sus claves
puntajes <- score(datos,
                  claves,
                  output.scored = TRUE,     # se devuelve matriz con ítems puntuados
                  rel = TRUE)               # estimación de confiabilidad
puntajes

punt_total <- puntajes$score                 # puntajes totales 
respuestas <- as.data.frame(puntajes$scored) # transformación de puntajes (matriz a df)

View(respuestas)

colnames(respuestas) <- colnames(datos) # cambiar nombres de las columnas

#======================================#
####     5. Revisión de datos       ####
#======================================#
# estadísticos más útiles para el análisis de ítems en psicometría
psych::describe(punt_total) 
hist(punt_total,
     main = "Histograma de puntuaciones totales",
     xlab = "Puntuaciones totales",
     ylab = "Frecuencias",
     col = "#004B73")

#======================================#
####      6. Análisis de ítem       ####
#======================================#
analisis <- itemAnalysis(respuestas,        # ítems calificados
                         itemReport = TRUE) # si TRUE, se realiza análisis de ítems
str(analisis)

#======================================#
#### 7. Discriminación y Dificultad ####
#======================================#
# reporte de los items
analisis <- analisis$itemReport
View(analisis)

# cambiar nombres
colnames(analisis)[2:3] <- c("Dificultad", "Discriminación")

# ordenar por dificultad o discriminación
analisis_ordenado <- analisis[order(analisis$Dificultad,    # columna a ordenar
                                    decreasing = FALSE), ]  # orden ascendente o descendente 
analisis_ordenado

#======================================#
####          8. Gráficas           ####
#======================================#
#función para graficas
item.graph <- function(analisis, va = c("Dificultad", "Discriminación"), h = NULL){
  
  df2 <- data.frame(item = 1:length(analisis[,va]),
                    va = analisis[,va])
  
  plot(df2,                                  # tabla a graficar
       type = "p",                           # tipo de gráfico (p : points)
       cex = 3,                              # tamaño del símbolo
       col = "purple",                       # color del símbolo
       ylab = va,                            # etiqueta de eje y
       xlab = "Número de ítem",              # etiqueta de eje x
       ylim = c(0, 1),                       # longitud de eje y
       main = paste(va,"de los ítems de la prueba"))   # título
  
  # agrega una línea recta sobre el gráfico
  abline(h = h,                              # el valor en eje y
         col = "red")                        # color de la línea 
  
  # agrega nombre a los ítems
  text(df2,
       paste("i", df2[,1], sep = ""),
       col = "red",
       cex = .7)
  
  names(df2)[names(df2) == 'va'] <- va      # renombrar columna 
  return(df2[order(df2[,va]),])             # retornar tabla ordenada
}

item.graph(analisis,
           va = "Discriminación",
           h = 0.4)

item.graph(analisis,
           va = "Dificultad")

# curvas características de ítems
cttICC(score = punt_total,          # para crear valores medios esperados del ítem
       itemVector = respuestas[,4], # respuestas observadas del ítem
       colTheme = "spartans")       # tema de color

cttICC(score = punt_total,
       itemVector = respuestas[,18],
       colTheme = "cavaliers")

# Ciclo para graficar por cada item
for (i in 1:ncol(respuestas)){
  cttICC(score = punt_total,
         itemVector = respuestas[,i],
         colTheme = "spartans",
         plotTitle = paste("Item",i,"Characteristic Curve")) # título
}

#======================================#
####          8.            ####
#======================================#
distractorAnalysis(datos, claves, validResp = "fromItem")

alpha(datospoly)

analisispoly <- item.exam(datospoly)
analisispoly <- analisispoly[, c(1:4, 7, 8)]
analisispoly

discrim(datospoly)


cttICC(score = punt_total, itemVector = datospoly[, 6])
