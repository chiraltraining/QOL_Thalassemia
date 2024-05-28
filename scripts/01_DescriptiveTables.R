# load packages
library(tidyverse)
library(gtsummary)
library(gt)

# import data
data <- read.csv("data/QOL_Thalassemia_Preprocessed.csv")


# Demographic characteristics of study participants
data |>
  select(1:8) |>
  tbl_summary(statistic = list(
    all_continuous() ~ "{mean} ({sd})"
  )) |>
  as_gt() |>
  gtsave("tables/Table1_Demographics.docx")

# Clinical characteristics of thalassemia patients
data |>
  select(9:17) |>
  tbl_summary(type = all_categorical() ~ "categorical",
              statistic = list(all_continuous() ~ "{mean} ({sd})")) |>
  as_gt() |>
  gtsave("tables/Table2_ClinicalChars.docx")
