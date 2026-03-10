# Makefile
.PHONY: all build check checking clean document install site test winbuild

PKG_TARBALL := $(shell Rscript -e "desc <- read.dcf('DESCRIPTION')[1, ]; cat(sprintf('%s_%s.tar.gz', desc[['Package']], desc[['Version']]))")

all: document test check install

checking: document test check

document:
	Rscript -e "roxygen2::roxygenise()"

build:
	R CMD build .

test:
	Rscript -e "testthat::test_local('.', reporter = 'summary', stop_on_failure = TRUE)"

check: build
	R CMD check --no-manual --as-cran $(PKG_TARBALL)

install:
	R CMD INSTALL .

winbuild:
	@echo "Use the GitHub Actions R-CMD-check workflow for Windows validation."

site:
	Rscript -e "pkgdown::build_site()"

clean:
	rm -rf *.tar.gz *.Rcheck
