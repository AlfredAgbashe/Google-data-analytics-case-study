# Step 1: Load necessary libraries
library(tidyverse)     # For data manipulation and visualization
library(readxl)        # For reading Excel files
library(ggplot2)       # For creating plots
library(writexl)       # For exporting to Excel

# Step 2: Load the CSV datasets
activity <- read_csv("dailyActivity_merged.csv")
sleep <- read_csv("sleepDay_merged.csv")
weightlog <- read_csv("weightLogInfo_merged.csv")

# Step 3: Convert date columns to proper Date format
activity <- activity %>% mutate(ActivityDate = as.Date(ActivityDate, "%m/%d/%Y"))
sleep <- sleep %>% mutate(SleepDay = as.Date(SleepDay, "%m/%d/%Y"))

# Step 4: Remove duplicate entries if any
activity <- distinct(activity)
sleep <- distinct(sleep)

# Step 5: Merge the activity and sleep data on date
combined <- inner_join(activity, sleep, by = c("ActivityDate" = "SleepDay"))

# Step 6: View a snapshot of the combined data
View(combined)

# Step 7: Generate summary statistics
summary(combined$TotalSteps)
summary(combined$Calories)
summary(combined$TotalMinutesAsleep)

# Step 8: Create a scatter plot - Total Steps vs Calories Burned
ggplot(combined, aes(x = TotalSteps, y = Calories)) +
  geom_point(color = "steelblue") +
  labs(title = "Total Steps vs Calories Burned")

# Step 9:Add SleepHours column for easier analysis
combined = combined %>% mutate(SleepHours = TotalMinutesAsleep / 60)

# Step 10: Export the combined data to Excel for use in Excel dashboards
write_xlsx(combined, "combined_data.xlsx")