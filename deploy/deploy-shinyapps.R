# usethis::use_build_ignore("deploy")
if (!requireNamespace("rsconnect"))
  install.packages("rsconnect")
rsconnect::setAccountInfo(
  Sys.getenv("SHINYAPPS_ACCOUNT"),
  Sys.getenv("SHINYAPPS_TOKEN"),
  Sys.getenv("SHINYAPPS_SECRET")
)
rsconnect::deployApp(
  appName = "biodiversityApp",
  # exclude hidden files and renv directory (if present)
  appFiles = setdiff(list.files(), "renv")
)
