# Makefile

FLAGS := -g
CC := gcc

parser: parser.tab.o lex.o
	$(CC) $(FLAGS) lex.o parser.tab.o -o parser

parser.tab.o: parser.tab.c
	$(CC) $(FLAGS) -c parser.tab.c -o parser.tab.o

lex.o: lex.yy.c
	$(CC) $(FLAGS) -c lex.yy.c -o lex.o

lex.yy.c: parser.l
	flex parser.l

parser.tab.c: parser.y
	bison -d parser.y

clean:
	rm -f *.h *.c *.o parser
