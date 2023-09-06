library(tidyverse)
library(data.table)

# Read aws s3 ls results and reduce to identity (radaryyyymmdd) and present = TRUE
vpts_daily <-
  data.table::fread("data/aws_ls.txt", select = 4)$V4 %>%
  basename() %>%
  stringr::str_sub(end = -5L) %>%
  stringr::str_remove("_vpts_") %>% 
  tibble(identity = ., present = TRUE)

# Read coverage.csv and split directory
hdf5 <-
  readr::read_csv("data/coverage.csv", col_select = "directory", show_col_types = FALSE) %>% 
  tidyr::separate_wider_delim(
    directory,
    delim = "/",
    names = c("source", "format", "radar", "year", "month", "day")
  ) %>% 
  mutate(identity = paste0(radar, year, month, day))

# Compare files
compare <-
  hdf5 %>%
  left_join(vpts_daily, by = join_by(identity)) %>% 
  tidyr::replace_na(list(present = FALSE))
