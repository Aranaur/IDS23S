# Базові операції

1 + 1 # додавання

5 - 2 # віднімання 

3 * 5

25 / 6

3 ^ 3

5 %% 3

17 %/% 5

3 + 2 * 4

(3 + 2) * 4

# Базові функції

25 ^ 0.5

25 ^ (1/2)

sqrt(25)

############### Sqrt(25) 

sqrt((3 + 2) * 4)

abs(3 - 5)

log(15)

log(x = 3, base = 10)

log(base = 10, x = 3)

log(3, 10)

log(10, 3)

# Змінні

i_love_r = sqrt((3 + 2) * 4)

hello_r <- log(3, 10)

abs(3 - 5) -> abs_r

(i_love_r + hello_r) ^ abs_r

# Оператори порівняння

i_love_r == hello_r

i_love_r != hello_r

i_love_r > hello_r

i_love_r < hello_r

i_love_r >= hello_r

i_love_r <= hello_r

# Типи даних

## Числові

### integer - цілі
### double - дробові
### complex - комплексні

typeof(i_love_r)
typeof(sqrt(25))

typeof(10L)

is.numeric(sqrt(25))

is.double(10L)
is.integer(10L)

## Текст

my_text <- 'Hello!'

my_text2 <- "Hello, R!"

name <- "Моє ім'я: Ігор!"
name2 <- 'Моє ім\'я: Віктор!'

is.character(name)

typeof(name)

## Логічні

typeof(TRUE)

FALSE

# Структури даних

1:10

1

c(1, 5, 15, -35)

c('one', 'two', '3')

-5:5

five_to_five <- 5:-5

typeof(five_to_five)

seq(from = 10, to = 50, by = 3)
seq(10, 50, 3)
seq(10, 50, length.out = 23)

rep(3, 5)
rep(3:5, 5)
rep(1:3, 1:3)

rep('ABC', 5)

c('1', '2', 3)

c('TRUE', TRUE, 'FALSE')

c(1, TRUE, FALSE, 2)

25 + TRUE

as.character(25 + TRUE)
as.double(TRUE)

# Операції з векторами

vec_1 <- 1:5

vec_1 + 5

vec_2 <- 2:6

(vec_1 + vec_2) ^ vec_2

vec_6 <- sqrt(vec_1 ^ vec_2 + vec_2 - 3 * vec_1)


vec_3 <- 1:2
vec_4 <- 1:4
vec_5 <- 1:3

vec_3 + vec_4

vec_3 + vec_5

# індексація

vec_6[seq(1, 5, 2)] <- 123

vec_6

vec_6[-c(1, 3, 5)]

# Матриці

my_matrix <- matrix(data = seq(1, 32, 2),
                    nrow = 4,
                    ncol = 4,
                    byrow = TRUE,
                    dimnames = list(c("row1", "row2", "row3", "row4"),
                                    c("C.1", "C.2", "C.3", "C.4")))

my_matrix ^ 2

my_matrix[1:2, 3:4] <- 0

my_matrix[, 3]

# Масиви

array(1:16, c(4, 2, 2))

# Списки
mu_list <- list(vec = 1:5,
                hello = "Hello, R!",
                matrix = my_matrix)

mu_list[['matrix']][2, 2]

mu_list$vec[3]

# Дата фрейми

my_df <- data.frame(
  id = 1:3,
  name = c('Ihor', 'Max', 'Ann'),
  age = c(35, 46, 18),
  univ = c(TRUE, TRUE, FALSE)
)

str(mtcars)
head(mtcars)
tail(mtcars)

mtcars <- mtcars

