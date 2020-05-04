rule all:
	input:
		'boby.count' , 'cindy.count'



rule alignment:
	input: 
		'test_{sample}.fq'
	output:
		temp('{sample}.sam')
	shell: 
		'bwa mem genome.fa {input} > {output} 2> /dev/null'

rule sam2bam:
	input:
		'{sample}.sam'
	output:
		'{sample}.bam'
	log:
		'{sample}.sam2bam'
	shell:
		'samtools view -bS  {input} > {output} 2> {log}' 

rule countbam:
	input:
		'{sample}.bam'
	output:
		'{sample}.count'
	shell:
		"samtools view  {input} | cut -f4 | sort | uniq -c | awk '{{print $2,$1}}' > {output}"

