%{
#include "parser.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

INT "int"
BOOL "bool"
FLOAT "float"

ID {alpha}({alpha}|{digit})*
NUM {digit}+
TRUE "true"
FALSE "false"
REAL {digit}+\.({digit}+)
STRING ["][^"]*["]
SEMICOLON ";"

IF "if"
DO "do"
WHILE "while"
ELSE "ELSE"
BREAK "break"

ASSIGN "="
NOT "!"
MINUS "-"
OR "||"
AND "&&"
EQ "=="
NEQ "!="
LT "<"
LTE "<="
GT ">"
GTE ">="
PLUS "+"
MULT "*"
DIV "/"

OPAR "("
CPAR ")"
OBRA "{"
CBRA "}"
OCUR "["
CCUR "]"

%option nounput
%option noyywrap
%option noinput

%%
[ \t]                               {}
[ \n]                               {}
{INT}                               { printf("token found: <basic, \"%s\"> \n", yytext); return(BASIC); }
{BOOL}                              { printf("token found: <basic, \"%s\"> \n", yytext); return(BASIC); }
{FLOAT}                             { printf("token found: <basic, \"%s\"> \n", yytext); return(BASIC); }

{WHILE}                             { printf("token found: <%s> \n", yytext); return(WHILE); }
{DO}                                { printf("token found: <%s> \n", yytext); return(DO); }
{BREAK}                             { printf("token found: <%s> \n", yytext); return(BREAK); }
{IF}                                { printf("token found: <%s> \n", yytext); return(IF); }
{ELSE}                              { printf("token found: <%s> \n", yytext); return(ELSE); }

{TRUE}                              { printf("token found: <%s> \n", yytext); return(TRUE); }
{FALSE}                             { printf("token found: <%s> \n", yytext); return(FALSE); }

{NUM}                               { printf("token found: <num, %s> \n", yytext); return(NUM); }
{REAL}                              { printf("token found: <real, %s> \n", yytext); return(REAL); }
{ID}                                { printf("token found: <id, \"%s\"> \n", yytext); return(ID); }

{STRING}                            { printf("token found: <const, %s> \n", yytext); return(STRING); }

{PLUS}                              { printf("token found: <%s> \n", yytext); return(PLUS); }
{MINUS}                             { printf("token found: <%s> \n", yytext); return(MINUS); }
{MULT}                              { printf("token found: <%s> \n", yytext); return(MULT); }
{DIV}                               { printf("token found: <%s> \n", yytext); return(DIV); }
{OR}                                { printf("token found: <%s> \n", yytext); return(OR); }
{AND}                               { printf("token found: <%s> \n", yytext); return(AND); }
{NOT}                               { printf("token found: <%s> \n", yytext); return(NOT); }

{ASSIGN}                            { printf("token found: <assign> \n"); return(ASSIGN); }
{EQ}                                { printf("token found: <eq> \n"); return(EQ); }
{NEQ}                               { printf("token found: <neq> \n"); return(NEQ); }

{LTE}                               { printf("token found: <\"%s\"> \n", yytext); return(LTE); }
{GTE}                               { printf("token found: <\"%s\"> \n", yytext); return(GTE); }
{GT}                                { printf("token found: <\"%s\"> \n", yytext); return(GT); }
{LT}                                { printf("token found: <\"%s\"> \n", yytext); return(LT); }

{SEMICOLON}                         { printf("token found: <%s> \n", yytext); return(SEMICOLON); }
{OPAR}                              { printf("token found: <%s> \n", yytext); return(OPAR); }
{CPAR}                              { printf("token found: <%s> \n", yytext); return(CPAR); }
{OBRA}                              { printf("token found: <%s> \n", yytext); return(OBRA); }
{CBRA}                              { printf("token found: <%s> \n", yytext); return(CBRA); }
{OCUR}                              { printf("token found: <%s> \n", yytext); return(OCUR); }
{CCUR}                              { printf("token found: <%s> \n", yytext); return(CCUR); }

.                                   { printf("error token <%s>\n", yytext); return(-1); }
%%
