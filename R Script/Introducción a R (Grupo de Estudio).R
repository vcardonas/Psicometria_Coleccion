#===============================================================================#
#                          R PARA ANÁLISIS DE DATOS
#                   GRUPO DE ESTUDIO DE PROGRAMACIÓN UNAL
#===============================================================================#


#====================#
####   0. ATAJOS  ####
#====================#
# (WIN) Alt + - -> Insertar operador de asignación "<-"
# (MAC) ⌥ + - -> Insertar operador de asignación "<-"
# CTRL + F -> Buscar y reemplazar un valor
# F1 sobre la función -> Documentación de la función
# F2 sobre la función -> Contenido de la función

#====================#
####   1. INPUT  ####
#====================#

#### 1.1 Paths ####

#ENTORNO

# listar objetos dentro de un ambiente
ls()
a <- 2313
ls()

# remover objetos dentro del entorno
rm(a)

a <- 2313
b <- "a"
# remover por lista
rm(list = c(a, b))

# remover todos los objetos del ambiente
rm(list = ls()) # buena práctica: empezar removiendo todo lo que tenga el entorno

# mostrar directorio de trabajo
getwd()

# fijar un directorio de trabajo
setwd("/Users/valentinacardona/Documents/Code Nerd")


#ASIGNAR PATHS

# recrear la ruta
path <- file.path("", "Users", "valentinacardona", "Documents", "Code Nerd")
setwd(path)

# actualizar la ruta
path2 <- file.path(path, "ProjectsData")
setwd(path2)

# ruta de entrada
entradaPath <- file.path("..",       # .. -> salirse de la carpeta
                         "1. Bases de Datos")   # nombre de carpeta


#CARPETAS Y LÓGICOS

# probar que la carpeta existe
dir.exists(entradaPath)

# probar que el archivo existe (default: work directory)
file.exists("keyboard-shortcuts-macos.pdf")
# buscar un archivo fuera: FALSE
file.exists(file.path("..", "keyboard-shortcuts-macos.pdf"))

# listar carpetas y archivos
# cuántas carpetas hay dentro de una carpeta
list.dirs(entradaPath)
list.dirs(file.path("..", "GitHub"),
          recursive = TRUE,          # buscar dentro de carpetas dentro de carpetas
          full.names = TRUE)          # toda la dirección completa
# cuántos archivos hay
list.files(entradaPath)

# crear una carpeta
dir.create(path = file.path("..", "ProjectsData",     # buscar donde se quiere almacenar
                            "Ejemplos"))           # nombre de carpeta creada


#### 1.2 Gestión Documental ####

list.files(entradaPath)

# ACCIONES SOBRE ARCHIVOS
# copiar un archivo en otra carpeta
file.copy(from = file.path(entradaPath, "data.csv"),
          to = file.path("..", "ProjectsData", "Ejemplos", "elarchivodeejemplo.csv"), # cambiar nombre archivo
          overwrite = TRUE) # reescribir archivo

# preguntar si el archivo no existe
!file.exists(file.path("..", "ProjectsData", "Ejemplos", "elarchivodeejemplo.csv"))


#### 1.3 Importar archivos ####

# TEXTO PLANO

# leer un archivo de texto
# cada línea como una variable
b <- readLines("/Users/valentinacardona/Documents/Code Nerd/1. Bases de Datos/SPSS/Base de Datos 1 /Base_de_Datos_Texto_Ejemplo1.txt",
          warn = FALSE)
as.data.frame(b)

# tabulación guardado como dataframe
read.delim("/Users/valentinacardona/Documents/Code Nerd/1. Bases de Datos/SPSS/Base de Datos 1 /Base_de_Datos_Texto_Ejemplo1.txt",
           sep = ";")


#====================#
####  2. SOURCE   ####
#====================#

#### 2.1 Estilo de Programación ####

#OPERADORES JUNTOS
#$ # navegar entre objetos
#! # negación

#OPERADORES SEPARADOS
# = & % | ; , ~ + - * /  # relación entre objetos

# = (argumentos)
# <- (asignación objetos)


#### 2.2 REGEX ####

a <- list.files("/Users/valentinacardona/Documents/Code Nerd/1. Bases de Datos", full.names = TRUE)
class(a)

# FUNCIONES VECTORIALES

# matching (coincidencia)
# grep = vector de posiciones
grep(pattern = ".xlsx",         # patrón
     x = a,                     # objeto que se va a utilizar
     ignore.case = TRUE,        # matching sin importar mayúscula o minúscula
     value = TRUE)              # para traer los valores, no las posiciones

grep(pattern = ".xlsx", x = a, ignore.case = TRUE, value = TRUE,
     invert = TRUE)              # todos los que no son coincidentes con el patrón

# grepl = vector lógico
(c <- grepl(pattern = ".xlsx", x = a, ignore.case = TRUE))
sum(c) # suma de los que cumplen la condición

grep(pattern = "(I\\.xlsx)$", x = a, value = TRUE)

# FUNCIONES DE LISTADO
regexpr()
gregexpr()
regexec()
gregexec()

#### 2.3 STRINGS ####

#### 2.4 Características Relevantes ####



#https://www.datos.gov.co/Educaci-n/Saber-11-2019-2/ynam-yc42


