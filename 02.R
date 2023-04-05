# Tidyverse ---------------------------------------

library(tidyverse)

## data.frame vs. tibble --------------------------

head(iris)
str(iris)

iris_tbl <- as_tibble(iris)

iris_tbl

class(iris)
class(iris_tbl)

## read data -------------------------------------


### read csv

cars_tbl <- read_delim('https://raw.githubusercontent.com/Aranaur/datasets/main/datasets/cars2018.csv',
                   delim = ';')

cars_loc_tbl <- read_csv2("00_data/cars2018.csv")

files <- dir(path = '00_data/', pattern = '\\.csv$')
cars_all <- read_delim(here::here('00_data', files))

### excel

library(readxl)

excel_sheets("00_data/cars2018.xlsx")

cars_xl_tbl <- read_excel('00_data/cars2018.xlsx', sheet = 'cars2018')

cars_xl_tbl

## dplyr ------------------------------------------------------------

glimpse(cars_tbl)

### filter()

filter(cars_tbl,
       mpg >= mean(mpg),
       transmission == 'Manual'
       )

filter(cars_tbl,
       cylinders == 6 | cylinders == 8 | cylinders == 12)

filter(cars_tbl,
       cylinders %in% c(6, 8, 12))

### pipe %>%

sort(log(sqrt(abs(sin(1:10)))))

1:10 %>% 
  sin() %>%
  abs() %>%
  sqrt() %>%
  log() %>%
  sort()

cars_tbl %>% 
  glimpse()

cars_tbl %>% 
  filter(
    mpg >= mean(mpg),
    transmission == 'Manual'
  )

cars_tbl %>% 
  filter(
    cylinders %in% c(6, 8, 12)
    )

### slice()

cars_tbl %>% 
  slice(c(1, 500, 610))

cars_tbl %>% 
  slice(1:5, 100)

cars_tbl %>% 
  slice(seq(1, 50, 3))

cars_tbl %>% 
  slice(-c(1, 500, 610))

cars_tbl %>% 
  head()

cars_tbl %>% 
  tail()

cars_tbl %>% 
  slice_head(n = 20)

cars_tbl %>% 
  slice_tail(n = 20)

cars_tbl %>% 
  slice_max(mpg, n = 3)

cars_tbl %>% 
  slice_min(mpg, n = 3)

cars_tbl %>% 
  slice_sample(n = nrow(cars_tbl), replace = TRUE)

### arrange()

cars_tbl %>% 
  filter(mpg > mean(mpg)) %>% 
  slice_min(mpg, n = 85) %>% 
  arrange(desc(displacement), gears)

### select()

cars_tbl %>% 
  select(model, gears:mpg)

cars_tbl %>% 
  select(seq(1, ncol(cars_tbl), 3))

cars_tbl %>% 
  select(!c(model_index, max_ethanol))

cars_tbl %>% 
  select(starts_with('mo'))

cars_tbl %>% 
  select(ends_with('n'))

cars_tbl %>% 
  select(contains('o'))

cars_tbl %>% 
  select(matches('[ms]i')) # mi | si

cars_tbl %>% 
  select(where(is.character))

cars_tbl %>% 
  select(model, where(is.numeric))

cars_tbl %>% 
  select(model, where(is.numeric), everything())

### relocate()

cars_tbl %>% 
  relocate(mpg, .before = gears)

cars_tbl %>% 
  relocate(where(is.double), .after = where(is.character))

### rename()

cars_tbl %>% 
  rename(disp = displacement,
         id = model_index,
         cyl = cylinders) %>% 
  rename_with(toupper)

cars_tbl %>% 
  rename_with(toupper, ends_with('n'))

cars_tbl %>% 
  rename_with(~ gsub("_", '.', .x))

cars_tbl %>% 
  set_names(names(.) %>% str_replace('_', '.') %>% str_to_title())

### mutate()

cars_tbl %>% 
  select(model, mpg) %>% 
  mutate(kpl = mpg * 0.425,
         round_kpl = round(kpl, 1),
         record = row_number())

cars_tbl %>% 
  transmute(model,
            kpl = mpg * 0.425)

### group_by() + summarise()

cars_tbl %>% 
  group_by(transmission, cylinders) %>% 
  summarise(avg_mpg = mean(mpg),
            md_mpg = median(mpg),
            sd_mpg = sd(mpg)) %>% 
  ungroup()

cars_tbl %>% 
  group_by(transmission, cylinders) %>% 
  summarise(avg_mpg = mean(mpg),
            avg_disp = mean(displacement),
            avg_max_ethanol = mean(max_ethanol)) %>% 
  ungroup()
            
cars_tbl %>% 
  select(-model_index) %>% 
  group_by(transmission) %>% 
  summarise(
    across(where(is.numeric),
           list(avg = mean,
                stdev = sd),
           .names = '{.col}_{.fn}')
  )

### count()

cars_tbl %>% 
  group_by(transmission) %>% 
  summarise(n = n())

cars_tbl %>% 
  count(transmission, sort = TRUE)

### case_when()

cars_tbl %>% 
  select(model, mpg) %>% 
  mutate(
    bin_mpg = case_when(
      mpg > 28 ~ 'economy',
      mpg > 20 ~ 'medium',
      mpg <=20 ~ 'hight',
      TRUE ~ 'NA'
    )
  )

### pivot_*()

cars_tbl %>% 
  select(model:gears, mpg) %>% 
  pivot_longer(
    cols = model_index:mpg,
    names_to = 'var_name',
    values_to = 'value'
  )
