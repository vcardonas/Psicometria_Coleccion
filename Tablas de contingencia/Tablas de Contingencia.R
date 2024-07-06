#==========================================================================#
#                          Tablas de Contingencia                          #
#                         Valentina Cardona Saldaña                        #
#==========================================================================#

#================================#
#### 1. Directorio de trabajo ####
#================================#
getwd()
setwd("/Users/valentinacardona/Downloads")

#==================================#
#### 2. Instalación de paquetes ####
#==================================#
install.packages('survival')
install.packages('epiR')
library(survival)
library(epiR)

#==================================#
####  3. Importación de datos   ####
#==================================#
datos <- read.csv("Datos/acuerdo interjueces.csv")

#==================================#
####   3. Revisión de datos     ####
#==================================#
View(datos)
names(datos)
dim(datos)
summary(datos)

View(datos_jueces)
names(datos_jueces)
dim(datos_jueces)
summary(datos_jueces)

#======================================#
####   4. Tablas de contingencia    ####
#======================================#
table(datos$juez1, datos$juez2)

juez1 <- factor(datos$juez1,
                levels = c(1,0),
                labels = c("Pertinencia", "No pertinencia"))
juez2 <- factor(datos$juez2,
                levels = c(1,0),
                labels = c("Pertinencia", "No pertinencia"))

tabla_contingencia <- table(juez1,juez2); tabla_contingencia

#FRECUENCIAS RELATIVAS
prop.table(tabla_contingencia) #general
prop.table(tabla_contingencia, margin = 1) #por filas
prop.table(tabla_contingencia, margin = 2) #por columnas

#Añadir totales
addmargins(tabla_contingencia) #frecuencias absolutas
addmargins(prop.table(tabla_contingencia)) #frecuencias relativas

#======================================#
#### 5. Sensibilidad y Especificidad ####
#======================================#
epi.tests(tabla_contingencia)

#======================================#
####    6. Pruebas estadísticas     ####
#======================================#

#Chi-Cuadrado
chisq.test(tabla_contingencia)

#Prueba exacta de Fisher
fisher.test(tabla_contingencia)

#Prueba de McNemar
mcnemar.test(tabla_contingencia)

#Coeficiente de Concordancia (ω) de Kendall
cor(juez1, juez2, method = 'kendall')

#Estadístico Kappa
kappa(tabla_contingencia)

#=================================#
####        7. Gráficos        ####
#=================================#
mosaicplot(tabla_contingencia,
           main = "Acuerdo interjueces")

barplot(tabla_contingencia,
        legend = TRUE,
        beside = TRUE,
        args.legend = list(x = "top"))
