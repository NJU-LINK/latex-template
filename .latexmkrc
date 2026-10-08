# XeLaTeX; no shell escape and no system-specific font dependencies.
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;
