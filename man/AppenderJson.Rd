% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Appender.R
\name{AppenderJson}
\alias{AppenderJson}
\title{Log to a JSON File}
\description{
\code{AppenderJson} is a shortcut for \code{AppenderFile} with \code{\link{LayoutJson}}, but
comes with an extra method \code{show()} and an extra active field \code{data} to
comfortably access the underlying file.
}
\section{Usage}{
\preformatted{
x <- AppenderFile$new(file, threshold = NA_integer_, layout =
  LayoutFormat$new(), filters = NULL)

x$append(event)
x$set_file(file)
x$set_threshold(level)
x$set_layout(layout)
x$filter(event)
x$add_filter(filter, name = NULL)
x$remove_filter(pos)
x$set_filters(filters)

x$destination
x$file
x$layout
x$threshold
x$filters

}
}

\section{Creating a New Appender}{




New Appenders are instantiated with \code{<AppenderSubclass>$new()}. For the
arguments to \code{new()} please refer to the section \emph{Fields}. You can also
modify those fields after the Appender has been created with setters in the
form of \code{appender$set_<fieldname>(value)}
}

\section{Fields}{




\describe{
\item{\code{file}, \code{set_file(file)}}{\code{character} scalar. Path to the desired log
file. If the file does not exist it will be created}
}



\describe{
\item{\code{threshold}, \code{set_threshold(level)}}{\code{character} or \code{integer} scalar.
The minimum log level that triggers this logger. See \link{log_levels}}
\item{\code{layout}, \code{set_layout(layout)}}{a \code{Layout} that will be used for
formatting the \code{LogEvents} passed to this Appender}
\item{\code{destination}}{The output destination of the \code{Appender} in
human-readable form (mainly for print output)}
}



\describe{
\item{\code{filters}, \code{set_filters(filters)}}{a \code{list} that may contain
\code{functions} or any \R object with a \code{filter()} method. These functions
must have exactly one argument: \code{event} which will get passed the
LogEvent when the Filterable's \code{filter()} method is invoked.
If all of these functions evaluate to \code{TRUE} the LogEvent is passed on.
Since LogEvents have reference semantics, filters can also be abused to
modify them before they are passed on. Look at the source code of
\code{\link[=with_log_level]{with_log_level()}} or \code{\link[=with_log_value]{with_log_value()}} for examples.
}
}



\describe{
\item{\code{data}}{Get the log recorded by this \code{Appender} as a \code{data.frame}}
}



\describe{
\item{\code{threshold}, \code{set_threshold(level)}}{\code{character} or \code{integer} scalar.
The minimum log level that triggers this logger. See \link{log_levels}}
\item{\code{layout}, \code{set_layout(layout)}}{a \code{Layout} that will be used for
formatting the \code{LogEvents} passed to this Appender}
\item{\code{destination}}{The output destination of the \code{Appender} in
human-readable form (mainly for print output)}
}



\describe{
\item{\code{filters}, \code{set_filters(filters)}}{a \code{list} that may contain
\code{functions} or any \R object with a \code{filter()} method. These functions
must have exactly one argument: \code{event} which will get passed the
LogEvent when the Filterable's \code{filter()} method is invoked.
If all of these functions evaluate to \code{TRUE} the LogEvent is passed on.
Since LogEvents have reference semantics, filters can also be abused to
modify them before they are passed on. Look at the source code of
\code{\link[=with_log_level]{with_log_level()}} or \code{\link[=with_log_value]{with_log_value()}} for examples.
}
}
}

\section{Methods}{


\describe{
\item{\code{show(n, threshold)}}{Show the last \code{n} log entries with a log level
bellow \code{threshold}. The log entries will be formatted as in the source
JSON file}
}


\describe{
\item{\code{append(event)}}{Tell the Appender to process a \link{LogEvent} \code{event}.
This method is usually not called by the user, but invoked by a
\link{Logger}
}
}


\describe{
\item{\code{filter(event)}}{Determine whether the LogEvent \code{x} should be passed
on to Appenders (\code{TRUE}) or not (\code{FALSE}). See also the active binding
\code{filters}}
\item{\code{add_filter(filter, name = NULL)}, \code{remove_filter(pos)}}{
Add or remove a filter. When adding a filter an optional \code{name} can
be specified. \code{remove_filter()} can remove by position or name (if one
was specified)
}
}
}

\examples{
tf <- tempfile()
l <- Logger$new("testlogger", appenders = AppenderJson$new(tf), propagate = FALSE)

l$info("A test message")
l$info("A test message \%s strings", "with format strings", and = "custom_fields")

l$appenders[[1]]$show()
l$appenders[[1]]$data

# cleanup
unlink(tf)
}
\seealso{
\link{LayoutFormat}, \link{LayoutJson}

Other Appenders: \code{\link{AppenderBuffer}},
  \code{\link{AppenderConsole}}, \code{\link{AppenderDbi}},
  \code{\link{AppenderFile}}, \code{\link{AppenderGmail}},
  \code{\link{AppenderPushbullet}},
  \code{\link{AppenderRjdbc}},
  \code{\link{AppenderSendmail}},
  \code{\link{AppenderTable}}, \code{\link{Appender}}
}
\concept{Appenders}
