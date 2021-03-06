% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gather_marches.R
\name{gather_marches}
\alias{gather_marches}
\title{gather_marches}
\usage{
gather_marches(postal_codes = c(20010, 83333), timepad = 5)
}
\arguments{
\item{postal_codes}{numerical vector of postal codes.}

\item{timepad}{maximum extent of the random uniform draw designed to pause
between discreet grabs. Feature must be >= 5}
}
\value{
tbl_df data.frame object of event location information
}
\description{
Gather protest information on multiple event occurrences, varying capture
rates to reduce site impact.
}
