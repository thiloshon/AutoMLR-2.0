library(httr)

# ALl Retrieved
for (qualities in 1:42236) {
  # remove index
  
  print(paste("Quality: ", qualities))
  
  dest.file <-
    paste(getwd(), "/data/qualities/", qualities, ".json", sep = "")
  
  r <- GET(paste0(
    "https://www.openml.org/api/v1/json/data/qualities/",
    qualities
  ))
  
  if (r$status_code == 200) {
    writeLines(content(r, "text"), dest.file)
  } else {
    print(content(r, "text"))
  }
}
