function divorced(oldFile, newFile, singlePeopleFile,Diff,     personDiff, oldInfo, personAll, newInfo, oldKey){
    FS="|"

# puts the the different affiliated couples from the old file in a list - the order might switch for new file-take into account
    
    while((getline < oldFile) > 0){
	personDiff[$3$4] = $6$7     # includes name and DOB of spouse - identification
	oldInfo[$3$4] = $1$2$5$8    # includes all other info-address, affiliations, last name
	
    }

# this goes through ALL the married couples in the new data (some couples might have changed affiliations)    
    while ((getline < newFile) > 0){
	personAll[$3$4] = $6$7
	personAll[$6$7] = $3$4
	newInfo[$3$4] = $1$2$5$8
	newInfo[$6$7] = $1$2$5$8
       
    }

# this goes through ALL the data - not just the married couples to take into account death or couples that didnt remarry
    while ((getline < singlePeopleFile) > 0){
	single[$3$2] = 0
    }

    count = 0
    for(key in personDiff){
	count += 1
	if(key in personAll){
	    
	    # couple is still married
	    
	    if(personAll[key] == personDiff[key]){
	      print key, personAll[key] > Diff"IsNotDivorced.txt"
	    }

      	    else{
	     # if the key is not in the married list check ALLPEOPLE list and if NEITHER of the couple died, then they are divorced

		if(personDiff[key] in single){
		    print key, personDiff[key]
		}

            # if either one or both are not in the singles list, then somebody passed away and it is NOT a divorce

		else{
		    print key, personDiff[key] > Diff"SpousePassedAway.txt"      #this is an assumption (maybe one moved out-of-state)
		}
	    
	    }
	}
	else{

	    # if the key is not in the married list check ALLPEOPLE list and if NEITHER of the couple died, then they are divorced

	    if(key in single && personDiff[key] in single){
		print key, personDiff[key]> Diff"PossiblyDivorced.txt"
	    }

	    # if either one or both are not in the singles list, then somebody passed away and it is NOT a divorce

	    else{
		print key, personDiff[key] > Diff"SpousePassedAway.txt"      #this is an assumption (maybe one moved out-of-state)
	    }
	    
	}
       
    }
    print count
}

BEGIN{
    divorced(ARGV[1], ARGV[2], ARGV[3], ARGV[4])
}
	
