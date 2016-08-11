# GDB dashboard - Modular visual interface for GDB in Python.
#
# https://github.com/cyrus-and/gdb-dashboard
# This file contains the generic settings

set prompt gdb> 

# Stop printing arrays at a nul
set print null-stop

# setup signal handling
handle SIGALRM nostop print nopass
handle SIGBUS  stop   print nopass
handle SIGPIPE nostop print nopass
handle SIGSEGV stop   print nopass

# Pretty Print things
set print pretty on
set print array on

# allow setting of breakpoints in shared lib
set breakpoint pending on

python
from __future__ import print_function

import os
import sys

home = os.path.join("/home", os.getenv("USER"))
additional_site_packages = os.path.join(home, ".pyenv/versions/3.4.3/lib/python3.4/site-packages")
additional = [os.path.join(additional_site_packages, x) for x in os.listdir(additional_site_packages) if x[-3:] == 'egg']

for i in additional:
    sys.path.insert(0, i)

sys.path.insert(len(additional) + 1, additional_site_packages)

try:
    import voltron
    voltron_path = os.path.sep.join(voltron.__file__.split(os.path.sep)[:-1] + ["entry.py"])
    gdb.execute('source ' + voltron_path)

    for i in ["Projekty", "Projects"]:
        if os.path.exists(os.path.join(home, i)):
            pwndbg = os.path.join(home, i, "pwndbg/gdbinit.py")
    gdb.execute('source ' + pwndbg)
except Exception as e:
    print(e)
    print(sys.version)
    print(sys.path)
end

voltron init

# When inspecting large portions of code the scrollbar works better than 'less'
set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on

# source ~/.gdb.dashboard.py

# Better GDB defaults ----------------------------------------------------------

set history save
set confirm off
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full

# Start ------------------------------------------------------------------------

# python Dashboard.start()

# ------------------------------------------------------------------------------
# Copyright (c) 2015-2016 Andrea Cardaci <cyrus.and@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------
# vim: filetype=python
# Local Variables:
# mode: python
# End:
set disassembly-flavor intel
