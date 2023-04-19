# starpipe


# make fifo pipes for input and output

mkfifo /tmp/r1
mkfifo /tmp/r0

# Create STAR service that listens to r1 and writes to r0

while : ; do     STAR --runThreadN 8 --genomeDir /data/processed/genomes/homo-sapiens-96/indexes/star-2.5.1b --readFilesIn /tmp/r1 --genomeLoad LoadAndKeep --runMode alignReads --outStd SAM --outFilterMismatchNoverLmax 0 --outFilterMatchNmin 10 | grep -v "^@SQ" | grep -v "@HD" | grep  -v "@PG" > /tmp/r0 && echo .; done

# pass file to STAR appliance

cat 1.fastq >/tmp/r1

# read output PIPE

cat <> /tmp/r0
