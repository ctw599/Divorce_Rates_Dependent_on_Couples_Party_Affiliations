
function dataCleanser(new,data_file,   label,ans,i, part_1, first){
    FS = ","
    while((getline < data_file) > 0){
	ans = ""
	for(i = 1; i <= NF; i++){
	    part_1 = match($i, /'[^\']*'/)          # clean each field from junk of previous file and get index
	    first = substr($i, RSTART+1, RLENGTH-2) # clean up more junk and only extract parts of line 
	    if(i == NF){
		ans = ans first
	    }
	    else
		ans = ans first "|"
	}
	print ans
    }
}

BEGIN{
    dataCleanser(ARGV[1], ARGV[2])
}
