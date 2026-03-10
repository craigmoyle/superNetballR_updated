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
#'
#' @examples
#' \dontrun{
#' downloadMatch("10083", 1, 1)
#' }
#'
#' @export
downloadMatch <- function(comp_id, round_id, game_id) {
    r_id <- ifelse(
        round_id < 10,
        paste0("0", as.character(round_id)),
        as.character(round_id)
    )
    pg <- paste0(
        "https://mc.championdata.com/data/",
        comp_id,
        "/",
        comp_id,
        r_id,
        paste0("0", as.character(game_id)),
        ".json"
    )
    dat <- httr::GET(pg)
    httr::stop_for_status(dat, call. = FALSE)
    dat_list <- httr::content(
        dat,
        as = "parsed",
        type = "application/json"
    )$matchStats
    if (is.null(dat_list)) {
        stop("Champion Data response did not include matchStats.", call. = FALSE)
    }
    dat_list
}
