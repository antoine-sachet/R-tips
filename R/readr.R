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
read_delim(filepath, delim=",", col_names = T)

# A generic delimited file ------------------------------------------------

filepath <- readr_example("massey-rating.txt")
readLines(filepath, n = 3)
read_table(filepath)


# A challenging file ------------------------------------------------------

filepath <- readr_example("challenge.csv")
readLines(filepath, n = 3)

df <- read_csv(filepath)

View(problems(df))

spec <- cols(
  x = col_double(),
  y = col_date(format="%Y-%m-%d")
)
# Date formats described in details at ?strptime

df <- read_csv(filepath, col_types = spec)
hist(df$y, breaks = "months")

