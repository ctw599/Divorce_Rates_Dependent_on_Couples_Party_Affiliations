BEGIN{
   FS = "|"
    while ((getline < "oldcleanDataParties.txt") > 0){
       	if ($5 != $8){                                   # check if their affiliations match
	    if($5 ~ /[RD]/ && $8 ~ /[RD]/){              # take into account if one just left it blank
		print $0 > "differentParties.txt"
	       }
	   }
	else{
	  print $0
	}
    }
}
