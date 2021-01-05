LIB = $(CURDIR).a

OBJS = \
      vegas.o\
      phase_gen.o\
      phase_point.o

$(LIB): $(LIB)($(OBJS))

$(LIB)($(OBJS)): invegas.h

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) $(LIB)

