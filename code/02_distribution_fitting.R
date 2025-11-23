# ============================================
# DISTRIBUTION FITTING - NEGATIVE BINOMIAL
# Country-wise Threatened Species Analysis
# Author: Saee Kurhade
# ============================================

library(MASS)
library(fitdistrplus)

# Assuming total_sp is a numeric vector of threatened species count per country
# Load your data here, for example:
data <- read.csv("C:\Users\SAEE KURHADE\Desktop\Stats Project\Distibution_Data.csv",header TRUE)
head(data)
total_sp <- as.numeric(gsub(",","",data$Total))

# Exploratory analysis
plotdist(total_sp, histo=TRUE, demp=TRUE, breaks=32)
descdist(total_sp, discrete=TRUE, boot=1000)

# Fit distributions
plot.legend=c('poisson','geometric','negative binomial')
fpoi <- fitdist(total_sp, "pois")
fgeom <- fitdist(total_sp, "geom")
fnbin <- fitdist(total_sp, "nbinom")

# Compare distributions
par(mfrow=c(2,2))
denscomp(list(fpoi, fgeom, fnbin), legendtext=c("Poisson", "Geometric", "Negative Binomial"))
qqcomp(list(fpoi, fgeom, fnbin))
cdfcomp(list(fpoi, fgeom, fnbin))
ppcomp(list(fpoi, fgeom, fnbin))

# Remove outliers
boxplot(total_sp, main= 'Box plot for entire data')
total_sp_rm <- total_sp[!total_sp %in% boxplot.stats(total_sp)$out]
boxplot(total_sp_rm, main='Box plot after removing outliers')
length(total_sp) − length(total_sp_rm)
 
hist(total_sp_rm , breaks=32,prob=TRUE)
descdist(total_sp_rm , discrete=TRUE, boot=1000)
 
par(mfrow=c(1 ,2))
plot(1:700 ,dnbinom(1:700 , size =1.559133,prob=0.009863068636),type = 'l')
 
fnbin
par(mfrow=c(1 ,1))
hist(total_sp_rm , breaks = 32,prob= TRUE,main='Total number of species threatened countrywise' ,xlab='Number of species threatened ')
points(dnbinom(1:700 , size=fnbin$estimate [1] ,mu=fnbin$estimate [2]) ,
 col='blue' , type='l' ,lwd=2)

