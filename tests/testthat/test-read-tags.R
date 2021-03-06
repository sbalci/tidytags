context("Read TAGS tweet tracker")
library(tidytags)

test_that("a TAGS tweet tracker is imported properly from Google Sheets", {
  example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
  x <- read_tags(example_url)

  expect_true(is.data.frame(x))
  expect_named(x)
  expect_true("id_str" %in% names(x))
  expect_true("from_user" %in% names(x))
  expect_true("status_url" %in% names(x))
  expect_gt(ncol(x), 15)
})
