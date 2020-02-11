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

for (file in file_names) {
  print(file)
  run_list <- fromJSON(file)
  
  flat_list <- list()
  for (i in 1:length(run_list$run)) {
    elem <- run_list$run[[i]]
    
    if (class(elem) != "data.frame" && class(elem) != "list") {
      flat_list[names(run_list$run)[i]] <- run_list$run[i]
      
    } else if (names(run_list$run)[i] == "input_data") {
      flat_list["input_data_dataset"] <- run_list$run[i]
      
    } else if (names(run_list$run)[i] == "output_data") {
      print("1")
      temp <- run_list$run$output_data$evaluation
      if(is.null(temp)){
        next()
      }
      
      for(l in 1 : nrow(temp)){
        flat_list[temp$name[l]] <- temp$value[l]
      }
      
      # flat_list <-
      #   c(flat_list, setNames(split(temp$value, seq(nrow(
      #     temp
      #   ))), temp$name))
      
    } else if (names(run_list$run)[i] == "parameter_setting") {
      print("2")
      temp <- run_list$run$parameter_setting
      print(temp)
      if(class(temp) == "data.frame"){
        for(l in 1 : nrow(temp)){
          flat_list[temp$name[l]] <- temp$value[l]
        }
        # flat_list <-
        #   c(flat_list, setNames(split(temp$value, seq(nrow(
        #     temp
        #   ))), temp$name))
      } else {
        flat_list[run_list$run$parameter_setting$name] <- run_list$run$parameter_setting$value
      }
     
    }
  }
  
  run_tibble <- as_tibble(flat_list)
  runs <- bind_rows(runs, run_tibble)
}

print(runs)
