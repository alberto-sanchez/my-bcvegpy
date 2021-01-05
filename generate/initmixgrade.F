
c*
c** initialize the grade to derive the mixed events.
c*

      subroutine initmixgrade
      implicit double precision(a-h, o-z)
	implicit integer(i-n)

#include "invegas.h"

	common/mixevnt/xbcsec(10),xbcsecerr(10),imix,imixtype
	common/mixevnt2/xbcsum,xbcerrsum,ibclimit
	common/grade/xi(NVEGBIN,10)
      common/counter/ibcstate,nev
      common/loggrade/ievntdis,igenerate,ivegasopen,igrade
      logical usegrade,usevegas
	common/vegcross/vegsec,vegerr,iveggrade
  	common/vegaspar/si,si2,swgt,schi,itime
	character*1 pfile
	logical unwght
	common/unweight/unwght
	common/xxmax/xmax(NVEGBIN,8)
	integer :: infile(10)
	data infile/36,37,38,39,46,47,48,49,56,57/

         usegrade=.false.
         if(igrade.eq.1) usegrade=.true.
         usevegas=.false.
         if(ivegasopen.eq.1) usevegas=.true.

c*********************************************************
c*** define which state to be generated next .
c*********************************************************
           if(imixtype.eq.1.or.imixtype.eq.2) ibcstate=0
           if(imixtype.eq.3) ibcstate=2

           ranbc=xbcsum*pyr(0)
55         ibcstate=ibcstate+1
           ranbc =ranbc-xbcsec(ibcstate)
           if(ibcstate.lt.ibclimit .and. ranbc.gt.1.0d-16) go to 55

c----------------------
           if(ibcstate.lt.3 .or. ibcstate.gt.6) then
               call paraswave(ibcstate)
           end if
           if(ibcstate.gt.2 .and. ibcstate.lt.7) then
               call parapwave(ibcstate)
           end if
	   ndim=7
c------------------------------------------------------------
c...the following way to generate the mixed events are not
c...appreciable, list here only for completeness of the program.
c...rough idea to achieve such case: adding/reading the total cross-
c...sections for all the states to be mixed, and then select a 
c...particular state to be generate with
c...its corresponding cross-section, and then define a uniform
c...grade for every state.
c------------------------------------------------------------
	   if((.not. usevegas) .and. (.not. usegrade)) then
c...initialize the grade.
             rc=1.0d0/NVEGBIN
             do 77 j=1,ndim
               xi(NVEGBIN,j)=1.0d0
               dr=0.0d0
             do 77 i=1,NVEGBIN-1
               dr=dr+rc
               xi(i,j)=dr
77           continue
             if(ibcstate.eq.7.or.ibcstate.eq.9) ibcstate=1
             if(ibcstate.eq.8.or.ibcstate.eq.10) ibcstate=2
             return
	   end if

c**********************************************************
c**********************************************************
c*** since not using vegas and not using grade has been 
c*** returned, so the following can be introduced without
c*** if conditions.
c**********************************************************
c**********************************************************
	  ifile =0
	  do istate=1,10
        ifile = infile(istate)
	     if(ibcstate.eq.istate) then
             if(ibcstate.eq.7.or.ibcstate.eq.9) ibcstate=1   !1s0 and color-octet
             if(ibcstate.eq.8.or.ibcstate.eq.10) ibcstate=2   !3s1 and color-octet
	         do i=1,NVEGBIN
	           read(ifile,*) (xi(i,j),j=1,7)
	         end do
             do
	           read(ifile,*) pfile
	           if(pfile.eq.'&') exit
	         enddo
	         do i=1,NVEGBIN
	           read(ifile,*) (xmax(i,j),j=1,7)
	         end do
             do
	           read(ifile,*) pfile
	           if(pfile.eq.'+') exit
	         enddo
	         read(ifile,*) vegsec,vegerr,crossmax,si,si2,swgt,schi,itime
	         rewind(ifile)
	         if(unwght) call gen(totfun,ndim,xmax,0)
	      end if
	  end do
	 end
