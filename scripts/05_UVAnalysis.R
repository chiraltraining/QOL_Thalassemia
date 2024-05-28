# load packages
library(tidyverse)
library(gtsummary)
library(gt)
library(easystats)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")

# Univariate linear regression analysis (outcome ~ numeric/continuous)
# y (Total_QOL_Score) = mx(Gender) + c
uv_lin_model <- lm(Total_QOL_Score ~ Gender, data = data)

# summary
summary(uv_lin_model)

# interpretation
report(uv_lin_model)

# Factors associated with quality of score in the univariate linear regressions analysis
data |>
  select(1:8, Total_QOL_Score) |>
  tbl_uvregression(
    method = lm,
    y = Total_QOL_Score
  ) |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table6_UV_LinReg.docx")

# add ref manually
data$QOL_Status_Binary <- relevel(data$QOL_Status_Binary, ref = "Poor")
data |>
  select(1:8, Total_QOL_Score) |>
  tbl_uvregression(
    method = lm,
    y = Total_QOL_Score,
    add_estimate_to_reference_rows = TRUE # this adds 1 to the coef row
  ) |>
  bold_p(t = 0.05) |>
  as_gt()


# Factors associated with quality of score in the univariate logistic regressions analysis
data |>
  select(1:8, QOL_Status_Binary_Code) |>
  tbl_uvregression(
    method = glm,
    y = QOL_Status_Binary_Code,
    method.args = list(family = binomial),
    exponentiate = T
  ) |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table6_UV_LogReg.docx")
