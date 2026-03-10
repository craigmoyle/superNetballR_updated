make_sample_match <- function(period_completed = 2) {
  list(
    matchInfo = list(
      homeSquadId = 10L,
      awaySquadId = 20L,
      periodCompleted = period_completed,
      roundNumber = 5L,
      matchNumber = 3L
    ),
    teamInfo = list(
      team = list(
        list(
          squadId = 10L,
          squadName = "Home",
          squadNickname = "Homes",
          squadCode = "HOM"
        ),
        list(
          squadId = 20L,
          squadName = "Away",
          squadNickname = "Aways",
          squadCode = "AWY"
        )
      )
    ),
    teamPeriodStats = list(
      team = list(
        list(squadId = 10L, period = 1L, gains = 2L, goalAttempts = 10L),
        list(squadId = 10L, period = 2L, gains = 3L, goalAttempts = 11L),
        list(squadId = 10L, period = 3L, gains = 4L, goalAttempts = 12L),
        list(squadId = 20L, period = 1L, gains = 1L, goalAttempts = 8L),
        list(squadId = 20L, period = 2L, gains = 2L, goalAttempts = 9L),
        list(squadId = 20L, period = 3L, gains = 3L, goalAttempts = 10L)
      )
    ),
    playerInfo = list(
      player = list(
        list(
          playerId = 1L,
          squadId = 10L,
          displayName = "Home Shooter",
          shortDisplayName = "Shooter, Home",
          firstname = "Home",
          surname = "Shooter"
        ),
        list(
          playerId = 2L,
          squadId = 20L,
          displayName = "Away Shooter",
          shortDisplayName = "Shooter, Away",
          firstname = "Away",
          surname = "Shooter"
        )
      )
    ),
    playerPeriodStats = list(
      player = list(
        list(playerId = 1L, squadId = 10L, period = 1L, goals = 5L, feeds = 2L),
        list(playerId = 1L, squadId = 10L, period = 2L, goals = 6L, feeds = 3L),
        list(playerId = 1L, squadId = 10L, period = 3L, goals = 7L, feeds = 4L),
        list(playerId = 2L, squadId = 20L, period = 1L, goals = 4L, feeds = 1L),
        list(playerId = 2L, squadId = 20L, period = 2L, goals = 3L, feeds = 2L),
        list(playerId = 2L, squadId = 20L, period = 3L, goals = 2L, feeds = 3L)
      )
    )
  )
}

make_modern_match_stats <- function(
  round,
  game,
  home_team,
  away_team,
  home_zone1,
  home_zone2 = 0,
  away_zone1,
  away_zone2 = 0
) {
  rows <- list(
    data.frame(
      squadName = c(home_team, away_team),
      stat = c("goal_from_zone1", "goal_from_zone1"),
      value = c(home_zone1, away_zone1),
      period = c(1L, 1L),
      round = c(round, round),
      game = c(game, game),
      stringsAsFactors = FALSE
    ),
    data.frame(
      squadName = c(home_team, away_team),
      stat = c("homeTeam", "homeTeam"),
      value = c(1L, 0L),
      period = c(1L, 1L),
      round = c(round, round),
      game = c(game, game),
      stringsAsFactors = FALSE
    )
  )

  if (!is.null(home_zone2)) {
    rows[[length(rows) + 1L]] <- data.frame(
      squadName = home_team,
      stat = "goal_from_zone2",
      value = home_zone2,
      period = 1L,
      round = round,
      game = game,
      stringsAsFactors = FALSE
    )
  }

  if (!is.null(away_zone2)) {
    rows[[length(rows) + 1L]] <- data.frame(
      squadName = away_team,
      stat = "goal_from_zone2",
      value = away_zone2,
      period = 1L,
      round = round,
      game = game,
      stringsAsFactors = FALSE
    )
  }

  do.call(rbind, rows)
}

make_pre_2020_match_stats <- function(
  round,
  game,
  home_team,
  away_team,
  home_goals,
  away_goals
) {
  stopifnot(length(home_goals) == length(away_goals))

  periods <- seq_along(home_goals)
  do.call(
    rbind,
    list(
      data.frame(
        squadName = c(rep(home_team, length(periods)), rep(away_team, length(periods))),
        stat = "goals",
        value = c(home_goals, away_goals),
        period = c(periods, periods),
        round = round,
        game = game,
        stringsAsFactors = FALSE
      ),
      data.frame(
        squadName = c(rep(home_team, length(periods)), rep(away_team, length(periods))),
        stat = "homeTeam",
        value = c(rep(1L, length(periods)), rep(0L, length(periods))),
        period = c(periods, periods),
        round = round,
        game = game,
        stringsAsFactors = FALSE
      )
    )
  )
}
