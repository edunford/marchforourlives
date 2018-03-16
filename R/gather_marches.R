#' gather_marches
#'
#' Gather protest information on multiple event occurrences, varying capture
#' rates to reduce site impact.
#'
#' @param postal_codes numerical vector of postal codes.
#' @param timepad maximum extent of the random uniform draw designed to pause
#'   between discreet grabs. Feature must be >= 5
#'
#' @return tbl_df data.frame object of event location information
#' @export
#'
#' @example
#'
#' # Postal codes (this vector can be as long as need be)
#' pcodes = c(20010, # Col. Heights in DC
#'            83333, # Hailey, ID
#'            98101, # Seatle, WA
#'            77001  # Houston, TX
#'            )
#'
#' dat =  gather_marches(83333)
#'
gather_marches = function(postal_codes = c(20010,83333),timepad=5){
  if(timepad<5){stop("Timepad maximum less than 5 seconds. Must be >= 5. Precaution to reduce ping rate.")}
  cat("\n Initializing scraper\n")
  out = c()
  iters = length(postal_codes)
  pb = dplyr::progress_estimated(iters)
  for(p in postal_codes){
    Sys.sleep(runif(1,1,timepad))
    out = dplyr::bind_rows(out,extract_march(p))
    pb$tick()$print() # Track progress
  }
  return(out)
}
