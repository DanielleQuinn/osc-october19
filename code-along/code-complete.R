# ---- Load Packages ----
library(dplyr)
library(tidyr)
library(lubridate)


# ---- Set Working Directory ----
setwd("C:/Users/Danielle/Desktop/osc-october19/code-along/data")


# ----  Challenge 1 ----
# Formatting dates
# Read in data
data<-read.delim("dates.txt")
# Inspect data
str(data)
dim(data)
names(data)
# Create date column
data$date<-ymd(paste(data$year, data$month, data$day, sep="-"))
# Create datetime column
data$datetime<-ymd_hms(paste(data$year, data$month, data$day, data$hour, data$minute, data$second, sep="-"))
# Inspect data
str(data)
dim(data)
names(data)


# ---- Challenge 1 (more!) ----
# Measuring time intervals
difftime(max(data$datetime),min(data$datetime))
# In hours
difftime(max(data$datetime), min(data$datetime), units='hours')

# check if a year was a leap year
leap_year(2011)
leap_year(2012)

# display weekday
wday(data$datetime)
# display weekday name
wday(data$datetime, label=TRUE)

# show time zone
tz(data$datetime)
# set time zone
data$datetime<-force_tz(data$datetime, "EST")
# convert to other time zone
with_tz(data$datetime, "America/Chicago")


# ---- Challenge 2 ----
# Converting from wide to long format
wide<-read.delim("wide-format.txt")
# Inspect wide
str(wide)
dim(wide)
names(wide)
head(wide)
# Convert to long format
long<-gather(wide, key="species",value="count", -c(year, site))
# Inspect long
str(long)
dim(long)
names(long)
head(long)
# Convert back to wide format
spread(long, key="species",value="count")


# ---- Challenge 3 ----
# Including absense data
presence<-read.delim("presence.txt")
# Inspect presence
str(presence)
dim(presence)
head(presence)
# Add records of species not included as zeros
presence_absence<-data.frame(complete(presence, transect, year, species, fill=list(abundance=0)))


# ---- Challenge 4 ----
# Merging two data sets
set1<-read.delim("set1.txt")
set2<-read.delim("set2.txt")
# Inspect set1
set1
# Inspect set2
set2
# Merge set1 and set2
setdata<-left_join(set1, set2)
# Inspect setdata
setdata

# What if values were missing?
set3<-read.delim("set3.txt")
# Inspect set3
set3
# Merge setdata and set3
newsetdata<-left_join(setdata, set3)
# Inspect newsetdata
newsetdata

# What if we wanted to replace those NAs with the average distance of all other trawls?
meandistance<-mean(newsetdata$distance, na.rm=TRUE)
meandistance
replace_na(newsetdata, list(distance=meandistance))


# ---- Introduction to dplyr ----
gapminder<-read.delim("gapminder.txt")
# Inspect gap
head(gapminder)
str(gapminder)
dim(gapminder)

# dplyr 'verbs' (really just functions!)
# select() - picks variables (columns) based on their names
# filter() - picks observations (rows) based on their values
# arrange() - order observations by a variable or variables
# mutate() - creates new variables that are functions of existing variables
# summarise() - reduces values of multiple observations down to a single summary
# group_by() - group observations by variable

# Extract the year and country variables
select(gapminder, year, country)

# Extract data from 1982
filter(gapminder, year==1982)


# ---- Introduction to pipes ----
# Extract the year and country variables
gapminder%>%
  select(year, country)

# Extract data from 1982
gapminder%>%
  filter(year==1982)

# Extract data from 1982 and arrange it by continent
gapminder%>%
  filter(year==1982)%>%
  arrange(continent)

# Create a dummy variable called new value equal to population / life expectancy
gapminder%>%
  mutate(newvalue=pop/life_exp)

# Extract cases where newvalue is less than 2000
gapminder%>%
  mutate(newvalue=pop/life_exp)%>%
  filter(newvalue<2000)


# ---- Generating Summary Stats ----
# Find the average life expectancy in 1982
gapminder%>%
  filter(year==1982)%>%
  summarise(mean_life=mean(life_exp))

# Find the average population and sd of population of Africa
gapminder%>%
  filter(continent=="Africa")%>%
  summarise(mean_pop=mean(pop), sd_pop=sd(pop))


# ---- Generating Summary Tables ----
# Table 1. The average population of each continent
table1<-gapminder%>%
  group_by(continent)%>%
  summarise(mean_pop=mean(pop))%>%
  ungroup()%>%
  data.frame()
table1

# Table 2. The average population of each continent in 1982 and 1987
table2<-gapminder%>%
  filter(year %in% c(1982, 1987))%>%
  group_by(continent, year)%>%
  summarise(mean_pop=mean(pop))%>%
  ungroup()%>%
  arrange(year)%>%
  data.frame()
table2

# Table 3. Range, mean, sd of life expectancy from every European country
# range as "min-max" rounded to omit decimal points
# mean and sd rounded to 2 places
table3<-gapminder%>%
  filter(continent=="Europe")%>%
  group_by(country)%>%
  summarise(range=paste(round(min(life_exp),0),round(max(life_exp),0),sep="-"),
            mean=round(mean(life_exp),2),
            sd=round(sd(life_exp),2))%>%
  ungroup()%>%
  data.frame()
table3

# Extract table3 where the country has the letter "b" in it
table3%>%
  slice(grep("b", country))%>%
  data.frame()


# ---- More Complex Applications ----
# For each observation, find the difference in life expectancy between
# that record and the average life expectancy of that continent in that year

# Step 1: find average life expectancy of each continent per year
myinfo<-gapminder%>%
  group_by(continent, year)%>%
  summarise(mean_life=mean(life_exp))%>%
  ungroup()%>%
  data.frame()
myinfo

# Step 2: merge that information with gapminder
merged_gap<-gapminder%>%
  left_join(myinfo)%>%
  mutate(life_diff=life_exp-mean_life)

# Step 3: let's pull interesting information from this!
# Which European country had the biggest difference in 2007?
merged_gap%>%
  filter(continent=="Europe" & year==2007)%>%
  filter(abs(life_diff)==max(abs(life_diff)))%>%
  select(country, life_exp, mean_life, life_diff)

  
