# load packages
library(tidyverse)
library(gtsummary)
library(gt)
library(easystats)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")

# multiple linear regression analysis (outcome ~ numeric/continuous)
# y = mx + c (simple linear regression)
# y = m1x1 + m2x2 + m3x3 ... +C

mv_linreg <- lm(Total_QOL_Score ~ Age_of_Participants + Gender + Marital_Status +Type_of_Family + Level_of_Education + Occupational_Status + Area_of_Residence + Economic_Class, data = data)

report(mv_linreg)

# tbl_regression ~ lm
mv_linreg |>
  tbl_regression() |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table6_MV_LinReg.docx")


# multiple logistic regression analysis (outcome ~ binary/categorical)
mv_logreg <- glm(QOL_Status_Binary_Code ~ Age_of_Participants + Gender + Marital_Status +Type_of_Family + Level_of_Education + Occupational_Status + Area_of_Residence + Economic_Class,
                 data = data,
                 family = binomial(link = "logit"))

report(mv_logreg)

# tbl_regression ~ glm
mv_logreg |>
  tbl_regression(exponentiate = T) |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table6_MV_LogReg.docx")
