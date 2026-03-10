# superNetballR

[![Build Status](https://travis-ci.org/craigmoyle/superNetballR_updated.svg?branch=main)](https://travis-ci.org/craigmoyle/superNetballR_updated)

## Description

This fork of `superNetballR` allows the downloading of super netball statistics from the original project site: [https://stevelane.github.io/superNetballR/](https://stevelane.github.io/superNetballR/). The first super netball season was in 2017, and was eventually won by the Sunshine Coast Lightning.

`superNetballR` contains helper functions that transform the downloaded data into usable tidy data.

This repository is maintained at [craigmoyle/superNetballR_updated](https://github.com/craigmoyle/superNetballR_updated).

## Installation

Installation in R requires `devtools`. To install, run the following from an R session:

``` R
devtools::install_github("craigmoyle/superNetballR_updated")
```

To install the current `main` branch explicitly:

``` R
devtools::install_github("craigmoyle/superNetballR_updated@main")
```

## Notes

The package has been updated to account for the super goal in 2020. Ladders and points have been adjusted for this. If you want to use the old scoring systems, these are available using `_pre_2020` versions of the appropriate functions.
