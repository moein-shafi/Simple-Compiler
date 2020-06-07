%{
#include <stdio.h>
#include <math.h>
%}

%token ID NUM BASIC TRUE FALSE REAL STRING SEMICOLON
%token IF DO WHILE ELSE BREAK

%right '='
%right '!' '-'
%left '||'
%left '&&'
%left '==' '!='
%left '<' '<=' '>' '>='
%left '-' '+'
%left '*' '/'

%start program

%%

program :   block                                   { printf("%s\n", "program -> block"); }
        ;
block   :   '{' decls stmts '}'                     { printf("%s\n", "block -> {decls stmts}"); }
        ;
decls   :   decls decl                              { printf("%s\n", "decls -> decls decl"); }
        |   '\n'
        ;
decl    :   type ID SEMICOLON                       { printf("%s\n", "decl -> type ID SEMICOLON"); }
        ;
type    :   type '[' NUM ']'                        { printf("%s\n", "type -> type [NUM]"); }
        |   BASIC                                   { printf("%s\n", "type -> BASIC"); }
        ;
stmts   :   stmts stmt                              { printf("%s\n", "stmts -> stmt"); }
        |   '\n'
        ;
stmt    :   loc '=' bool SEMICOLON                  { printf("%s\n", "stmt -> loc = bool SEMICOLON"); }
        |   IF '(' bool ')' stmt                    { printf("%s\n", "stmt -> IF (bool)"); }
        |   IF '(' bool ')' stmt ELSE stmt          { printf("%s\n", "stmt -> IF (bool) stmt ELSE stmt"); }
        |   WHILE '(' bool ')' stmt                 { printf("%s\n", "stmt -> WHILE (bool) stmt"); }
        |   DO stmt WHILE '(' bool ')' SEMICOLON    { printf("%s\n", "stmt -> DO stmt WHILE (bool) SEMICOLON"); }
        |   BREAK SEMICOLON                         { printf("%s\n", "stmt -> BREAK SEMICOLON"); }
        |   block                                   { printf("%s\n", "stmt -> block"); }
        ;
loc     :   loc '[' bool ']'                        { printf("%s\n", "loc -> loc [bool]"); }
        |   ID                                      { printf("%s\n", "loc -> ID"); }
        ;
bool    :   bool '||' join                          { printf("%s\n", "bool -> bool || join"); }
        |   join                                    { printf("%s\n", "bool -> join"); }
        ;
join    :   join '&&' equality                      { printf("%s\n", "join -> equality"); }
        |   equality                                { printf("%s\n", "join -> equality"); }
        ;
equality:   equality '==' rel                       { printf("%s\n", "equality -> equality == rel"); }
        |   equality '!=' rel                       { printf("%s\n", "equality -> equality != rel"); }
        |   rel                                     { printf("%s\n", "equality -> rel"); }
        ;
rel     :   expr '<' expr                           { printf("%s\n", "rel -> expr < expr"); }
        |   expr '<=' expr                          { printf("%s\n", "rel -> expr <= expr"); }
        |   expr '>=' expr                          { printf("%s\n", "rel -> expr >= expr"); }
        |   expr '>' expr                           { printf("%s\n", "rel -> expr > expr"); }
        |   expr                                    { printf("%s\n", "rel -> expr"); }
        ;
expr    :   expr '+' term                           { printf("%s\n", "expr -> expr + term"); }
        |   expr '-' term                           { printf("%s\n", "expr -> expr - term"); }
        |   term                                    { printf("%s\n", "expr -> term"); }
        ;
term    :   term '*' unary                          { printf("%s\n", "term -> term * unary"); }
        |   term '/' unary                          { printf("%s\n", "term -> term / unary"); }
        |   unary                                   { printf("%s\n", "term -> unary"); }
        ;
unary   :   '!' unary                               { printf("%s\n", "unary -> ! unary"); }
        |   '-' unary                               { printf("%s\n", "unary -> - unary"); }
        |   factor                                  { printf("%s\n", "unary -> factor"); }
        ;
factor  :   '(' bool ')'                            { printf("%s\n", "factor -> (bool)"); }
        |   loc                                     { printf("%s\n", "factor -> loc"); }
        |   NUM                                     { printf("%s\n", "factor -> NUM"); }
        |   REAL                                    { printf("%s\n", "factor -> REAL"); }
        |   TRUE                                    { printf("%s\n", "factor -> TRUE"); }
        |   FALSE                                   { printf("%s\n", "factor -> FALSE"); }
        ;

%%

#include "lex.yy.c"

yyerror()
{
    printf("input error!");
}

int main()
{
    yyparse();
    return 0;
}
