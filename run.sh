#!/bin/bash

ii=`awk 'BEGIN {srand(); print int(1 + rand()*10000000);}'`

cat << _EOF > bcvegpy_set_par.nam
 \$bcvegpy_set_par
   ENERGYOFTEVA = 1.96d+3
   ENERGYOFLHC  = 1.30d+4
   naccel       = 2
   i_mix        = 1
   mix_type     = 2
   igenmode     = 2
   istate       = 1
   numofevents  = 2000
   ncall        = 10000
   n_itmx       = 20
   ibcrandom    = ${ii}
 \$End
_EOF

echo Running with ...
cat bcvegpy_set_par.nam

date > run_${ii}.log
cat bcvegpy_set_par.nam >> run_${ii}.log
./run >> run_${ii}.log

mv -v bcvegpy_set_par.nam bcvegpy_set_par_${ii}.nam
mv -v bcvegpy.lhe bcvegpy_${ii}.lhe
gzip -9 run_${ii}.log

echo Done
