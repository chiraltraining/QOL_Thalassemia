# load packages
library(tidyverse)
library(gtsummary)
library(gt)
library(easystats)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")

# correlation (+1 ~ -1)
# r = 1 ~ perfect positive correlation
# r > .5 ~ strong positive correlation
# r = -1 ~ perfect negative correlation
# r > -.5 ~ weak positive correlation

cor(data$Total_QOL_Score, data$Age_of_Participants)
cor(data$Total_QOL_Score, data$Medical_Expense)

# cor test
cor.test(data$Total_QOL_Score, data$Age_of_Participants)

# create numeric data
corr_data <- data |> select(18:28)

# perform correlation analysis
corr_results <- correlation(corr_data)

# summary
corr_results |>
  summary(redundant = T) |>
  plot()
ggsave("figures/test.tiff", units="in", width=15, height=6, dpi=600, compression = 'lzw')
