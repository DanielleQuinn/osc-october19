# ---- Load Packages ----





# ---- Set Working Directory ----


# ----  Challenge 1 ----
# Formatting dates
# Read in data

# Inspect data



# Create date column

# Create datetime column

# Inspect data





# ---- Challenge 1 (more!) ----
# Measuring time intervals

# In hours


# check if a year was a leap year



# display weekday

# display weekday name


# show time zone

# set time zone

# convert to other time zone



# ---- Challenge 2 ----
# Converting from wide to long format

# Inspect wide




# Convert to long format

# Inspect long




# Convert back to wide format



# ---- Challenge 3 ----
# Including absense data

# Inspect presence



# Add records of species not included as zeros



# ---- Challenge 4 ----
# Merging two data sets


# Inspect set1

# Inspect set2

# Merge set1 and set2

# Inspect setdata


# What if values were missing?

# Inspect set3

# Merge setdata and set3

# Inspect newsetdata


# What if we wanted to replace those NAs with the average distance of all other trawls?





# ---- Introduction to dplyr ----

# Inspect gap




# dplyr 'verbs' (really just functions!)
# select() - picks variables (columns) based on their names
# filter() - picks observations (rows) based on their values
# arrange() - order observations by a variable or variables
# mutate() - creates new variables that are functions of existing variables
# summarise() - reduces values of multiple observations down to a single summary
# group_by() - group observations by variable

# Extract the year and country variables


# Extract data from 1982



# ---- Introduction to pipes ----
# Extract the year and country variables



# Extract data from 1982



# Extract data from 1982 and arrange it by continent




# Create a dummy variable called new value equal to population / life expectancy



# Extract cases where newvalue is less than 2000





# ---- Generating Summary Stats ----
# Find the average life expectancy in 1982




# Find the average population and sd of population of Africa





# ---- Generating Summary Tables ----
# Table 1. The average population of each continent







# Table 2. The average population of each continent in 1982 and 1987









# Table 3. Range, mean, sd of life expectancy from every European country
# range as "min-max" rounded to omit decimal points
# mean and sd rounded to 2 places










# Extract table3 where the country has the letter "b" in it





# ---- More Complex Applications ----
# For each observation, find the difference in life expectancy between
# that record and the average life expectancy of that continent in that year

# Step 1: find average life expectancy of each continent per year







# Step 2: merge that information with gapminder




# Step 3: let's pull interesting information from this!
# Which European country had the biggest difference in 2007?





  
