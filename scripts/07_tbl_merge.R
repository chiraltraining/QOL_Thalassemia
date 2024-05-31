# load packages
library(tidyverse)
library(gtsummary)
library(gt)
library(easystats)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")

# univariate
uv_tbl <- data |>
  select(1:8, Total_QOL_Score) |>
  tbl_uvregression(
    method = lm,
    y = Total_QOL_Score
  )


# multivariate
mv_linreg <- lm(Total_QOL_Score ~ Age_of_Participants + Gender + Marital_Status +Type_of_Family + Level_of_Education + Occupational_Status + Area_of_Residence + Economic_Class, data = data)

report(mv_linreg)

# tbl_regression ~ lm
mv_tbl <- mv_linreg |>
  tbl_regression() |>
  bold_p(t = 0.05)

# merge table
tbl_merge(
  tbls = list(uv_tbl, mv_tbl),
  tab_spanner = c("**Univariate**", "**Multivariate**")
) |>
  as_gt() |>
  gtsave("tables/Table_Merge.docx")





