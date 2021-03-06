% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lgr-package.R
\docType{package}
\name{lgr-package}
\alias{lgr}
\alias{lgr-package}
\title{A Fully Featured Logging Framework for R}
\description{
For details please refer to \code{vignette("lgr", package = "lgr")}.
}
\section{Options}{


You can also set these options in your \code{.Rprofile} to make them permanent

\describe{
\item{\code{lgr.colors}}{a \code{list} of \code{functions} used for coloring the log
levels in console output. Usually these will be functions from the
package \strong{crayon}}
\item{\code{lgr.log_levels}}{A named \code{integer} vector of log levels that are
known to lgr for labeling, setting thresholds, etc... . Instead of
modifying this option manually use \code{\link[=add_log_levels]{add_log_levels()}} and
\code{\link[=remove_log_levels]{remove_log_levels()}}}
\item{\code{lgr.suspend_logging}}{\code{TRUE} or \code{FALSE}. Suspend all logging for
all loggers. Defaults to the \code{TRUE} if the environment variable
\code{LGR_SUSPEND_LOGGING} is set to \code{"TRUE"}. Instead of modifying this
option manually use \code{\link[=suspend_logging]{suspend_logging()}} and \code{\link[=unsuspend_logging]{unsuspend_logging()}}}
\item{\code{lgr.user}}{a \code{character} scalar. The default username for
\code{lgr::get_user()}.
}
}
}

\seealso{
Useful links:
\itemize{
  \item \url{https://github.com/s-fleck/lgr}
  \item Report bugs at \url{https://github.com/s-fleck/lgr/issues}
}

}
\author{
\strong{Maintainer}: Stefan Fleck \email{stefan.b.fleck@gmail.com} (0000-0003-3344-9851)

}
\keyword{internal}
