# ============================================
# BSC STATISTICS PROJECT - REGRESSION ANALYSIS
# Biodiversity & Extinction Risk Prediction
# Author: Saee Kurhade
# Fergusson College, Pune | BSc Statistics
# ============================================

# Install and load required packages
install.packages("nlstools")
library(nlstools)

# ==========================================
# DATA PREPARATION
# ==========================================
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

# ==========================================
# EXPLORATORY VISUALIZATION
# ==========================================
# Plot trends over time
plot(years, total_as, type="l", col="green", lwd=2,
     xlab="Years (2002-2022)", ylab="Number of Species",
     main="IUCN Red List Assessment Trends")
points(years, total_thr, type="l", col="red", lwd=2)
legend("topleft", legend=c("Total Assessed", "Total Threatened"), 
       col=c("green", "red"), lty=c(1,1), lwd=2)

# ==========================================
# LINEAR REGRESSION (Initial Fit)
# ==========================================
# Test linear model first
alm <- lm(total_as ~ years)
blm <- lm(total_thr ~ years)

# Plot linear fits
plot(years, total_as, pch=19)
points(years, total_thr, pch=19, col="blue")
abline(alm, col="green", lwd=2)
abline(blm, col="red", lwd=2)
legend("topleft", legend=c("Linear fit: Total Assessed", "Linear fit: Total Threatened"), 
       col=c("green", "red"), lty=c(1,1))

# Diagnostic plots show non-linearity
par(mfrow=c(2,2))
plot(alm)
plot(blm)

# ==========================================
# NON-LINEAR CUBIC POLYNOMIAL MODEL
# ==========================================
# Model: Y = a + b*X + c*X^2 + d*X^3

# Fit cubic model for TOTAL ASSESSED species
model_assessed <- nls(total_as ~ a + b*years + c*years^2 + d*years^3, 
                      data=data.frame(years, total_as), 
                      start=list(a=100, b=100, c=10, d=10))

# Fit cubic model for TOTAL THREATENED species
model_threatened <- nls(total_thr ~ a + b*years + c*years^2 + d*years^3, 
                        data=data.frame(years, total_thr), 
                        start=list(a=100, b=100, c=10, d=10))

# ==========================================
# MODEL EVALUATION
# ==========================================
# View detailed model summaries
summary(model_assessed)
summary(model_threatened)

# Extract coefficients
coef_assessed <- coefficients(model_assessed)
coef_threatened <- coefficients(model_threatened)

print("Coefficients for Total Assessed Model:")
print(coef_assessed)

print("Coefficients for Total Threatened Model:")
print(coef_threatened)

# ==========================================
# VISUALIZATION OF FITTED MODELS
# ==========================================
# Get fitted values
total_as_fit <- fitted(model_assessed)
total_thr_fit <- fitted(model_threatened)

# Plot observed vs fitted - Total Assessed
plot(years, total_as, pch=19, col="black",
     main="Cubic Regression: Total Assessed Species",
     xlab="Years", ylab="Number of Species")
lines(years, total_as_fit, col="red", lwd=3)
legend("topleft", legend=c("Observed", "Fitted Cubic Model"), 
       col=c("black", "red"), pch=c(19, NA), lty=c(NA, 1), lwd=c(NA, 3))

# Plot observed vs fitted - Total Threatened
plot(years, total_thr, pch=19, col="black",
     main="Cubic Regression: Total Threatened Species",
     xlab="Years", ylab="Number of Species")
lines(years, total_thr_fit, col="blue", lwd=3)
legend("topleft", legend=c("Observed", "Fitted Cubic Model"), 
       col=c("black", "blue"), pch=c(19, NA), lty=c(NA, 1), lwd=c(NA, 3))

# ==========================================
# DIAGNOSTIC PLOTS
# ==========================================
# Check model assumptions
par(mfrow=c(2,2))
plot(nlsResiduals(model_assessed))

par(mfrow=c(2,2))
plot(nlsResiduals(model_threatened))

# ==========================================
# PREDICTIONS FOR FUTURE YEARS (2023-2028)
# ==========================================
# Predict using fitted models
future_years <- 21:26  # Years 2023-2028

# Function to predict using model coefficients
predict_cubic <- function(years_input, coeffs) {
  a <- coeffs[1]
  b <- coeffs[2]
  c <- coeffs[3]
  d <- coeffs[4]
  predictions <- a + b*years_input + c*years_input^2 + d*years_input^3
  return(predictions)
}

# Generate predictions
pred_assessed <- predict_cubic(future_years, coef_assessed)
pred_threatened <- predict_cubic(future_years, coef_threatened)

# Create prediction table
prediction_table <- data.frame(
  Year = 2023:2028,
  Predicted_Assessed = round(pred_assessed, 0),
  Predicted_Threatened = round(pred_threatened, 0)
)

print("Predictions for 2023-2028:")
print(prediction_table)

# Visualize predictions
all_years <- c(years, future_years)
all_assessed <- c(total_as, pred_assessed)
all_threatened <- c(total_thr, pred_threatened)

plot(all_years, all_assessed, type="n",
     xlim=c(0, 26), ylim=c(0, max(all_assessed)),
     xlab="Years (2002-2028)", ylab="Number of Species",
     main="Regression Model with 6-Year Forecast")
lines(years, total_as, col="green", lwd=2)
lines(years, total_thr, col="red", lwd=2)
lines(future_years, pred_assessed, col="green", lwd=2, lty=2)
lines(future_years, pred_threatened, col="red", lwd=2, lty=2)
points(future_years, pred_assessed, pch=19, col="green")
points(future_years, pred_threatened, pch=19, col="red")
legend("topleft", 
       legend=c("Assessed (Observed)", "Threatened (Observed)", 
                "Assessed (Forecast)", "Threatened (Forecast)"), 
       col=c("green", "red", "green", "red"), 
       lty=c(1, 1, 2, 2), lwd=2)

# ==========================================
# EXPORT RESULTS
# ==========================================
# Save prediction table to CSV
write.csv(prediction_table, "species_predictions_2023_2028.csv", row.names=FALSE)

# Save plot as PNG
png("regression_forecast_plot.png", width=800, height=600)
plot(all_years, all_assessed, type="n",
     xlim=c(0, 26), ylim=c(0, max(all_assessed)),
     xlab="Years (2002-2028)", ylab="Number of Species",
     main="IUCN Species Assessment Forecast (2023-2028)")
lines(years, total_as, col="green", lwd=2)
lines(years, total_thr, col="red", lwd=2)
lines(future_years, pred_assessed, col="green", lwd=2, lty=2)
lines(future_years, pred_threatened, col="red", lwd=2, lty=2)
points(future_years, pred_assessed, pch=19, col="green")
points(future_years, pred_threatened, pch=19, col="red")
legend("topleft", 
       legend=c("Assessed (Observed)", "Threatened (Observed)", 
                "Assessed (Forecast)", "Threatened (Forecast)"), 
       col=c("green", "red", "green", "red"), 
       lty=c(1, 1, 2, 2), lwd=2)
dev.off()

print("Analysis complete! Results saved.")
