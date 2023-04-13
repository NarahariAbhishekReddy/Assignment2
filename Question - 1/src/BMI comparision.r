# Load required libraries
library(tidyverse)

# Read the CSV file into a dataframe
df <- read.csv('C:/Users/abhis/Downloads/diabetes.csv')

# Calculate the 98th percentile of BMI for the sample
sample_bmi<- quantile(df$BMI, 0.98)

# Calculate the 98th percentile of BMI for the population
population_bmi<- quantile(df$BMI, 0.98, type = 6)

# Create a dataframe for the percentile values
percentile_df <- data.frame(Group = c("Population", "Sample"),
                            Value = c(population_bmi, sample_bmi))

# Reshape the data to long format
percentile_df <- percentile_df %>% gather(key = "Group", value = "Value")

# Create a bar chart to compare the 98th percentile of BMI between sample and population
ggplot(percentile_df, aes(x = Group, y = Value, fill = Group)) +
  geom_bar(stat = "identity", alpha = 0.8, width = 0.5) +
  labs(title = "Comparison of 98th Percentile of BMI - Sample vs Population",
       x = "Group", y = "98th Percentile of BMI") +
  theme_minimal()
