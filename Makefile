.PHONY: clean

define COMMON_PARAMS
-f markdown+implicit_figures+backtick_code_blocks \
--number-sections \
--toc \
--smart \
--standalone \
--normalize \
--filter pandoc-crossref \
--filter pandoc-citeproc \
--bibliography references.bib \
--csl style/iso690-author-date-cs.csl \
parts/metadata.yaml
endef

html:
	pandoc --mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_CHTML-full \
		-o index.html \
		--template style/dokieli.html \
		--css http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css \
		--css http://fonts.googleapis.com/css?family=Source+Sans+Pro:700 \
		--css http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic \
		--css https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css \
		--css https://dokie.li/media/css/do.css \
		--css media/css/bootstrap.css \
		$(COMMON_PARAMS) \
		parts/*.md

pdf:
	pandoc --latex-engine=xelatex \
		--include-before-body parts/title_page.tex \
		--include-before-body parts/affidavit.tex \
		-o text.pdf \
		--variable citecolor=orange \
		--variable urlcolor=orange \
		--variable linkcolor=orange \
		--template style/template.tex \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		$(COMMON_PARAMS) \
		staging/*.md parts/*.md

excerpt:
	pandoc --latex-engine=xelatex \
		--include-before-body parts/title_page.tex \
		-o excerpt.pdf \
		--variable citecolor=orange \
		--variable urlcolor=orange \
		--variable linkcolor=orange \
		--template style/template.tex \
		-V fontsize=12pt \
		-V papersize=a4paper \
		-V documentclass:report \
		$(COMMON_PARAMS) \
		parts/*.md

clean:
	rm -f index.html text.pdf excerpt.pdf
