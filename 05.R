library(tidyverse)
library(tidytext)
library(gutenbergr)
library(wordcloud)
library(textdata)
library(reshape2)
library(plotly)

gutenberg_metadata %>% 
  count(author, sort = TRUE)

stocker <- gutenberg_works(author == 'Stoker, Bram') %>% 
  gutenberg_download(meta_fields = 'title')

stocker %>% 
  count(title, sort = TRUE)

data('stop_words')

stop_words %>% 
  slice_sample(n = 10)

tidy_stoker <- stocker %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words)

count_words <- tidy_stoker %>% 
  count(word, sort = TRUE) %>% 
  filter(n > 600) %>% 
  ggplot(aes(n, reorder(word, n))) +
  geom_col() +
  ylab(NULL)

count_words %>% 
  ggplotly()

# ----------------------------------

afinn <- get_sentiments('afinn')
bing <- get_sentiments('bing')
loughran <- get_sentiments('loughran')
nrc <- get_sentiments('nrc')

afinn %>% 
  distinct(value) %>% 
  arrange(value)

afinn %>% 
  count(value, sort = TRUE)

bing %>% 
  count(sentiment, sort = TRUE)

loughran %>% 
  count(sentiment, sort = TRUE)

nrc %>% 
  count(sentiment, sort = TRUE)

# ----------------------------------

stoker_afinn <- tidy_stoker %>% 
  inner_join(afinn) %>% 
  count(word, value, sort = TRUE) %>% 
  ungroup()

set.seed(123)
tidy_stoker %>% 
  inner_join(bing) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  acast(word ~ sentiment, value.var = "n", fill = 0) %>% 
  comparison.cloud(max.words = 100,
                   title.bg.colors = "white")

tidy_stoker %>% 
  inner_join(afinn) %>% 
  count(word, value, sort = TRUE) %>% 
  acast(word ~ value, value.var = "n", fill = 0) %>% 
  comparison.cloud(max.words = 1000,
                   title.bg.colors = "white")

set.seed(123)
tidy_stoker %>% 
  inner_join(loughran) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  acast(word ~ sentiment, value.var = "n", fill = 0) %>% 
  comparison.cloud(max.words = 1000,
                   title.bg.colors = "white")

tidy_stoker %>% 
  inner_join(nrc) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  acast(word ~ sentiment, value.var = "n", fill = 0) %>% 
  comparison.cloud(max.words = 100,
                   title.bg.colors = "white")

# -------------------------------------------------------

stoker_afinn %>% 
  group_by(value) %>% 
  top_n(10) %>% 
  ungroup() %>% 
  ggplot(aes(reorder(word, n), n, fill = as.factor(value))) +
  geom_col() +
  coord_flip()


stoker_bing <- tidy_stoker %>% 
  inner_join(bing) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  ungroup()

stoker_bing %>% 
  group_by(sentiment) %>% 
  top_n(30) %>% 
  ungroup() %>% 
  ggplot(aes(reorder(word, n), n, fill = as.factor(sentiment))) +
  geom_col() +
  coord_flip()

stoker_loughran <- tidy_stoker %>% 
  inner_join(loughran) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  ungroup()

stoker_loughran %>% 
  group_by(sentiment) %>% 
  top_n(5) %>% 
  ungroup() %>% 
  ggplot(aes(reorder(word, n), n, fill = as.factor(sentiment))) +
  geom_col() +
  coord_flip()

stoker_nrc <- tidy_stoker %>% 
  inner_join(nrc) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  ungroup()

stoker_nrc_plot <- stoker_nrc %>% 
  group_by(sentiment) %>% 
  top_n(5) %>% 
  ungroup() %>% 
  ggplot(aes(reorder(word, n), n, fill = as.factor(sentiment))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ sentiment, scales = 'free_y') + 
  coord_flip() +
  theme_bw()

stoker_nrc_plot %>% 
  ggplotly()
