SHELL := /bin/bash
perl_files=methods.pl Funcs.pm funcs.pl nonempty.pl autoload.pl Export/Attr.pm

all : fontify attr.html

attr.html : attr.pod
	perl -pe 's=L<([^|]+)>=L<$$1|http://p3rl.org/$$1>=g' $< \
	| pod2html - > $@

fontify :
	htmlize.sh $(perl_files)

clean :
	rm -f *.html Export/*.html

.PHONY : all clean fontify
