#' march_info_all
#'
#' Gather protest information on all March for Our Lives protests worldwide.
#'
#' @param focal_zip this is a focal location information which all locations 20k
#'   miles around are tracked by. Current default is somewhere in Kansas.
#'
#' @return
#' @export
#'
#' @examples
#'
#' all_planned_protests <- march_info_all()
#' all_planned_protests
#'
march_info_all <- function(focal_zip=66101){
  url <- stringr::str_glue("https://event.marchforourlives.com/event/march-our-lives-events/search/?page=march-our-lives-events_attend&template=event_search.html&akid=&distance=20000&limit=5000&event_search_on_load=1&place={focal_zip}")
  raw <- xml2::read_html(url) # Download Website

  # Collate elements as data.frame
  tibble::tibble(

    query_date = Sys.Date(),

    event_titles =
      raw %>%
      rvest::html_nodes(css="p.ak-event-title > a") %>%
      rvest::html_text(),

    event_address =
      raw %>%
      rvest::html_nodes(css="div.ak-event-address1") %>%
      rvest::html_text(),

    event_location =
      raw %>%
      rvest::html_nodes(css="div.ak-event-city-etc") %>%
      rvest::html_text(),

    event_time =
      raw %>%
      rvest::html_table() %>%
      sapply(.,function(x) x[2]) %>%
      {names(.) = NULL;.} %>%
      unlist(.),

    event_description =
      raw %>%
      rvest::html_nodes(css="p.ak-event-description") %>%
      rvest::html_text()
  )
}

