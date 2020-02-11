library(jsonlite)
library(tidyverse)
library(dplyr)

file_names <- list.files("/Users/thiloshonnagarajah/RProjects/AutoMLR 2.0/data/qualities", pattern="*.json", full.names=TRUE)
qualities <- data.frame()

for (file in file_names) {
  print(file)
  quality_list <- fromJSON(file)
  
  quality_list$data_qualities$quality$value <- as.numeric(quality_list$data_qualities$quality$value)
  
  quality_df <- setNames(data.frame(t(quality_list[[1]]$quality[,-1])), quality_list[[1]]$quality[,1])
  quality_df$id <- gsub(".json", "", gsub("/Users/thiloshonnagarajah/RProjects/AutoMLR 2.0/data/qualities/", "", file))
  qualities <- bind_rows(qualities, quality_df)
}


