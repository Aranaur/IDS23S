# ggplot2 --------------------
cars

hist(cars$speed)

plot(cars$speed, cars$dist)

library(palmerpenguins)
library(tidyverse)

# penguins --------------------

penguins

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = bill_depth_mm)) +
  geom_point()


ggplot(penguins, aes(bill_length_mm,
                     bill_depth_mm)) +
  geom_point()


penguins %>% 
  ggplot(aes(bill_length_mm,
             bill_depth_mm)) +
  geom_point(size = 3) +
  geom_line()

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 shape = species)) +
  scale_shape_manual(values = c(1, 5, 10))

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm),
             fill = 'blue',
             color = 'yellow',
             shape = 21,
             size = 2,
             stroke = 1)

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 shape = species,
                 color = species)) +
  scale_color_manual(values = c("#19a6b3","#f26c0d","#5e3894"))

library(RColorBrewer)

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 shape = species,
                 color = species)) +
  scale_color_brewer(palette = 'Set3')

library(ggthemes)

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 shape = species,
                 color = species)) +
  scale_color_tableau()


penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 color = body_mass_g))

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 color = species)) +
  scale_color_manual(values = c("#19a6b3","#f26c0d","#5e3894")) +
  theme_bw() +
  xlab('Довжина клюва, мм') +
  ylab('Ширина клюва, мм')

penguins %>% 
  ggplot() +
  geom_point(aes(bill_length_mm,
                 bill_depth_mm,
                 color = species)) +
  scale_color_manual(values = c("#19a6b3","#f26c0d","#5e3894")) +
  theme_bw() +
  labs(
    x = 'Довжина клюва, мм',
    y = 'Ширина клюва, мм',
    title = 'Пінгвіни з станції Палмер',
    subtitle = 'Види пінгвінів',
    caption = 'Data: Long Term Ecological Research Networ'
  ) +
  theme(legend.position = c(0.1, 0.2),
        legend.title = element_blank())


penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm)) +
  geom_point(aes(color = species,
                 shape = species),
             alpha = 0.6,
             size = 3) +
  geom_smooth(aes(color = species),
              method = 'loess',
              se = FALSE) +
  scale_color_manual(values = c("#19a6b3","#f26c0d","#5e3894")) +
  theme_minimal() + 
  labs(
    x = 'Довжина клюва, мм',
    y = 'Ширина клюва, мм',
    title = 'Пінгвіни з станції Палмер',
    subtitle = 'Види пінгвінів',
    caption = 'Data: Long Term Ecological Research Networ'
  ) +
  theme(legend.position = c(0.85, 0.15),
        legend.title = element_blank())

# bubble --------------------


penguins %>% 
  ggplot(aes(
    x = bill_length_mm,
    y = bill_depth_mm,
    )) +
  geom_point(aes(color = species,
                 size = body_mass_g),
             alpha = 0.6) +
  scale_color_manual(values = c("#19a6b3","#f26c0d","#5e3894")) +
  theme_minimal()

# bar --------------------

penguins %>% 
  ggplot(aes(x=species, fill = species)) +
  geom_bar() + 
  scale_fill_manual(values = c("#19a6b3","#f26c0d","#5e3894")) + 
  theme_minimal() +
  coord_flip()

penguins %>% 
  ggplot() +
  geom_bar(aes(x = island, fill = species)) +
  scale_fill_manual(values = c("#19a6b3","#f26c0d","#5e3894"))
  

penguins %>% 
  ggplot() +
  geom_bar(aes(x = island, fill = species),
           position = 'fill') +
  scale_fill_manual(values = c("#19a6b3","#f26c0d","#5e3894"))
  
penguins %>% 
  filter(sex == 'female') %>% 
  count(species) %>% 
  ggplot() +
  geom_bar(aes(x = "",
               y = n,
               fill = species),
           stat = 'identity') +
  scale_fill_manual(values = c("#19a6b3","#f26c0d","#5e3894")) +
  coord_polar('y') +
  theme_void()
  
# lolipop --------------------  
  
penguins %>% 
  count(species) %>% 
  ggplot() +
  geom_segment(aes(x = species, xend = species,
                   y = 0, yend = n), linewidth = 1) +
  geom_point(aes(species, n, color = species),
             size = 4) + 
  coord_flip()
  
# hist -------------------- 

penguins %>% 
  drop_na() %>% 
  ggplot() + 
  geom_histogram(aes(flipper_length_mm, fill = species))

# density -------------------- 

penguins %>% 
  drop_na() %>% 
  ggplot() + 
  geom_density(aes(flipper_length_mm, fill = species), alpha = 0.5)

library(ggridges)

penguins %>% 
  drop_na() %>% 
  ggplot() + 
  geom_density_ridges(aes(flipper_length_mm, species, fill = paste(species, sex)),
                      alpha = 0.5,
                      color = NA) + 
  scale_fill_cyclical(labels = c("Female", "Male"),
                      values = c("tomato", "dodgerblue"),
                      name = "Стать",guide="legend") +
  theme_minimal()


penguins %>% 
  ggplot() +
  geom_density_ridges(
    aes(
      x = bill_length_mm,
      y = species,
      fill = species
    ),
    alpha = 0.5, scale = 1,
    jittered_points = TRUE,
    position = position_points_jitter(height = 0.1),
    point_size = 1
  ) +
  theme_minimal()

# jitter -------------------- 

penguins %>% 
  ggplot() +
  geom_point(aes(species, bill_length_mm, color = species))


set.seed(123)
penguins %>% 
  ggplot() +
  geom_jitter(aes(species, bill_length_mm, color = species))

# boxplot -------------------- 

penguins %>% 
  ggplot() +
  geom_boxplot(aes(species, bill_length_mm, fill = species)) +
  geom_jitter(aes(species, bill_length_mm, fill = species), size = 0.8, alpha = 0.5,
              width = 0.1)


# line plot -------------------- 

penguins %>% 
  group_by(year) %>% 
  summarise(avg_mass = mean(body_mass_g, na.rm =  TRUE)) %>% 
  ggplot() +
  geom_line(aes(year, avg_mass)) +
  geom_point(aes(year, avg_mass))















