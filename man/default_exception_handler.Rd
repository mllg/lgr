% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/default_functions.R
\name{default_exception_handler}
\alias{default_exception_handler}
\title{Demote an Exception to a Warning}
\usage{
default_exception_handler(e)
}
\arguments{
\item{e}{a \code{character} scalar, usually a \code{try-error} as thrown by
\code{\link[base:tryCatch]{base::tryCatch()}}}
}
\value{
The warning as \code{character} vector
}
\description{
Throws a timestamped warning instead of stopping the program. This is
the default exception handler used by \link{Loggers}.
}
\examples{
tryCatch(stop("an error has occurred"), error = default_exception_handler)

}
