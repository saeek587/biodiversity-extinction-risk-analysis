# ============================================
# DISTRIBUTION FITTING - NEGATIVE BINOMIAL
# Country-wise Threatened Species Analysis
# Author: Saee Kurhade
# ============================================

library(MASS)
library(fitdistrplus)

# Assuming total_sp is a numeric vector of threatened species count per country
# Load your data here, for example:
# data <- read.csv("country_threatened_species.csv")
# total_sp <- data$Total

# Example: Replace with your own data for total_sp vector
# total_sp <- c(...)

# Exploratory analysis
plotdist(total_sp, histo=TRUE, demp=TRUE, breaks=32)
descdist(total_sp, discrete=TRUE, boot=1000)

# Fit distributions
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
total_sp_rm <- total_sp[!total_sp %in% boxplot.stats(total_sp)$out]

# Refit after outlier removal
fnbin_clean <- fitdist(total_sp_rm, "nbinom")
summary(fnbin_clean)
gofstat(list(fnbin_clean))
