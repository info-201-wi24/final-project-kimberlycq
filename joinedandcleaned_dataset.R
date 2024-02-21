library(tidyverse)
library(stringr)
library(ggplot2)
aidol <- read.csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/Songs/songs_all.csv")
hoth <- read.csv("https://raw.githubusercontent.com/HipsterVizNinja/random-data/main/Music/hot-100/Hot%20100.csv")

hoth <- hoth %>%
  group_by(song) %>%
  summarise(timesOnBillboard = n())

aidol <- aidol %>%
  select(-song, everything(), song)

joined <- left_join(aidol, hoth, by = "song") %>%
  replace_na(list(timesOnBillboard = 0)) %>%
  mutate(isOnBillboard = timesOnBillboard > 0) %>%
  select(season, week, contestant, artist, result, song, timesOnBillboard, isOnBillboard)