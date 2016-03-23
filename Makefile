all: figVI.png

figV.pdf:
	Rscript --vanilla fig-v.R

figVI.png: figV.pdf
	Rscript --vanilla fig-vi.R
