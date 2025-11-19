# Load required libraries
install.packages(c("fitdistrplus", "markovchain", "nlstools"))
library(fitdistrplus)
library(markovchain)
library(nlstools)

# -----------------------------------------
# Data Preparation (replace as per your data)
years <- c(0, 2, 3, 4, 6:22)
total_as <- c(16507, 16697, 22424, 38046, 40174, 41415, 44838, 47677, 
              55926, 61914, 65518, 71576, 76199, 79837, 85604, 91523, 
              96951, 112432, 128918, 142577, 150388)
total_thr <- c(11046, 11167, 12259, 15503, 16116, 16306, 16928, 17291, 
               18351, 19570, 20219, 21286, 22413, 23250, 24307, 25821, 
               26840, 30178, 35765, 40084, 42108)

# Regression models
model_assessed <- nls(total_as ~ a + b*years + c*years^2 + d*years^3, start=list(a=100, b=100, c=10, d=10))
model_threatened <- nls(total_thr ~ a + b*years + c*years^2 + d*years^3, start=list(a=100, b=100, c=10, d=10))

predict_cubic <- function(years_input, coeffs) {
  a <- coeffs[1]; b <- coeffs[2]; c <- coeffs[3]; d <- coeffs[4]
  a + b*years_input + c*years_input^2 + d*years_input^3
}

future_years <- 21:26
pred_assessed <- predict_cubic(future_years, coefficients(model_assessed))
pred_threatened <- predict_cubic(future_years, coefficients(model_threatened))

# Save regression curves plot
png("visualizations/regression_curves.png", width=800, height=600)
plot(years, total_as, type="l", col="green", lwd=2, xlab="Years (2002-2022)", ylab="Number of Species",
     main="IUCN Red List Assessment Trends and Forecast")
points(years, total_thr, type="l", col="red", lwd=2)
lines(2023:2028, pred_assessed, col="green", lwd=2, lty=2)
lines(2023:2028, pred_threatened, col="red", lwd=2, lty=2)
legend("topleft", legend=c("Total Assessed", "Total Threatened", "Forecast Assessed", "Forecast Threatened"),
       col=c("green", "red", "green", "red"), lty=c(1,1,2,2))
dev.off()

