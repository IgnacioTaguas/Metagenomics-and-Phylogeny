from ete3 import Tree, TextFace
import sys

seq = open(sys.argv[1])
seq_info = {}

header = seq.readline()

for line in seq.readlines():
    seq_name, gene_name, sp_name, lineage, gene, function = line.replace ('\n', '').split('\t')
    seq_info[seq_name] = [gene_name, sp_name, lineage, gene, function]


tree = Tree(sys.argv[2])
for line in tree:
    if line.name == 'NP_Unk01':
        line.name = ''
        nf = TextFace('NP_Unk01 - Aquifex aeolicus', fsize=10, fgcolor='green')
        line.add_face(nf, column = 0)
    elif line.name == 'NP_Unk02':
        line.name = ''
        nf = TextFace('NP_Unk02 - Aquifex aeolicus', fsize=10, fgcolor='green')
        line.add_face(nf, column=0)
    else:
        gene_name, sp_name, lineage, gene, function = seq_info[line.name]
        if gene_name == 'N/A':
            line.name = str(gene_name+", ("+function+"), "+sp_name+", ("+lineage+")")
        else:
            line.name = str(gene_name+", "+sp_name+", ("+lineage+")")

tree.show()
