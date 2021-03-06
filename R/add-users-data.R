#' Retrieve user information for everyone in an edgelist
#'
#' \code{add_users_data()} updates an edgelist created with \code{create_edgelist()}
#'   by appending user data retrieved with \code{rtweet::lookup_users()}. The resulting
#'   dataframe keeps all the columns from \code{rtweet} but adds "_sender" or
#'   "_receiver" to the column names
#' @param edgelist An edgelist of senders and receivers, such as that returned by
#'   the function \code{create_edgelist()}.
#' @return A dataframe in the form of an edgelist (i.e., with senders and receivers)
#'   as well as numerous, appropriately named columns of details about the senders
#'   and receivers.
#' @seealso Review documentation for \code{rtweet::lookup_users()} for a full list
#'   of metadata retrieved (i.e., column names) by this function.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' add_users_data(create_edgelist(tmp_df))
#' }
#' @importFrom rlang .data
#' @export
add_users_data <-
  function(edgelist) {
    all_users <- unique(c(edgelist$sender, edgelist$receiver))
    users_data_from_rtweet <- rtweet::lookup_users(all_users)
    users_prepped <-
      dplyr::mutate(users_data_from_rtweet,
        screen_name = tolower(.data$screen_name)
      )
    users_prepped <-
      dplyr::select(
        users_prepped,
        .data$screen_name,
        tidyselect::everything()
      )
    users_prepped <-
      dplyr::distinct(users_prepped,
        .data$screen_name,
        .keep_all = TRUE
      )
    senders_prepped <-
      dplyr::mutate(edgelist,
        screen_name = tolower(.data$sender)
      )

    ## edit all sender variable names to have "_sender" in them
    names(users_prepped)[2:length(users_prepped)] <-
      stringr::str_c(names(users_prepped), "_sender")[2:length(users_prepped)]
    edgelist_with_senders_data <- dplyr::left_join(senders_prepped,
      users_prepped,
      by = "screen_name"
    )

    ## change the name of screen_name back to sender
    receivers_prepped <-
      dplyr::mutate(edgelist_with_senders_data,
        sender = .data$screen_name,
        screen_name = tolower(.data$receiver)
      )

    ## would be nice to not have to do this again! (it is because of the names issue - an easy fix)
    users_prepped <-
      dplyr::mutate(users_data_from_rtweet,
        screen_name = tolower(.data$screen_name)
      )
    users_prepped <-
      dplyr::select(
        users_prepped,
        .data$screen_name,
        tidyselect::everything()
      )
    users_prepped <-
      dplyr::distinct(users_prepped,
        .data$screen_name,
        .keep_all = TRUE
      )

    ## edit all sender variable names to have "_receiver" in them
    names(users_prepped)[2:length(users_prepped)] <-
      stringr::str_c(names(users_prepped), "_receiver")[2:length(users_prepped)]

    edgelist_with_all_users_data <-
      dplyr::left_join(receivers_prepped,
        users_prepped,
        by = "screen_name"
      )
    edgelist_with_all_users_data <-
      dplyr::select(
        edgelist_with_all_users_data,
        -.data$screen_name
      )
    edgelist_with_all_users_data
  }
