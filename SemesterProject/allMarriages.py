import pyspark
import sys

def getVoters(line):                                 # extracts data about the voters
    fields = line.split(",")
    key = fields[3]+"|"+fields[11]                   # voters last name and address
    data = fields[7]+"|"+fields[4]+"|"+fields[10]    # voters DOB, first name, party affiliation
    return key, (data,1)                             # the key is the last name and address as this is what the couples will have
                                                     # in common


def age(x, y):
    try: year1 = int(x[0][1:5])                      # extracting the years both people were born to check if their ages 
    except: year1 = 0                                # are appropriate for marriage
    try: year2 = int(y[0][1:5])
    except: year2 = 0
    if -15 <= (year1 - year2) <= 15:
        return (x[0],y[0]), x[1]+y[1]                # returns data and the number 2 if married, else, just returns 0
    else:
        return (x[0],y[0]), 0


sc        = pyspark.SparkContext()
text_file = sc.textFile(sys.argv[1])
voters_data = text_file.map(getVoters).distinct()
areMarried = voters_data.reduceByKey(age)            # checks if the couple is married by a key of last name,address and checks
married = areMarried.filter(lambda x: x[1][1] == 2)  # filters out only married couples
married_strip = married.map(lambda x: (x[0],x[1][0]))# maps the last name, address, party affiliation, first name and DOB 
married_strip.saveAsTextFile(sys.argv[2])            # saves text
print(len(sys.argv))



