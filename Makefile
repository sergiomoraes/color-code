.PHONY: all
all: demo

venv: requirements.txt
	rm -rf venv
	virtualenv venv -ppython3.6
	venv/bin/pip install -rrequirements.txt

%.py: %.tmpl venv
	venv/bin/cheetah-compile $<

.PHONY: demo
demo: color_code.py index.py
	venv/bin/python demo.py

.PHONY: push
push: venv
	venv/bin/markdown-to-presentation push index.htm index.css out

.PHONY: clean
clean:
	rm -rf venv color_code.py index.htm out *.pyc
