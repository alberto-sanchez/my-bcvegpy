# --- variables defined by configure ---

FC = gfortran
FFLAGS = -O0 -ffixed-line-length-none -g

CC = gcc
CFLAGS = -O3 -fomit-frame-pointer -ffast-math -g -DHAVE_UNDERSCORE

CPP=cpp
# --- end defs by configure ---

.PHONY: default force mostlyclean clean distclean

default: run 

export VPATH := $(CURDIR):$(CURDIR)/generate:$(CURDIR)/swave:$(CURDIR)/pwave\
                :$(CURDIR)/phase:$(CURDIR)/pybook:$(CURDIR)/setparameter\
                :$(CURDIR)/system

INCLUDE := $(patsubst %,-I%,$(subst :, ,$(VPATH)))

PREFIX =

FFLAGS += $(INCLUDE)

export FC
export FFLAGS
export CC
export CFLAGS

LIBS = generate.a swave.a pwave.a phase.a setparameter.a system.a pybook.a 

$(LIBS): force
	$(MAKE) -C $*

DEPS := $(wildcard *.d)

mostlyclean:
	$(RM) $(DEPS) $(DEPS:%.d=%.o) $(DEPS:%.d=%)

clean: mostlyclean
	for dir in $(basename $(LIBS)) ; do \
	  $(MAKE) -C $$dir clean ; \
	done

distclean: mostlyclean
	for dir in $(basename $(LIBS)) ; do \
	  $(MAKE) -C $$dir distclean ; \
	done

MAKECMDGOALS ?= run 

-include $(MAKECMDGOALS:%=%.d)

%.d: %.F
	( echo "$*: $@ $(LIBS)" ; \
	  $(CPP) -M $(INCLUDE) $< | sed 's/^.*:/$@:/' ) > $@ 

%:: %.F %.d
	$(FC) $(FFLAGS) -DPREFIX=$(PREFIX) -o $@ $< $(LIBS) -lm  
	-$(RM) $*.o

# end of makefile

