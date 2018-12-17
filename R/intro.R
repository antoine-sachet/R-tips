#' Gentle introduction to R covering:
#' - data types
#' - basic syntax
#' - various tips along the way
#' 
#'  (It is good practice to describe the purpose of a file at the top)
#'  
#'  @author Antoine
#'  @date 2018-12-13

# Useful shortcuts --------------------------------------------------------

#' No need for the mouse 99% of the time!

#' ctrl+shift+R will create a new section, useful to structure your code
#' -> use "show outline" (top right of editor) button to show the sections

#' ctrl+enter evaluates the current line (or selected text if any) in the console
#' ctrl+2 jumps to the console
#' ctrl+1 jumps (back) to the main editor
#' ctrl+tab moves editor tab, ctrl+shift+tab goes back

#' Use `home` and `end` to quickly move in a line
#' Of course you know that arrows move the cursor, but did you know:
#' ctrl + left/right arrow moves the cursor by a word instead of a character
#' shift + arrows moves the cursor *while selecting*
#' ctrl + shift + arrows moves the cursor by a word while selecting, 
#' -> use to select part of a line for evaluation (with ctrl+enter)

# ctrl + alt + arrow moves a line up and down

#' ctrl+i re-indents the file (or the selected text if any) 
#' -> I find myself doing ctrl+a ctrl+i ctrl+s all the time

# Brief history of R ------------------------------------------------------

history <- "Relatively recent (late 90s), improved a LOT in the last 5 years
because of the AI / ML hype...  tons of new packages making life easier!
Nevertheless it started as an interactive language for statisticians... 
and still suffers of it. Bad design decisions to be 'nice' to the user
makes your code hard to debug! It is often better to 'fail fast' and R 
is too nice."

# Data types --------------------------------------------------------------

# Basic data types
a <- 1
class(a)

# strings are called character
a <- "hello"
class(a)

a <- 1L
class(a)

# booleans are called logical
comp <- a > 2
comp
class(comp)
class(TRUE)
# can be shortened to T and F
TRUE == T

# also factors... more about them later
a <- factor("hello")
class(a)

# In R, everything is an object you can put in a variable!
# even functions
f <- print
class(f)


# Convert between data types ----------------------------------------------

# Use as.type:
12
as.character(12)
as.numeric("123")
as.integer("123")

d <- as.Date("2018-12-11")

# Everything is a vector ------------------------------------------------

# A single value is a vector of length 1
# (which is why there is [1] in the console)
v <- 1
length(v)

# Create vectors by concatenating value with `c`
v <- c(1, 5, 10)
# v is still of class numeric
class(v)

# Access values of a vector with `[`
# Indexing starts at 1 (not 0)
v[1]
v[2]

# Out of bound indexing returns NA (instead of failing)
v[5]

# change values like this
v[2] <- 20

# A vector can only contain values of the same type
# otherwise you need a list!

# R is "clever" a.k.a reckless
maybe_a_vec <- c(1, 2, "hello")
maybe_a_vec # everything silently converted to strings
class(maybe_a_vec)

# What if you can't convert everything to the same type?
maybe_a_vec <- c(1, 2, "hello", print)
class(maybe_a_vec) # becomes a list (cf lists.R)


# Useful ways to create a vector ------------------------------------------

# Short way to create a sequence
1:10
# long way : seq(min, max, step)
seq(1, 10, 1)
seq(5.5, 7, 0.1)

# create a vector with a repeating pattern
rep(1, 10)
rep(c(1, 2), each=5)
rep(c(1, 2), times=3)
rep(c(1, 2), each=5, times=3)

# Create a random vector drawn uniformly at random between 1 and 10
# (note the variable name is plural to help me remember it is more than 1 number)
scores <- runif(n = 20, min = 0, max = 10)
length(scores) # 20 scores
scores
round(scores)

# Vectorised operations ----------------------------------------------------

# A binary operator is simply a function that you call in a more intuitive way
# The addition operator is `+`. You could call:
`+`(1, 2)
# But nobody does that! Instead you can write a binary operator this way instead:
1 + 2
# Operators in R are surrounded by `%` (except simple algebra)

# Simple algebra
1 + 3
5 - 2
10 / 3
3 ^ 2

# More algebra
10 %/% 3 # integer division
10 %% 3 # modulo (= remainder after integer division)
# They are linked by the following relationship:
3 * (10 %/% 3) + (10 %% 3)

# Remember that everything is a vector? All operators work on vectors!
# 1 - You can combine a vector with a scalar (vector of length 1)
(1:5) + 1
2 * (1:5)
(1:5) ^ 2
10 ^ (1:3)
# 2 - You can combine a vector with another vector of the same size
# will perform element-wise operation
c(1, 2, 3) + c(4, 3, 2)
rep(1, 5) / 1:5
# 3 - You technically can combine 2 vectors of different size but you shouldn't!
# Works by recycling values but throws a warning
(1:3) * (1:5) # will be 1*1, 2*2, 3*3, 1*4, 2*5
# same as c(1, 2, 3, 1, 2) * (1:5)
# common source of errors...

# In summary: never use loops to do operations on every element of a vector
# All common operations are already vectorised (i.e. work on vectors)

# Basic aggregation functions ---------------------------------------------

# Let's use the scores array
scores

mean(scores)
sum(scores)
sum(scores) / length(scores)
median(scores)
sd(scores) # standard dev
var(scores) # variance

# skewness and kurtosis using functions from the e1071 package
e1071::skewness(scores)
e1071::kurtosis(scores)

# useful functions
summary(scores)

quantile(scores, probs = seq(0, 1, 0.2))
cumsum(scores) # cumulative sum


# NA ----------------------------------------------------------------------

# NA is a special value for "Not Available"
# R is the ONLY language to have this! And it's one of the perks!

# NA propagates
val <- NA
val > 0
val + 1
# Can we check whether val is NA?
val == NA # doesn't work because NA propagates!
is.na(val) # special function
is.na(12)

# A vector typically contains NA when data was missing in the input (can't fix!)
# Or when it was improperly parsed (fix it!)
nums_str <- c("1", "12", "123", "hello!", "5")
nums <- as.numeric(nums_str)
nums # of course "hello!" could not be converted to a number: we have a NA instead

# You can renove NAs from a vector but this is rarely done
na.omit(nums)
# because NAs are part of the data and it is frowned upon to discard data

# Also because most basic functions offer a na.rm (remove NA) argument anyway

sum(nums) # NA propagates!
sum(nums, na.rm = T) # NA was removed
# same with mean, sd, var, etc
