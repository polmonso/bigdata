
CHeatsheet
==========

general
-------
source("file.r")

getwd()

?function_name shows docs

vectors atòmics:
----------------
c is short for combine

foo = c(1,3,4,2,3,123,3,2,2)

parameters can be numeric, textual or boolean

operators repeat to match vector lengths e.g. c(1,2,3,4) + c(1,2) = c(2,4,4,6)
if repeated lengths do not match you'll get a warning but it does it anyway

ranges:
1:10
seq(1,10,2)
seq(0,1,length=10)

slicing
-------
foo = c('a','b','c','d','e')

positional
```r
foo[c(1,2)] -> ab
foo[c(-1,-2)] -> cde
foo[seq(1,4,2)] -> ac
```

logic
```r
foo[1:5 < 3] = ab
```

Label elements to access by name
x=1:12
names(x) = month.abb

then
x['Jan'] -> 1

lists
construct: foo = list(3)
slice: foo[1] -> dataframe-like  [[1]] [1] 3
get element: foo[[1]] -> 3

taula$capture_rate és equivalent a taula[['capture_rate']]


util functions
---------------

sapply(c(1,2), fib) : where fib is a function, applies function to each element
lapply -> list
mapply : zip with apply, coerced by min lenght

is.list()

```r
foo[['name']] is equivalent to foo$name
```

_io_

read_csv2 és el read_csv europeu
read_delim() per més control

```r
read_delim(
  "foo.csv",
  delim = ';',
  escape_double = FALSE,
  locale = locale(decimal_mark=',', grouping_mark='.'),
  guess_max = 1912, # forçar que miri fins a la fila 1912 per decidir column type
  trim_ws = TRUE
)
```

problems(data) # t'indica discrepancies entre expected i actual de columnes type

View(taula) a RStudio t'ensenya la taula interactiva
flimpse(taula)

preguntes per resoldre
======================

Taula és un tipus? Quin?

summarise(group_by(obres, tipus_local, n = n())) és equivalent a count(obres, Tipus_local)


proportions within a group:

mutate(group_by(birthwt_tab, smoke) p = n/sum(n))

gives

smoke low n p
0 0 86 0.748
0 1 29 0.252
1 0 44 0.595
1 1 30 0.405