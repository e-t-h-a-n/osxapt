# -*- make -*-
BASE=..
SUBDIR=darwin

.PHONY: startup dirs

ifeq ($(shell uname), Darwin)
all: $(BASE)/obj/apt-pkg/memrchr.o $(BASE)/obj/apt-pkg/strchrnul.o

$(BASE)/obj/apt-pkg/memrchr.o: memrchr.cc
	$(CXX) -c $^ -o $@
$(BASE)/obj/apt-pkg/strchrnul.o: strchrnul.cc
	$(CXX) -c $^ -o $@
endif
