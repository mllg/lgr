% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simple_logging.R
\name{simple_logging}
\alias{simple_logging}
\alias{FATAL}
\alias{ERROR}
\alias{WARN}
\alias{INFO}
\alias{DEBUG}
\alias{TRACE}
\alias{log_exception}
\alias{threshold}
\alias{console_threshold}
\alias{add_appender}
\alias{remove_appender}
\alias{show_log}
\alias{show_dt}
\alias{show_data}
\title{Simple Logging}
\usage{
FATAL(msg, ...)

ERROR(msg, ...)

WARN(msg, ...)

INFO(msg, ...)

DEBUG(msg, ...)

TRACE(msg, ...)

log_exception(code, logfun = lgr$fatal, caller = get_caller(-3))

threshold(level, target = lgr::lgr)

console_threshold(level, target = lgr::lgr$appenders$console)

add_appender(appender, name = NULL, target = lgr::lgr)

remove_appender(pos, target = lgr::lgr)

show_log(threshold = NA_integer_, n = 20L, target = lgr::lgr)

show_dt(target = lgr::lgr)

show_data(target = lgr::lgr)
}
\arguments{
\item{msg, ...}{passed on to \code{\link[base:sprintf]{base::sprintf()}}}

\item{code}{Any \R code}

\item{logfun}{a \code{function} for processing the log request, usually
\code{lgr$info()}, \code{lgr$debug()}, etc... .}

\item{caller}{a \code{character} scalar. The name of the calling function}

\item{level, threshold}{an \code{integer} or \code{character} scalar, see
\code{getOption("lgr.log_levels")} for possible values. For \code{threshold} \code{0}
(\code{"off"}) and \code{NA} (\code{"all"}) are also valid.}

\item{target}{a \link{Logger} or \link{Appender}. Defaults to the root logger.}

\item{appender}{an \code{Appender}}

\item{name}{\code{character} scalar. An optional name for the new Appender.}

\item{pos}{\code{integer} index or \code{character} names of the appenders to remove}

\item{n}{\code{integer} scalar. Show only the last \code{n} log entries that match
\code{threshold}}
}
\value{
\code{FATAL()} ... \code{TRACE()} and \code{log_exception()} return the log message
as a \code{character} vector.

\code{threshold()} and \code{console_threshold()} return the \link{log_level} of \code{target}
as \code{integer} (invisibly)

\code{add_appender()} and \code{remove_appender()} return \code{target}.

\code{show_log()} prints to the console and returns whatever the target
Appender's \code{$show()} method returns, usually a \code{data.frame} or \code{data.table}
(invisibly).

\code{show_data()} always returns a \code{data.frame} and \code{show_dt()} always returns
a \code{data.table}.
}
\description{
These functions provide a simple interface to the root logger. If you do not
need any of the more advanced features of lgr, start here.

lgr provides convenience functions to manage the root Logger. These
are intended for interactive use, and for people who just need basic
logging facilities and don't want to worry about hierarchical loggers and
R6 classes.

\code{threshold()} sets or retrieves the threshold for an \link{Appender} or \link{Logger}
(the minimum level of log messages it processes). It's \code{target} defaults
to the root logger.

\code{console_threshold()} is a shortcut to set the threshold of the root
loggers \link{AppenderConsole}, which is usually the only Appender that manages
console output for a given \R session.

\code{add_appender()} and \code{remove_appender()} add Appenders to Loggers and
other Appenders.

\code{show_log()} displays the last \code{n} log entries of \code{target} if \code{target} is
an Appender with a \code{show()} method or a Logger with at least one such
Appender attached. \code{target} defaults to the root logger, which has an
\link{AppenderDt} attached by default if the package \strong{data.table} is installed.
With the default logging settings this includes also \code{TRACE} and \code{DEBUG}
messages, even if they were not printed to the console before.

\code{show_data()} and \code{show_dt()} work similar to \code{show_log()}, except that
they return the log as \code{data.frame} or \code{data.table} respectively.
}
\examples{
FATAL("This is an important message about \%s going wrong", "something")
DEBUG("Debug messages are hidden by default")
console_threshold("debug")  # you must use lower case names here
DEBUG("Unless we lower the threshold")

add_appender(AppenderConsole$new(), "second_console_appender")
FATAL("Multiple console appenders are a bad idea")
remove_appender("second_console_appender")
INFO("Good that we defined an appender name, so it's easy to remove")
}
