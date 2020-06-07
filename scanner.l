%{
#include <stdlib.h>
#include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

ID {alpha}({alpha}|{digit})* 
NUM {digit}+ 
BASIC "int" | "bool" | "float"
TRUE "true"
FALSE "false"
REAL {digit}+\.({digit}+) 
STRING ["][^"]*["] | ['][^']*['] 
SEMICOLON ";"

IF "if"
DO "do"
WHILE "while"
ELSE "ELSE"
BREAK "break"


%option noyywrap

%%
[ \t]                               {}
[ \n]                               {}
BASIC                               { printf("<basic, \"%s\"> ", yytext); }

WHILE                               { printf("<%s> ", yytext); }
DO                                  { printf("<%s> ", yytext); }
BREAK                               { printf("<%s> ", yytext); }
IF                                  { printf("<%s> ", yytext); }
ELSE                                { printf("<%s> ", yytext); }

TRUE                                { printf("<%s> ", yytext); }
FALSE                               { printf("<%s> ", yytext); }

NUM                                 { printf("<num, %s> ", yytext); }
REAL                                { printf("<real, %s> ", yytext); }
ID                                  { printf("<id, \"%s\"> ", yytext); }

STRING                              { printf("<const, %s> ", yytext); }

"+"                                 { printf("<%s> ", yytext); }
"-"                                 { printf("<%s> ", yytext); }
"*"                                 { printf("<%s> ", yytext); }
"/"                                 { printf("<%s> ", yytext); }
"||"                                { printf("<%s> ", yytext); }
"&&"                                { printf("<%s> ", yytext); }
"!"                                 { printf("<%s> ", yytext); }

"="                                 { printf("<assign> "); }
"=="                                { printf("<eq> "); }
"!="                                { printf("<neq> "); }

"<="                                { printf("<\"%s\"> ", yytext); }
">="                                { printf("<\"%s\"> ", yytext); }
">"                                 { printf("<\"%s\"> ", yytext); }
"<"                                 { printf("<\"%s\"> ", yytext); }

";"                                 { printf("<%s> ", yytext); }
"("                                 { printf("<%s> ", yytext); }
")"                                 { printf("<%s> ", yytext); }
"{"                                 { printf("<%s> ", yytext); }
"}"                                 { printf("<%s> ", yytext); }
"["                                 { printf("<%s> ", yytext); }
"]"                                 { printf("<%s> ", yytext); }

.                                   { printf("error token <%s>\n", yytext);  }
%%

int main()
{
    yylex();
    return 0;
}
