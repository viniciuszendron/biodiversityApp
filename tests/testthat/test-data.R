test_that("biodiversity data has the correct structure", {
  testthat::expect_snapshot(colnames(biodiversityPL))
  testthat::expect_equal(sum(is.na(biodiversityPL$vernacularName)), 0)
  testthat::expect_equal(sum(is.na(biodiversityPL$scientificName)), 0)
})
