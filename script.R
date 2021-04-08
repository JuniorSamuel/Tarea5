
library(dplyr)

library(readxl)
url <- "http://itla.edu.do/transparencia/archivos/page/egresados-oct-2020.xlsx"
destfile <- "egresados_oct_2020.xlsx"
curl::curl_download(url, destfile)
egresados_oct_2020 <- read_excel(destfile)
View(egresados_oct_2020)


data.class(egresados_oct_2020)

datos = data.frame(egresados_oct_2020)
data.class(datos)
View(datos)
datos

#Agrega la colomna de Total egresados.
datos$Total.egresado = datos$Masculino + datos$Femenino


tabla.DS = filter(datos, Carrera %in% c("Tecnologo en Desarrollo de Software", "Tecnologo en  Desarrollo de Software"))

tabla.DS
View(tabla.DS)

reg = lm(Total.egresado ~ Año.de.graduacion, data = tabla.DS)

#Agregar columna de pronostico
tabla.DS$Pronostico = reg$fitted.values
tabla.DS$Error = reg$residuals

reg$residuals

reg

plot( x = tabla.DS$Año.de.graduacion, 
      y = tabla.DS$Total.egresado, 
      main = "Egresados por año de Desarrollo de software",
      #col = "red", 
      xlab = "Año", 
      ylab = "Egresados")
abline(reg, col="blue")


