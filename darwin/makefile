# -*- make -*-
BASE=..
SUBDIR=darwin

.PHONY: startup dirs

ifeq ($(shell uname), Darwin)
all: $(BASE)/obj/apt-pkg/memrchr.opic $(BASE)/obj/apt-pkg/strchrnul.opic

$(BASE)/obj/apt-pkg/memrchr.opic: memrchr.cc
	$(CXX) -c -DPIC -fPIC $^ -o $@
$(BASE)/obj/apt-pkg/strchrnul.opic: strchrnul.cc
	$(CXX) -c -DPIC -fPIC $^ -o $@
endif
