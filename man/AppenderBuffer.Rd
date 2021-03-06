% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Appender.R
\name{AppenderBuffer}
\alias{AppenderBuffer}
\title{Log to a Memory Buffer}
\description{
An Appender that Buffers LogEvents in-memory and and redirects them to other
Appenders once certain conditions are met.
}
\section{Usage}{
\preformatted{
x <- AppenderBuffer$new(threshold = NA_integer_, layout = LayoutFormat$new(fmt
  = "\%L [\%t] \%m", timestamp_fmt = "\%H:\%M:\%S", colors =
  getOption("lgr.colors")), appenders = NULL, buffer_size = 1000,
  flush_threshold = "fatal", flush_on_exit = TRUE, flush_on_rotate = TRUE,
  should_flush = default_should_flush, filters = NULL)

x$flush()
x$set_appenders(x)
x$add_appender(appender, name = NULL)
x$remove_appender(pos)
x$append(event)
x$set_buffer_size(x)
x$set_should_flush(x)
x$set_flush_on_exit(x)
x$set_flush_on_rotate(x)
x$set_flush_threshold(level)
x$show(threshold = NA_integer_, n = 20L)
x$set_threshold(level)
x$set_layout(layout)
x$filter(event)
x$add_filter(filter, name = NULL)
x$remove_filter(pos)
x$set_filters(filters)

x$appenders
x$destination
x$buffer_df
x$buffer_dt
x$buffer_events
x$buffer_size
x$flush_on_exit
x$flush_on_rotate
x$flush_threshold
x$should_flush
x$layout
x$threshold
x$filters

}
}

\section{Creating a Buffer Appender}{


The \link{Layout} for this Appender is used only to format console output of
its \code{$show()} method.
}

\section{Fields}{


\describe{
\item{\code{appenders}, \code{set_appenders()}}{Like for a \link{Logger}. Buffered events
will be passed on to these Appenders once a flush is triggered}
\item{\code{flush_on_exit, set_flush_on_exit(x)}}{\code{TRUE} or \code{FALSE}: Whether the
buffer should be flushed when the Appender is garbage collected (f.e when
you close \R)}
\item{\code{flush_on_rotate, set_flush_on_rotate}}{\code{TRUE} or \code{FALSE}: Whether
the buffer should be flushed when the Buffer is full (f.e when you close
\R). Setting this to off can have slightly negative performance impacts.}
}



\describe{
\item{\code{buffer_size, set_buffer_size(x)}}{\code{integer} scalar \code{>= 0} Number of
\link{LogEvents} to buffer.
}

\item{\code{buffer_events}, \code{buffer_df}, \code{buffer_dt}}{
The contents of the buffer as a \code{list} of \link[=LogEvent]{LogEvents}, a
\code{data.frame} or a \code{data.table}.
}

\item{\code{flush_threshold}, \code{set_flush_threshold()}}{\code{integer} or \code{character}
\link[=log_level]{log level}. Minimum event level that will trigger flushing of
the buffer. This behaviour is implemented through \code{should_flush()},
and you can modify that function for different behaviour.
}
\item{\code{should_flush(event)}, \code{set_should_flush(x)}}{
A function with exactly one arguments: \code{event}.
If the function returns \code{TRUE}, flushing of the buffer
is triggered. Defaults to flushing if an event of level \code{error}
or higher is registered.}
}



\describe{
\item{\code{dt}}{Get the log recorded by this \code{Appender} as a \code{data.table}
with a maximum of \code{buffer_size} rows}
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
\item{\code{flush()}}{Manually trigger flushing}

\item{\code{add_appender(appender, name = NULL)}, \code{remove_appender(pos)}}{
Add or remove an \link{Appender}. Supplying a \code{name} is optional but
recommended. After adding an Appender with
\code{appender$add_appender(AppenderConsole$new(), name = "console")} you can
refer to it via \code{appender$appenders$console}. \code{remove_appender()} can
remove an Appender by position or name.
}

}



\describe{
\item{\code{flush()}}{Manually trigger flushing of the buffer}
}


\describe{
\item{\code{show(n, threshold)}}{Show the last \code{n} log entries with a log level
bellow \code{threshold}. The log entries will be formatted for console output
via this Appenders \link{Layout}}
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

\section{Comparison AppenderBuffer and AppenderDt}{


Both \link{AppenderBuffer} and \link{AppenderDt} do in memory buffering of events.
AppenderBuffer retains a copies of the events it processes and has the
ability to pass the buffered events on to other Appenders. AppenderDt
converts the events to rows in a \code{data.table} and is a bit harder to
configure. Used inside loops (several hundred iterations),
AppenderDt has much less overhead than AppenderBuffer. For single logging
calls and small loops, AppenderBuffer is more performant. This is related to
how memory pre-allocation is handled by the appenders.

In short: Use AppenderDt if you want an in-memory log for interactive use,
and AppenderBuffer if you actually want to buffer events
}

\seealso{
\link{LayoutFormat}

Other Appenders: \code{\link{AppenderConsole}},
  \code{\link{AppenderDbi}}, \code{\link{AppenderFile}},
  \code{\link{AppenderGmail}}, \code{\link{AppenderJson}},
  \code{\link{AppenderPushbullet}},
  \code{\link{AppenderRjdbc}},
  \code{\link{AppenderSendmail}},
  \code{\link{AppenderTable}}, \code{\link{Appender}}
}
\concept{Appenders}
