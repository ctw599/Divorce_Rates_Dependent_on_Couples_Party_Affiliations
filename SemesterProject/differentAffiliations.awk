BEGIN{
   FS = "|"
    while ((getline < "oldcleanDataParties.txt") > 0){
       	if ($5 != $8){                                   # check if their affiliations match
	    if($5 ~ /[RD]/ && $8 ~ /[RD]/){              # take into account if one just left it blank and dont list any with parties unlisted
		print $0
	       }
	   }
	else{
	  print $0 > "sameParties.txt"
	}
    }
}
