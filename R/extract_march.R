#' extract_march
#'
#' Function scrapes content from
#' https://event.marchforourlives.com/event/march-our-lives-events/search/ and
#' provides event location data for all events within fifty miles of an
#' organized event. All event data is as provided by protest organizers.
#'
#' @param postal_code supply a single zip code location (as numeric value)
#'
#'
#' @return tbl_df data.frame object of event locations
#' @export
#'
#' @example
#'
#' extract_march(20010)
#'
extract_march <- function(postal_code="20010"){
  url <- stringr::str_glue("https://event.marchforourlives.com/event/march-our-lives-events/search/?page=march-our-lives-events_attend&template=event_search.html&akid=&distance=50&limit=10&event_search_on_load=1&place={postal_code}")
  raw <- xml2::read_html(url) # Download Website

  # Check that there is any event within 50km (stop if zero)
  ecount <-
    raw %>%
    rvest::html_nodes(css="p.ak-event-title > a") %>%
    rvest::html_text() %>% length


  if(ecount>0){ # If there is information for an event

    # Collate elements as data.frame
    tibble::tibble(

      query_zipcode = postal_code,

      query_date = Sys.Date(),

      event_titles =
        raw %>%
        rvest::html_nodes(css="p.ak-event-title > a") %>%
        rvest::html_text(),

      event_address =
        raw %>%
        rvest::html_nodes(css="div.ak-event-address1") %>%
        rvest::html_text(),

      event_city =
        raw %>%
        rvest::html_nodes(css="div.ak-event-city-etc") %>%
        rvest::html_text() %>%
        stringr::str_replace(.,"\\d+","") %>%
        stringr::str_split(.,", ") %>%
        .[[1]] %>% .[2] %>%
        stringr::str_trim(.),

      event_state =
        raw %>%
        rvest::html_nodes(css="div.ak-event-city-etc") %>%
        rvest::html_text() %>%
        stringr::str_replace(.,"\\d+","") %>%
        stringr::str_split(.,", ") %>%
        .[[1]] %>% .[1] %>%
        stringr::str_trim(.),

      event_zipcode =
        raw %>%
        rvest::html_nodes(css="div.ak-event-city-etc") %>%
        rvest::html_text() %>%
        stringr::str_extract(.,"\\d+") %>%
        as.numeric(.),

      event_time =
        raw %>%
        rvest::html_table() %>%
        sapply(.,function(x) x[2]) %>%
        {names(.) = NULL;.} %>%
        unlist(.),

      event_description =
        raw %>%
        rvest::html_nodes(css="p.ak-event-description") %>%
        rvest::html_text(),

      event_est_distance =
        raw %>%
        rvest::html_nodes("p:nth-child(5) > span") %>%
        rvest::html_text()
    )
  } else{ # yield dude
    tibble::tibble(
      query_zipcode = postal_code,
      query_date = Sys.Date(),
      event_titles = NA,
      event_address = NA,
      event_city = NA,
      event_state = NA,
      event_zipcode = NA,
      event_time = NA,
      event_description = "No events reported within 50 miles of the query zipcode",
      event_est_distance = NA
    )
  }

}
