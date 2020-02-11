library(httr)

#done
for (task in 335002:1000000) {
  # remove index
  
  print(paste("Task: ", task))
  
  dest.file <-
    paste(getwd(), "/data/tasks/", task, ".json", sep = "")
  
  r <- GET(paste0(
    "https://www.openml.org/api/v1/json/task/",
    task
  ))
  
  if (r$status_code == 200) {
    writeLines(content(r, "text"), dest.file)
  } else {
    print(content(r, "text"))
  }
}
