# basically going through all the data and just taking out everybody in a clean way as individuals to check for deaths

function isAlive(file,    cmd){
    FS = ","
    cmd = "zcat "file
    while((cmd|getline) > 0){
	print $4"|"$5"|"$8"|"$11"|"$12 > "stillAlive.txt"
    }
}
BEGIN{
    isAlive(ARGV[1])
}
