validate_identifier <- function(value, name) {
    if (length(value) != 1 || is.na(value)) {
        stop(name, " must be a single value.", call. = FALSE)
    }

    value <- as.character(value)
    if (!grepl("^[0-9]+$", value)) {
        stop(name, " must contain digits only.", call. = FALSE)
    }

    value
}

validate_positive_whole_number <- function(value, name) {
    value <- validate_identifier(value, name)
    value <- as.integer(value)

    if (value < 1) {
        stop(name, " must be greater than or equal to 1.", call. = FALSE)
    }

    value
}

build_match_url <- function(comp_id, round_id, game_id) {
    comp_id <- validate_identifier(comp_id, "comp_id")
    round_id <- validate_positive_whole_number(round_id, "round_id")
    game_id <- validate_positive_whole_number(game_id, "game_id")

    sprintf(
        "https://mc.championdata.com/data/%s/%s%02d%02d.json",
        comp_id,
        comp_id,
        round_id,
        game_id
    )
}

extract_match_stats <- function(payload) {
    dat_list <- payload$matchStats
    if (is.null(dat_list)) {
        stop("Champion Data response did not include matchStats.", call. = FALSE)
    }

    dat_list
}

#' Download data from a single match
#'
#' \code{downloadMatch} downloads match and player data for a single match.
#'
#' @param comp_id A string identifying which season the game is
#'     in. \code{comp_id} is different depending on regular season or finals.
#' @param round_id An integer identifying which round the game is in. Finals
#'     reset round number to 1.
#' @param game_id An integer indentifying which game in the round to
#'     download. There are four games per round in the regular season, two games
#'     in the semi finals, one game for the prelim, and one grand final.
#' @return A list containing game and player data for the match.
#' @details
#' \code{downloadMatch()} validates the supplied identifiers, retries transient
#' HTTP failures, and raises an explicit error if the Champion Data response no
#' longer includes a \code{matchStats} object.
#'
#' @examples
#' \dontrun{
#' downloadMatch("10083", 1, 1)
#' }
#'
#' @export
downloadMatch <- function(comp_id, round_id, game_id) {
    pg <- build_match_url(comp_id, round_id, game_id)
    dat <- httr::RETRY(
        "GET",
        pg,
        httr::timeout(30),
        times = 3,
        pause_base = 1,
        terminate_on = c(400, 401, 403, 404),
        quiet = TRUE
    )
    httr::stop_for_status(dat)
    extract_match_stats(httr::content(
        dat,
        as = "parsed",
        type = "application/json"
    ))
}
