LIB = $(CURDIR).a

OBJS = \
  colorflow.o\
  outerpdf.o\
  genevnt.o\
  evntinit.o\
  initmixgrade.o\
  totfun.o\
  pythia-6.4.24.o

$(LIB): $(LIB)($(OBJS))

$(LIB)($(OBJS)): inclcon.h invegas.h

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) $(LIB)

