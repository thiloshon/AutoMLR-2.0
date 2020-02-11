library(httr)

# 10437614
for (run in 500000:600000) {
  # remove index
  
  print(paste("Run: ", run))
  
  dest.file <-
    paste(getwd(), "/data/runs/", run, ".json", sep = "")
  
  r <- GET(paste0(
    "https://www.openml.org/api/v1/json/run/",
    run
  ))
  
  if (r$status_code == 200) {
    writeLines(content(r, "text"), dest.file)
  } else {
    print(content(r, "text"))
  }
}
