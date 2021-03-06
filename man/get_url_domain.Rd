% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analyze-url.R
\name{get_url_domain}
\alias{get_url_domain}
\title{Find the domain name of URLs, even shortened URLs}
\usage{
get_url_domain(x, wait = 10)
}
\arguments{
\item{x}{A list or vector of hyperlinks, whether shortened or expanded}

\item{wait}{How long (in seconds) to wait on the \code{longurl::expand_urls()}
function to retrieve the full, expanded URL from a shortened URL (e.g., a bit.ly).
The \code{longurl} default is 2 seconds, but we have found that this misses
a number of valid URLs. Here, we have made the default \code{wait = 10} seconds,
but the user can adjust this as they like.}
}
\value{
A list or vector of Web domain names
}
\description{
\code{get_url_domain()} retrieves geographic coordinates (i.e., latitude and
  longitude) based on the locations listed in Twitter user profiles
}
\examples{

\dontrun{

get_url_domain("https://www.tidyverse.org/packages/")
get_url_domain("https://dplyr.tidyverse.org/")
get_url_domain("http://bit.ly/2SfWO3K")
}
}
\seealso{
Read the documentation for \code{longurl::expand_urls()} and
  \code{urltools::domain()}.
}
