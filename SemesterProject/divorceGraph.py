import matplotlib
import matplotlib.pyplot as plt
import numpy as np

samePartiesMarried = 0
differentPartiesMarried = 0
samePartiesDivorced = 0
differentPartiesDivorced = 0
with open("sameParties.txt","r") as f:
    samePartiesMarried = len(f.readlines())

with open("differentParties.txt","r") as q:
    differentPartiesMarried = len(q.readlines())

with open("SamePossiblyDivorced.txt","r") as g:
    samePartiesDivorced = len(g.readlines())

with open("DiffPossiblyDivorced.txt","r") as p:
    differentPartiesDivorced = len(p.readlines())

labels = ['Same Party Affiliations', 'Different Party Affiliations']
marriages = [samePartiesMarried, differentPartiesMarried]
divorces = [samePartiesDivorced, differentPartiesDivorced]

x = np.arange(len(labels))
width = 0.35

fig, ax = plt.subplots()
rects1 = ax.bar(x - width/2, marriages, width, label = "Marriages")
rects2 = ax.bar(x + width/2, divorces, width, label = "Divorces")

ax.set_ylabel('Number of Couples')
ax.set_title('Divorce Rates depending on Couples Party Affiliations')
ax.set_xticks(x)
ax.set_xticklabels(labels)
ax.legend()

def autolabel(rects):
    for rect in rects:
        height = rect.get_height()
        ax.annotate('{}'.format(height),
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0,3),
                    textcoords="offset points",
                    ha='center', va='bottom')
autolabel(rects1)
autolabel(rects2)

fig.tight_layout()
#data = [[samePartiesMarried, differentPartiesMarried],[samePartiesDivorced, differentPartiesDivorced]]
#X = np.arange(2)
#fig = plt.figure()
#ax = fig.add_axes([0,0,1,1])
#ax.bar(X+0.00, data[0], color = 'b', width = 0.5, label='Marriages')
#ax.bar(X+0.5, data[1], color = 'g', width = 0.5, label='Divorces')
#ax.legend(labels=['Marriages', 'Divorces'])
#ax.set_ylabel('Number Couples')
#ax.set_xticks(X)
#ax.set_xticklabels(labels)
plt.savefig("plotsForProject.pdf")
