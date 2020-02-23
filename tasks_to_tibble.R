library(tidyverse)
library(dplyr)
library(OpenML)
library(tibble)


file_names <-
  list.files(
    "/Users/thiloshonnagarajah/RProjects/AutoMLR 2.0/data/tasks",
    pattern = "*.json",
    full.names = TRUE
  )

tasks <- as_tibble(data.frame())

for (file in file_names) {
  print(file)
  run_list <- rjson::fromJSON(file = file)
  
  flatList <- list()
  
  flatList$task.id <- run_list$task$task_id
  flatList$task.type <- run_list$task$task_type
  flatList$dataset <- run_list$task$input[[1]]$data_set$data_set_id
  flatList$estimation.procedure <- run_list$task$input[[2]]$estimation_procedure$type
  f <- lapply(run_list$task$input[[2]]$estimation_procedure$parameter, function(e){
    flatList[e$name] <<- e$value
    })
  
 tryCatch({
    flatList$evaluation.measures <<- run_list$task$input[[4]]$evaluation_measures$evaluation_measure
  }, warning = function(warning_condition) {
    
  }, error = function(error_condition) {
    
    tryCatch({
      flatList$evaluation.measures <<- run_list$task$input[[3]]$evaluation_measures$evaluation_measure
    }, error = function(error_condition) {
      
    })
    
  }, finally={
    
  })
 

  
  task_tibble <- as_tibble(flatList)
  tasks <- bind_rows(tasks, task_tibble)
}

print(tasks)


