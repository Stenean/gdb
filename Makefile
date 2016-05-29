GDBINIT=gdbinit
DASHBOARD=dashboard.py

install:
	if [ -f ~/.$(GDBINIT) ]; then \
	    cp ~/.$(GDBINIT) ~/.$(GDBINIT).bck; \
	fi; \
	rm -f ~/.$(GDBINIT) ~/.gdb.$(DASHBOARD); \
	ln -s $(shell pwd)/$(GDBINIT) ~/.$(GDBINIT); \
	ln -s $(shell pwd)/$(DASHBOARD) ~/.gdb.$(DASHBOARD);
