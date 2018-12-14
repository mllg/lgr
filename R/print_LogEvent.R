#' Print or Format Logging Data
#'
#' @param x a [LogEvent] or [yog_data] Object
#' @param timestamp_fmt see [format.POSIXct()]
#' @param fmt A `character` scalar that may contain any of the tokens listed
#'   bellow in the section Format Tokens.
#' @param colors A `list` of `functions` that will be used to color the
#'   log levels (likely from [crayon::crayon]).
#' @param log_levels a named `integer` vector of log levels.
#' @param pad_levels `right`, `left` or `NULL`. Whether or not to pad the log
#'   level names to the same width on the left or right side, or not at all.
#' @param user The user
#' @param ... ignored
#'
#' @section Format Tokens:
#' \describe{
#'   \item{`%t`}{A timestamp (see also `timestamp_fmt`) }
#'   \item{`%l`}{the log level}
#'   \item{`%L`}{the log level (uppercase)}
#'   \item{`%n`}{the log level (numeric)}
#'   \item{`%u`}{the current user}
#'   \item{`%p`}{the PID (process ID). Useful when logging code that uses
#'       multiple threads.}
#'   \item{`%c`}{the calling function}
#'   \item{`%m`}{the log message}
#' }
#'
#' @return `x` for `print()` and a `character` scalar for `format()`
#' @export
#'
#' @examples
#' x <- LogEvent$new(level = 300, msg = "a test event", logger = yog)
#' print(x)
#' print(x, colors = NULL)
#'
#'
print.LogEvent <- function(
  x,
  fmt = "%L [%t] %m",
  timestamp_fmt = "%Y-%m-%d %H:%M:%S",
  colors = getOption("yog.colors"),
  log_levels = getOption("yog.log_levels"),
  pad_levels = "right",
  user = x$user,
  ...
){
  cat(format(
    x,
    fmt = fmt,
    timestamp_fmt = timestamp_fmt,
    colors = colors,
    log_levels = log_levels,
    pad_levels = pad_levels,
    user = user
  ), sep = "\n")
  invisible(x)
}



#' @rdname print.LogEvent
#' @export
format.LogEvent <- function(
  x,
  fmt = "%L [%t] %m",
  timestamp_fmt = "%Y-%m-%d %H:%M:%S",
  colors = NULL,
  log_levels = getOption("yog.log_levels"),
  pad_levels = "right",
  user = x$user,
  ...
){
  stopifnot(
    is_scalar_character(fmt),
    is_scalar_character(timestamp_fmt),
    is_scalar_character(pad_levels) || is.null(pad_levels)
  )


  # degenerate cases
  if (identical(nrow(x), 0L))  return("[empty log]")


  # init
  lvls <- label_levels(x$level, log_levels = log_levels)
  lvls[is.na(lvls)] <- x$level[is.na(lvls)]

  if (!is.null(pad_levels)){
    nchar_max <- max(nchar(names(log_levels)))
    diff <- nchar_max - nchar(lvls)
    pad <- vapply(diff, function(i) paste(rep.int(" ", i), collapse = ""), character(1))

    if (pad_levels == "right"){
      lvls <- paste0(lvls, pad)
    } else {
      lvls <- paste0(pad, lvls)
    }

  } else {
    lvls <- x$level
  }

  # tokenize
  tokens <- tokenize_format(
    fmt,
    valid_tokens = c("%t", "%u", "%p", "%c", "%m", "%l", "%L", "%n")
  )

  # format
  len  <- length(tokens)
  res  <- vector("list", length(tokens))
  for(i in seq_len(len)){
    res[[i]] <- switch(
      tokens[[i]],
      "%n" = colorize_levels(x$level, x$level, colors, unlabel_levels(names(colors), log_levels = log_levels  )),
      "%l" = colorize_levels(lvls, x$level, colors, unlabel_levels(names(colors), log_levels = log_levels  )),
      "%L" = colorize_levels(toupper(lvls), x$level, colors, unlabel_levels(names(colors), log_levels = log_levels )),
      "%t" = format(x$timestamp, format = timestamp_fmt),
      "%m" = x$msg,
      "%c" = x$caller %||% "(unknown function)",
      "%u" = x$user,
      "%p" = Sys.getpid(),
      tokens[[i]]
    )
  }
  res <- do.call(paste0, res)

  res
}




#' @export
format.yog_data <- format.LogEvent



#' @export
print.yog_data <- print.LogEvent


tokenize_format <- function(
  x,
  valid_tokens = NULL
){
  pos <- unlist(gregexpr("%.", x))

  if (identical(pos, -1L))
    return(x)
  pos <- sort(unique(c(1L, pos, pos + 2L, nchar(x) + 1L)))
  res <- vector("character", length(x))
  begin <- 1L
  for(i in seq_len(length(pos) -1L)) {
    res[[i]] <- substr(x, pos[[i]], pos[[i + 1]] - 1L)
  }

  if (!is.null(valid_tokens)){
    placeholders <- grep("%", res, value = TRUE)
    assert(
      all(placeholders %in% valid_tokens),
      "'format' contains unrecognised format specifications: ",
      paste(sort(setdiff(placeholders, valid_tokens)), collapse = ", ")
    )
  }

  res
}