

# Cut ---------------------------------------------------------------------

# cut a vector = bin elements in groups
cut(scores, breaks = c(0, 3, 7, 10))

# Much better cutting options provided by Hmisc:cut2
Hmisc::cut2(scores, cuts = c(0, 3, 7, 10))
# cut in 3 groups (of approx same size)
Hmisc::cut2(scores, g = 3)
# cut in groups containing at least 2 elements each
Hmisc::cut2(scores, m = 2)