LIB = $(CURDIR).a

OBJS = \
   p1p1amp.o\
   pj0amp.o\
   pj1amp.o\
   pj2amp.o\
   p_lorentz.o\
   p_samp.o

PWAVE_H =\
   inclamp.h\
   inclppp.h\
   inclcon.h

$(LIB): $(LIB)($(OBJS))

$(LIB)($(OBJS)): $(PWAVE_H)

clean distclean:
	$(RM) $(OBJS) $(LIB)

