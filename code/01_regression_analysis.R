# ============================================
# BSC STATISTICS PROJECT - REGRESSION ANALYSIS
# Biodiversity & Extinction Risk Prediction
# Author: Saee Kurhade
# Fergusson College, Pune | BSc Statistics
# ============================================

# Install and load required packages
install.packages("nlstools")
library(nlstools)

# Years (2002-2022, indexed from 0)
years <- c(0, 2, 3, 4, 6:22)

# Total species assessed by IUCN Red List per year
total_as <- c(16507, 16697, 22424, 38046, 40174, 41415, 44838, 47677, 
              55926, 61914, 65518, 71576, 76199, 79837, 85604, 91523, 
              96951, 112432, 128918, 142577, 150388)

# Total threatened species per year
total_thr <- c(11046, 11167, 12259, 15503, 16116, 16306, 16928, 17291, 
               18351, 19570, 20219, 21286, 22413, 23250, 24307, 25821, 
               26840, 30178, 35765, 40084, 42108)

# Plot trends over time
plot(years, total_as, type="l", col="green", lwd=2,
     xlab="Years (2002-2022)", ylab="Number of Species",
     main="IUCN Red List Assessment Trends")
points(years, total_thr, type="l", col="red", lwd=2)
legend("topleft", legend=c("Total Assessed", "Total Threatened"), 
       col=c("green", "red"), lty=c(1,1), lwd=2)

# Non-linear Cubic Polynomial Model
model_assessed <- nls(total_as ~ a + b*years + c*years^2 + d*years^3, 
                      data=data.frame(years, total_as), 
                      start=list(a=100, b=100, c=10, d=10))

model_threatened <- nls(total_thr ~ a + b*years + c*years^2 + d*years^3, 
                        data=data.frame(years, total_thr), 
                        start=list(a=100, b=100, c=10, d=10))

# Summaries
summary(model_assessed)
summary(model_threatened)

# Predict for future years (2023-2028)
future_years <- 21:26

predict_cubic <- function(years_input, coeffs) {
  a <- coeffs[1]
  b <- coeffs[2]
  c <- coeffs[3]
  d <- coeffs[4]
  predictions <- a + b*years_input + c*years_input^2 + d*years_input^3
  return(predictions)
}

pred_assessed <- predict_cubic(future_years, coefficients(model_assessed))
pred_threatened <- predict_cubic(future_years, coefficients(model_threatened))

# Save results
prediction_table <- data.frame(
  Year = 2023:2028,
  Predicted_Assessed = round(pred_assessed, 0),
  Predicted_Threatened = round(pred_threatened, 0)
)
write.csv(prediction_table, "species_predictions_2023_2028.csv", row.names=FALSE)
