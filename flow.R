library(httr)

#done
for (flow in 1:17504) {
  # remove index
  
  print(paste("Flow: ", flow))
  
  dest.file <-
    paste(getwd(), "/data/flows/", flow, ".json", sep = "")
  
  r <- GET(paste0(
    "https://www.openml.org/api/v1/json/flow/",
    flow
  ))
  
  if (r$status_code == 200) {
    writeLines(content(r, "text"), dest.file)
  } else {
    print(content(r, "text"))
  }
}

