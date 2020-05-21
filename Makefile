all:
	@perl bf2c.pl mandelbrot.bf | gcc -O2 -xc - && time ./a