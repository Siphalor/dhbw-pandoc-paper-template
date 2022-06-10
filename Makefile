index.pdf: index.md pandoc/pandoc-pdf.yaml pandoc/template.latex
	pandoc -d pandoc/pandoc-pdf.yaml --filter pandoc-acro --filter pandoc-crossref --citeproc

index.html: index.md pandoc/pandoc-html.yaml pandoc/template.html
	pandoc -d pandoc/pandoc-html.yaml --filter pandoc-acro --filter pandoc-crossref --citeproc

