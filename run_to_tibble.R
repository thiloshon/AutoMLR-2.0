library(jsonlite)
library(tidyverse)
library(dplyr)

file_names <-
  list.files(
    "/Users/thiloshonnagarajah/RProjects/AutoMLR 2.0/data/runs",
    pattern = "*.json",
    full.names = TRUE
  )
runs <- as_tibble(data.frame())

jkl <- 1

for (file in file_names) {
  jkl <- jkl + 1
  
  print(file)
  run_list <- fromJSON(file)
  
  flat_list <- list()
  for (i in 1:length(run_list$run)) {
    elem <- run_list$run[[i]]
    
    if (class(elem) != "data.frame" && class(elem) != "list") {
      if (names(run_list$run)[i] == "tag") {
        next()
      } else {
        flat_list[names(run_list$run)[i]] <- run_list$run[i]
      }
      
      
    } else if (names(run_list$run)[i] == "input_data") {
      flat_list["input_data_dataset"] <- run_list$run[i]
      
    } else if (names(run_list$run)[i] == "output_data") {
      temp <- run_list$run$output_data$evaluation
      if (is.null(temp)) {
        next()
      }
      
      for (l in 1:nrow(temp)) {
        flat_list[temp$name[l]] <- temp$value[l]
      }
      
      # flat_list <-
      #   c(flat_list, setNames(split(temp$value, seq(nrow(
      #     temp
      #   ))), temp$name))
      
    } else if (names(run_list$run)[i] == "parameter_setting") {
      temp <- run_list$run$parameter_setting
      if (class(temp) == "data.frame") {
        for (l in 1:nrow(temp)) {
          flat_list[temp$name[l]] <- temp$value[l]
        }
        # flat_list <-
        #   c(flat_list, setNames(split(temp$value, seq(nrow(
        #     temp
        #   ))), temp$name))
      } else {
        flat_list[run_list$run$parameter_setting$name] <-
          run_list$run$parameter_setting$value
      }
      
    }
  }
  
  run_tibble <- as_tibble(flat_list)
  runs <- bind_rows(runs, run_tibble)
}

print(runs)
