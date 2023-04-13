# Load required libraries
library(tidyverse)

# Read the CSV file into a dataframe
df <- read.csv('C:/Users/abhis/Downloads/diabetes.csv')

# Set the seed for reproducibility
set.seed(222)

# Number of samples to generate
no_samples <- 500

# Number of observations in each sample
no_obs_per_sample <- 150

# Function to calculate mean, standard deviation, and percentile
calculate_stats <- function(data) {
  mean_value <- mean(data)
  sd_value <- sd(data)
  percentile_value <- quantile(data, 0.95)
  return(c(mean_value, sd_value, percentile_value))
}

# Create empty dataframes to store the statistics
sample_stats <- data.frame(matrix(NA, nrow = no_samples, ncol = 3,
                                  dimnames = list(NULL, c("Mean", "StandardDeviation", "Percentile"))))

population_stats <- data.frame(matrix(NA, nrow = 1, ncol = 3,
                                      dimnames = list(NULL, c("Mean", "StandardDeviation", "Percentile"))))

# Loop to generate samples and calculate statistics
for (i in 1:n_samples) {
  # Generate a sample with replacement
  sample <- df[sample(1:nrow(df), n_obs_per_sample, replace = TRUE), ]
  
  # Calculate statistics for the sample
  sample_stats[i, ] <- calculate_stats(sample$BloodPressure)
}

# Calculate statistics for the population
population_stats[1, ] <- calculate_stats(df$BloodPressure)

# Reshape the dataframes to long format
sample_stats <- sample_stats %>% gather(key = "Statistic", value = "Value")
population_stats <- population_stats %>% gather(key = "Statistic", value = "Value")

# Create a bar chart to compare statistics for BloodPressure between sample and population
ggplot() +
  geom_bar(data = sample_stats, aes(x = Statistic, y = Value, fill = "Sample"),
           stat = "identity", position = "dodge") +
  geom_bar(data = population_stats, aes(x = Statistic, y = Value, fill = "Population"),
           stat = "identity", position = "dodge") +
  labs(title = "Comparison of Statistics for BloodPressure - Sample vs Population",
       x = "Statistic", y = "Value", fill = "") +
  theme_minimal()
