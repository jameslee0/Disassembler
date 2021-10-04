%{
  /* Definition section */
  #include <stdio.h>
  #include <stdlib.h>
  #include "parser.tab.h"

/* Flex functions */
extern int yylex(void);
extern void yyterminate();
void yyerror(const char *s);
extern FILE* yyin;
int lineNum = 0;


%}

%token DIGIT CHAR EOL ADD SUB MUL DIV SEMI EQUAL LEFT RIGHT MODULUS
%token INVALID

%%

LINES: LINE
     | LINES LINE
;

LINE : EOL { lineNum++; }
     | T EOL
     {
       lineNum++;
         printf("Good (valid) Statement at line num %d\n", lineNum);
     }
     | error EOL {yyerrok;}
;


T : EXPRESSION
	| ID EQUAL EXPRESSION SEMI {$$ = $3;}
;

EXPRESSION : TERM
	| EXPRESSION ADD TERM {$$ = $1 + $3;}
	| EXPRESSION SUB TERM {$$ = $1 - $3;}
	| EXPRESSION MUL TERM {$$ = $1 * $3;}
	| EXPRESSION DIV TERM {$$ = $1 / $3;}
	| LEFT EXPRESSION RIGHT {$$ = $2;}
	| EXPRESSION MODULUS TERM {$$ = $1 % $3;}
;

TERM: ID
	| LEFT EXPRESSION RIGHT {$$ = $2;}
;

ID : CHAR
   | ID DIGIT
   | ID CHAR
;

%%

int main(int argc, char* argv[])
{
  yyin = fopen(argv[1], "r");
  if (!yyin) {
    printf("ERROR: Couldn't open file %s\n", argv[1]);
          exit(-1);
  }
  yyparse();
}

void yyerror(const char* str)
{
 lineNum++;
 printf("Bad (invalid) Statement at line num %d\n", lineNum);
}