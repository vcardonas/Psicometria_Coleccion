#==========================================================================#
#                    Métodos Cuantitativos en Psicología                   #
#                             Análisis de Rasch                            #          
#==========================================================================#

#================================#
#### 1. Directorio de trabajo ####
#================================#
getwd()
setwd("/Users/valentinacardona/Downloads")

#==================================#
#### 2. Instalación de paquetes ####
#==================================#

install.packages("easypackages")
library(easypackages)
install_packages("readxl", "ltm", "eRm", "plyr", "WrightMap")
libraries ("readxl", "ltm", "eRm", "plyr", "WrightMap")

#==================================#
####  3. Importación de datos   ####
#==================================#
datosPCM <- read_excel("Base Rasch.xlsx", sheet = 'PCM')
datosGRM <- read_excel("Base Rasch.xlsx", sheet = 'GRM')

datosPC <- datosPCM[, 2:25]
datosGRM <- datosGRM[, 1:15]

#===============================================#
####        4.1 Partial Credit Model         ####
#===============================================#
PC_model <- PCM(datosPC)

info <- item_info(PC_model)
plotINFO(PC_model, type="item")

summary(PC_model)

thresholds(PC_model)

thresholds(PC_model)$se.thresh

ppar <- person.parameter(PC_model)
summary(ppar)

ppar$theta.table

plot(ppar, xlab = "Puntaje bruto", ylab = "Nivel de rasgo (Theta)",
     main = "Nivel de rasgo segun puntaje bruto")

it_fit <- itemfit(ppar); it_fit
pp_fit <- personfit(ppar); pp_fit

plotPImap(PC_model)

plotICC(PC_model,
        ask = FALSE,
        xlim = c(-8,8))

plotINFO(PC_model)

print(it_fit,
      sort_by = "outfit_t",
      decreasing = T,
      digits = 2)

plotPWmap(PC_model, pmap = FALSE, imap = TRUE)
plotPWmap(PC_model, pmap = TRUE, imap = FALSE)

#===============================================#
####        4.2 Graded Response Model        ####
#===============================================#
GRM_model <- grm(datosGRM)
GRM_model$coefficients
coef(GRM_model)

plot(GRM_model)

factor.scores(GRM_model)

plot(GRM_model,
     type = 'ICC',
     ask = F)

#===============================================#
####     5. Differential Item Functioning     ####
#===============================================#
gender <- as.factor(datosPCM$gender)
levels(gender) <- c("male", "female")

Waldtest(PC_model, splitcr = gender)

lrt_gender <- LRtest(PC_model, splitcr = gender)
lrt_gender

plotGOF(lrt_gender,
        tlab = "item",
        main = "Dificultad por género",
        conf = list(gamma = 0.95, col = 3))

plotDIF(lrt_gender,
        gamma = 0.95,
        main = "Gráfico de IC por género",
        col = c("red", "blue"),
        leg = TRUE,
        legpos = "bottomright",
        splitnames = levels(gender),
        xlab = 'Logits')


plotPWmap(PC_model)
