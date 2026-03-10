test_that("matchResults and ladders summarise a simple season correctly", {
  season <- rbind(
    make_modern_match_stats(1L, 1L, "A", "B", 10L, 1L, 8L, 0L),
    make_modern_match_stats(2L, 1L, "B", "A", 10L, 0L, 10L, 0L)
  )

  match_results <- matchResults(season)
  ladder <- ladders(season)
  round_one_ladder <- ladders(season, round_num = 1L)

  expect_equal(nrow(match_results), 4)
  expect_equal(ladder$points[ladder$squadName == "A"], 6)
  expect_equal(ladder$points[ladder$squadName == "B"], 2)
  expect_equal(round_one_ladder$points[round_one_ladder$squadName == "A"], 4)
})

test_that("ladders returns infinite percentage when goals against is zero", {
  season <- make_modern_match_stats(1L, 1L, "A", "B", 10L, 0L, 0L, 0L)
  ladder <- ladders(season)

  expect_true(is.infinite(ladder$percentage[ladder$squadName == "A"]))
})

test_that("ladders_pre_2020 uses the legacy match scoring pipeline", {
  season <- make_pre_2020_match_stats(
    round = 1L,
    game = 1L,
    home_team = "A",
    away_team = "B",
    home_goals = c(12L, 8L),
    away_goals = c(10L, 7L)
  )

  ladder <- ladders_pre_2020(season)

  expect_equal(ladder$points[ladder$squadName == "A"], 2)
  expect_equal(ladder$points_new[ladder$squadName == "A"], 6)
})
