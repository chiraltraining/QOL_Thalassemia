# load packages
library(tidyverse)
library(gtsummary)
library(gt)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")

# Difference (2 groups)
# 1. Normal ~ Parametric test ~ t-test
# 2. Non-normal ~ Non-parametric test ~ Wilcoxon rank sum test
# 3. alpha (cut off) ~ p <= 0.05 ~ significant

data |>
  select(Gender, 18:25) |>
  tbl_summary(type = everything() ~ "continuous",
              by = Gender) |>
  add_overall() |>
  add_p() |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table3_Difference2.docx")

# Difference (more than 2 groups)
# 1. Normal ~ Parametric test ~ ANOVA
# 2. Non-normal ~ Non-parametric test ~ Kruskal-Wallis rank sum test
# 3. alpha (cut off) ~ p <= 0.05 ~ significant

data |>
  select(Type_of_Family, 18:25) |>
  tbl_summary(type = everything() ~ "continuous",
              by = Type_of_Family) |>
  add_overall() |>
  add_p() |>
  bold_p(t = 0.05) |>
  as_gt() |>
  gtsave("tables/Table4_Difference3.docx")
