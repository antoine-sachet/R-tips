#' How to ingest flat files using readr
#' @author Antoine
#' @date 2018-12-14

# Readr functions are faster, more robust, more consistent
# Fail fast is something is wrong
# Raises helfpul error messages to highlight parsing errors

# Base R's readers are:
read.csv
read.table
read.delim

# Readr's versions are:
library("readr")
read_csv
read_table
read_delim

# Read_delim is the most generic: it can read any delimited file.

# readr provides some files to play with
readr_example()


# A basic CSV -------------------------------------------------------------

filepath <- readr_example("mtcars.csv")
readLines(filepath, n = 3)
read_csv(filepath)
mt <- read_delim(filepath, delim=",", col_names = T)

specs <- list()

specs$mtcars <- cols(
  mpg = col_double(),
  cyl = col_double(),
  disp = col_double(),
  hp = col_double(),
  drat = col_double(),
  wt = col_double(),
  qsec = col_double(),
  vs = col_integer(),
  am = col_integer(),
  gear = col_integer(),
  carb = col_double()
)

mt <- read_delim(filepath, delim=",", col_names = T, col_types = specs$mtcars)
mt

problems(mt)

# A generic delimited file ------------------------------------------------

filepath <- readr_example("massey-rating.txt")
readLines(filepath, n = 3)
massey_rating <- read_table(filepath)

# A challenging file ------------------------------------------------------

filepath <- readr_example("challenge.csv")
readLines(filepath, n = 3)

df <- read_csv(filepath)

View(problems(df))

specs$challenge <- cols(
  x = col_double(),
  y = col_date(format="%Y-%m-%d")
)

# specs$challenge_guess <- cols(
#   x = col_double(),
#   y = col_guess()
# )

# Date formats described in details at ?strptime

df <- read_csv(filepath, col_types = specs$challenge)
hist(df$y, breaks = "months")

