library(rvest)
library(tidyverse)
library(lubridate)
library(janitor)

m100 <- read_html('https://en.wikipedia.org/wiki/Men%27s_100_metres_world_record_progression')
m100

# before the IAAF
pre_IAAF <- m100 %>% 
  html_element('div+ .wikitable :nth-child(1)') %>% 
  html_table()

pre_IAAF <- pre_IAAF %>% 
  clean_names() %>% 
  mutate(date = mdy(date))

pre_IAAF

# ----------------------------------------------------

pre_IAAF <- m100 %>% 
  html_element('#mw-content-text > div.mw-parser-output > table:nth-child(11)') %>% 
  html_table() %>% 
  clean_names() %>% 
  mutate(date = mdy(date))

pre_IAAF

# ----------------------------------------------------

IAAF_76 <- m100 %>% 
  html_element('#mw-content-text > div.mw-parser-output > table:nth-child(17)') %>% 
  html_table() %>% 
  clean_names() %>% 
  mutate(date = mdy(date))

IAAF_76

# ----------------------------------------------------

IAAF <- m100 %>% 
  html_element('#mw-content-text > div.mw-parser-output > table:nth-child(22)') %>% 
  html_table() %>% 
  clean_names() %>% 
  mutate(date = mdy(date))

IAAF

# ----------------------------------------------------

IAAF_87 <- m100 %>% 
  html_element('#mw-content-text > div.mw-parser-output > table:nth-child(26)') %>% 
  html_table() %>% 
  clean_names() %>% 
  mutate(date = mdy(date))

IAAF_87

# ----------------------------------------------------
# ----------------------------------------------------

rbind(
  pre_IAAF %>% select(time, athlete, nationality, date),
  IAAF_76 %>% select(time, athlete, nationality, date),
  IAAF %>% select(time, athlete, nationality, date),
  IAAF_87 %>% select(time, athlete, nationality, date)
)

mwr_100 <- bind_rows(
  pre_IAAF %>% mutate(era = 'Pre-IAAF'),
  IAAF_76 %>% mutate(era = 'Pre-auto'),
  IAAF %>% mutate(era = 'Modern'),
  IAAF_87 %>% mutate(era = 'Low altitude')
) %>% 
  select(time, athlete, nationality, date, era)

mwr_100

mwr_100 %>% 
  ggplot() +
  geom_point(aes(date, time, col = fct_reorder2(era, date, time)), alpha = 0.5, size = 3) +
  geom_smooth(aes(date, time), se = FALSE) +
  labs(
    title = 'Прогрес швидкості проходження дистанції 100м серед чоловіків',
    x = 'Дата',
    y = 'Час',
    caption = 'Дані: Wikipedia'
  ) +
  theme_bw() +
  theme(legend.title = element_blank())

# ----------------------------------------------------
# ----------------------------------------------------

url <- 'https://rozetka.com.ua/kompyuternie-kolonki/c4671536/'

speakers_list <- read_html(url)

speakers_list

speakers <- speakers_list %>% 
  html_elements('.goods-tile__title , .goods-tile__price-value')

speakers <- speakers %>% 
  html_text()

t(matrix(speakers, nrow = 2)) %>% 
  as_tibble() %>% 
  rename(name = V1,
         price = V2)



























