# Load required libraries
install.packages(c("fitdistrplus", "markovchain", "nlstools"))
library(fitdistrplus)
library(markovchain)
library(nlstools)


# Distribution Fit Example (Replace total_sp with your threshold species vector)


# Example seed data: remove this and insert your data
set.seed(100)
total_sp <- c(8, 2, 36, 13, 9, 85, 88, 25, 143, 90, 91, 95, 109) # your country-level threatened species counts

fit_nb <- fitdist(total_sp, "nbinom")

png("visualizations/distribution_fit.png", width=800, height=600)
hist(total_sp, breaks=30, col="lightblue", main="Distribution Fit of Threatened Species Counts",
     xlab="Number of Threatened Species", ylab="Frequency")
x_vals <- seq(min(total_sp), max(total_sp), length=100)
y_vals <- dnbinom(x_vals, size=fit_nb$estimate["size"], mu=fit_nb$estimate["mu"])
lines(x_vals, y_vals * length(total_sp) * diff(hist(total_sp, plot=FALSE)$breaks)[1], col="red", lwd=2)
legend("topright", legend="Fitted Negative Binomial Distribution", col="red", lwd=2)
dev.off()
