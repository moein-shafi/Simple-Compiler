%{
#include <stdlib.h>
#include <string.h>
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

ASSIGN "="
NOT "!"
UNARY_MINUS "-"
OR "||"
AND "&&"
EQ "=="
NEQ "!="
LT "<"
LTE "<="
GT ">"
GTE ">="
MINUS "-"
PLUS "+"
MULT "*"
DIV "/"

OPAR "("
CPAR ")"
OBRA "{"
CBRA "}"
OCUR "["
CCUR "]"

%option yylineno
%option noyywrap
%option nounput

%%
[ \t]                               {}
[ \n]                               {}
BASIC                               { printf("token found: <basic, \"%s\"> ", yytext); return(BASIC); }

WHILE                               { printf("token found: <%s> ", yytext); return(WHILE); }
DO                                  { printf("token found: <%s> ", yytext); return(DO); }
BREAK                               { printf("token found: <%s> ", yytext); return(BREAK); }
IF                                  { printf("token found: <%s> ", yytext); return(IF); }
ELSE                                { printf("token found: <%s> ", yytext); return(ELSE); }

TRUE                                { printf("token found: <%s> ", yytext); return(TRUE); }
FALSE                               { printf("token found: <%s> ", yytext); return(FALSE); }

NUM                                 { printf("token found: <num, %s> ", yytext); return(NUM); }
REAL                                { printf("token found: <real, %s> ", yytext); return(REAL); }
ID                                  { printf("token found: <id, \"%s\"> ", yytext); return(ID); }

STRING                              { printf("token found: <const, %s> ", yytext); return(STRING); }

PLUS                                { printf("token found: <%s> ", yytext); return(PLUS); }
MINUS                               { printf("token found: <%s> ", yytext); return(MINUS); }
UNARY_MINUS                         { printf("token found: <%s> ", yytext); return(UNARY_MINUS); }
MULT                                { printf("token found: <%s> ", yytext); return(MULT); }
DIV                                 { printf("token found: <%s> ", yytext); return(DIV); }
OR                                  { printf("token found: <%s> ", yytext); return(OR); }
AND                                 { printf("token found: <%s> ", yytext); return(AND); }
NOT                                 { printf("token found: <%s> ", yytext); return(NOT); }

ASSIGN                              { printf("token found: <assign> "); return(ASSIGN); }
EQ                                  { printf("token found: <eq> "); return(EQ); }
NEQ                                 { printf("token found: <neq> "); return(NEQ); }

LTE                                 { printf("token found: <\"%s\"> ", yytext); return(LTE); }
GTE                                 { printf("token found: <\"%s\"> ", yytext); return(GTE); }
GT                                  { printf("token found: <\"%s\"> ", yytext); return(GT); }
LT                                  { printf("token found: <\"%s\"> ", yytext); return(LT); }

SEMICOLON                           { printf("token found: <%s> ", yytext); return(SEMICOLON); }
OPAR                                { printf("token found: <%s> ", yytext); return(OPAR); }
CPAR                                { printf("token found: <%s> ", yytext); return(CPAR); }
OBRA                                { printf("token found: <%s> ", yytext); return(OBRA); }
CBRA                                { printf("token found: <%s> ", yytext); return(CBRA); }
OCUR                                { printf("token found: <%s> ", yytext); return(OCUR); }
CCUR                                { printf("token found: <%s> ", yytext); return(CCUR); }

.                                   { printf("error token <%s>\n", yytext); return(-1); }
%%

/*
int main()
{
    yylex();
    return 0;
}
*/
