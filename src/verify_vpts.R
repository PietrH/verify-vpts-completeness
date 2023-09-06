library(tidyverse)
library(data.table)

# reduce aws ls results to radar + isodate identity chr
found <-
  data.table::fread("data/aws_ls.txt", select = 4)$V4 %>%
  basename() %>%
  stringr::str_sub(end = -5L) %>%
  stringr::str_remove("_vpts_") %>% 
  tibble(identity = ., present = TRUE)

# split and recombine, then match on radar + isodate identity chr
readr::read_csv("data/coverage.csv", col_select = "directory", show_col_types = FALSE) %>% 
  tidyr::separate_wider_delim(
    directory,
    delim = "/",
    names = c("source", "format", "radar", "year", "month", "day")
  ) %>% 
  mutate(identity = paste0(radar,year,month,day)) %>% 
  left_join(found, by = join_by(identity)) %>% 
  tidyr::replace_na(list(present = FALSE))
