%{
  #include <stdio.h>
  #include "parser.tab.h"
  extern int yylval;

%}

%option noyywrap

%%

[+] {return ADD;}
[-] {return SUB;}
[*] {return MUL;}
[/] {return DIV;}
[;] {return SEMI;}
[=] {return EQUAL;}
[(] {return LEFT;}
[)] {return RIGHT;}
[%] {return MODULUS;}

[0-9] {yylval = atoi(yytext); return DIGIT; }
[a-zA-Z] { return CHAR; }
\n       { return EOL; }
[ \t] ;

.        { return INVALID; }
%%