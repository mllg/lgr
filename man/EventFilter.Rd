% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Filter.R
\name{EventFilter}
\alias{EventFilter}
\alias{Filter}
\alias{FilterInject}
\alias{FilterForceLevel}
\title{Event Filters}
\description{
Filters can be used for the \code{$set_filter()} and \code{$add_filter()} methods of
Appenders and Loggers. You normally do not need to construct a formal
\code{EventFilter} object, you can just use any \code{function} that has the single
argument \code{event} or any object that has a \code{filter} method.
}
\note{
The base class for Filters is called \code{EventFilter} so that it doesn't
conflict with \code{\link[base:Filter]{base::Filter()}}. The recommended convention for Filter
subclasses is to call them \code{FilterSomething} and leave out the
\code{Event} prefix.
}
\section{Modifying LogEvents with Filters}{


Since LogEvents are R6 objects with reference semantics, Filters can also
be abused to modify log events before passing them on. lgr comes with a few
preset filters that use this property:

\describe{

\item{\code{FilterInject$new(..., .list)}}{\code{...} and \code{.list} can take any number
of named R6 objects that will be injected as custom fields into all
LogEvents processed by the  Appender/Logger that this filter is attached
to. See also \code{\link[=with_log_value]{with_log_value()}}}

\item{\code{FilterForceLevel$new(level)}}{Sets the level of all LogEvents
processed by the Appender/Logger that this filter is attached to to
\code{level}. See also \code{\link[=with_log_value]{with_log_value()}}}
}
}

\section{Accessing Appenders and Loggers from Filters}{


You can use the special function \code{.obj()} to access the calling
Logger/Appender from within a filter
}

\examples{
# using filters to modify log events
analyse <- function(){
  lgr$add_filter(FilterForceLevel$new("info"), "force")
  lgr$add_filter(FilterInject$new(type = "analysis"), "inject")
  on.exit(lgr$remove_filter(c("force", "inject")))
  lgr$debug("a debug message")
  lgr$error("an error")
}
analyse()
lgr$error("an error")


# using .obj()
l <- Logger$new("foo", threshold = "debug")
f <- function(event) {
  cat("via event$.logger:", event$.logger$threshold, "\\n")  #  works for loggers only
  cat("via .obj():      ",.obj()$threshold, "\\n") # works for loggers and appenders
  TRUE
}
l$add_filter(f)
l$fatal("test")
}
