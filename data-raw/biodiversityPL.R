## code to prepare `biodiversityPL` dataset goes here

biodiversityPL <- readr::read_csv("data-raw/occurences_and_media_PL.csv") |>
  dplyr::mutate(vernacularName = ifelse(is.na(vernacularName), "(Not Available)", vernacularName),
                scientificName = ifelse(is.na(scientificName), "(Not Available)", scientificName))

usethis::use_data(biodiversityPL, overwrite = TRUE)
