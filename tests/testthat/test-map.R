test_that("createInfoTable works and returns expected results", {

  randomSpec <- biodiversityPL$scientificName[round(runif(1, 1, nrow(biodiversityPL)))]
  res <- createInfoTable(dplyr::filter(biodiversityPL, scientificName == randomSpec))

  expect_equal(colnames(res), c("Name", "Info"))
  expect_equal(res$Name, c("Scientific Name", "Vernacular Name", "Family", "Kingdom", "Registers", "Observations"))
  expect_equal(class(res$Info), "character")

})

test_that("createPopupData works and returns expected results", {

  randomSpec <- biodiversityPL$scientificName[round(runif(1, 1, nrow(biodiversityPL)))]
  res <- createPopupData(dplyr::filter(biodiversityPL, scientificName == randomSpec))

  expect_true("label" %in% colnames(res))
  testthat::expect_equal(sum(is.na(res$mediaAccessURI)), 0)

})
