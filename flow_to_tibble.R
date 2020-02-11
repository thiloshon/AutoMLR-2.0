library(jsonlite)
library(tidyverse)
library(dplyr)

file_names <- list.files("/Users/thiloshonnagarajah/RProjects/AutoMLR 2.0/data/flows", pattern="*.json", full.names=TRUE)
flows <- as_tibble(data.frame())

for (file in file_names) {
  print(file)
  flow_list <- fromJSON(file)
  flow_tibble <- map_dfr(flow_list, ~as_tibble(t(.)))
  flows <- bind_rows(flows, flow_tibble)
}


