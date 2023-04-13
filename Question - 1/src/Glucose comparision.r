
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Set seed for reproducibility
set.seed(123)

# Load data
data <- read.csv("C:/Users/abhis/Downloads/diabetes.csv")

# Take a random sample of 25 observations
sample_size <- 25
sample <- data %>% sample_n(sample_size)

# Calculate mean and highest Glucose values of the sample
sample_mean_glucose <- mean(sample$Glucose)
sample_highest_glucose <- max(sample$Glucose)

# Calculate population statistics
population_mean_glucose <- mean(data$Glucose)
population_highest_glucose <- max(data$Glucose)

# Create a scatter plot for comparison
ggplot() +
  geom_point(data = sample, aes(x = Glucose, y = Outcome), color = "blue", alpha = 0.5) +
  geom_point(data = data, aes(x = Glucose, y = Outcome), color = "red", alpha = 0.5) +
  geom_vline(xintercept = sample_mean_glucose, linetype = "dashed", color = "blue", 
             size = 1, show.legend = FALSE) +
  geom_vline(xintercept = population_mean_glucose, linetype = "dashed", color = "red", 
             size = 1, show.legend = FALSE) +
  annotate("text", x = sample_mean_glucose, y = 1.5, label = paste0("Sample Mean: ", round(sample_mean_glucose, 2)), 
           color = "blue", hjust = -0.1) +
  annotate("text", x = population_mean_glucose, y = 1.5, label = paste0("Population Mean: ", round(population_mean_glucose, 2)), 
           color = "red", hjust = 1.1) +
  labs(x = "Glucose", y = "Outcome", title = "Comparison of Glucose Statistics: Sample vs. Population") +
  theme_minimal()

