%{
#include <stdio.h>
#include <math.h>
#include <errno.h>
#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <llvm-c/Core.h>
//#include "astnode.h"
//#include "codegen.h"

extern int yylex(void);
extern FILE *yyin;

static void yyerror(const char *msg);
static char *outfile;
static int failed = 0;
%}

%token ID NUM BASIC TRUE FALSE REAL STRING SEMICOLON
%token IF DO WHILE ELSE BREAK
%token OPAR CPAR OBRA CBRA OCUR CCUR

%right ASSIGN
%right NOT UNARY_MINUS
%left OR
%left AND
%left EQ NEQ
%left LT LTE GT GTE
%left MINUS PLUS
%left MULT DIV

%start program

%%

program :   block                                   { printf("%s\n", "program -> block"); }
        ;
block   :   OBRA decls stmts CBRA                   { printf("%s\n", "block -> {decls stmts}"); }
        ;
decls   :   decls decl                              { printf("%s\n", "decls -> decls decl"); }
        |   "\n"
        ;
decl    :   type ID SEMICOLON                       { printf("%s\n", "decl -> type ID SEMICOLON"); }
        ;
type    :   type OCUR NUM CCUR                      { printf("%s\n", "type -> type [NUM]"); }
        |   BASIC                                   { printf("%s\n", "type -> BASIC"); }
        ;
stmts   :   stmts stmt                              { printf("%s\n", "stmts -> stmt"); }
        |   "\n"
        ;
stmt    :   loc ASSIGN bool SEMICOLON               { printf("%s\n", "stmt -> loc = bool SEMICOLON"); }
        |   IF OPAR bool CPAR stmt                  { printf("%s\n", "stmt -> IF (bool)"); }
        |   IF OPAR bool CPAR stmt ELSE stmt        { printf("%s\n", "stmt -> IF (bool) stmt ELSE stmt"); }
        |   WHILE OPAR bool CPAR stmt               { printf("%s\n", "stmt -> WHILE (bool) stmt"); }
        |   DO stmt WHILE OPAR bool CPAR SEMICOLON  { printf("%s\n", "stmt -> DO stmt WHILE (bool) SEMICOLON"); }
        |   BREAK SEMICOLON                         { printf("%s\n", "stmt -> BREAK SEMICOLON"); }
        |   block                                   { printf("%s\n", "stmt -> block"); }
        ;
loc     :   loc OCUR bool CCUR                        { printf("%s\n", "loc -> loc [bool]"); }
        |   ID                                      { printf("%s\n", "loc -> ID"); }
        ;
bool    :   bool OR join                            { printf("%s\n", "bool -> bool || join"); }
        |   join                                    { printf("%s\n", "bool -> join"); }
        ;
join    :   join AND equality                       { printf("%s\n", "join -> equality"); }
        |   equality                                { printf("%s\n", "join -> equality"); }
        ;
equality:   equality EQ rel                         { printf("%s\n", "equality -> equality == rel"); }
        |   equality NEQ rel                        { printf("%s\n", "equality -> equality != rel"); }
        |   rel                                     { printf("%s\n", "equality -> rel"); }
        ;
rel     :   expr LT expr                            { printf("%s\n", "rel -> expr < expr"); }
        |   expr LTE expr                           { printf("%s\n", "rel -> expr <= expr"); }
        |   expr GTE expr                           { printf("%s\n", "rel -> expr >= expr"); }
        |   expr GT expr                            { printf("%s\n", "rel -> expr > expr"); }
        |   expr                                    { printf("%s\n", "rel -> expr"); }
        ;
expr    :   expr PLUS term                          { printf("%s\n", "expr -> expr + term"); }
        |   expr MINUS term                         { printf("%s\n", "expr -> expr - term"); }
        |   term                                    { printf("%s\n", "expr -> term"); }
        ;
term    :   term MULT unary                         { printf("%s\n", "term -> term * unary"); }
        |   term DIV unary                          { printf("%s\n", "term -> term / unary"); }
        |   unary                                   { printf("%s\n", "term -> unary"); }
        ;
unary   :   DIV unary                               { printf("%s\n", "unary -> ! unary"); }
        |   UNARY_MINUS unary                               { printf("%s\n", "unary -> - unary"); }
        |   factor                                  { printf("%s\n", "unary -> factor"); }
        ;
factor  :   OPAR bool CPAR                          { printf("%s\n", "factor -> (bool)"); }
        |   loc                                     { printf("%s\n", "factor -> loc"); }
        |   NUM                                     { printf("%s\n", "factor -> NUM"); }
        |   REAL                                    { printf("%s\n", "factor -> REAL"); }
        |   TRUE                                    { printf("%s\n", "factor -> TRUE"); }
        |   FALSE                                   { printf("%s\n", "factor -> FALSE"); }
        ;

%%

#include "lex.yy.c"


void yyerror(const char* str)
{
    printf("input error! %s", str);
}


int main(int argc, char* *argv)
{
    char* progname;
    progname = basename(argv[0]);
    if (argc != 3)
    {
        printf("not this way!\n");
        exit(EXIT_FAILURE);
    }
    yyin = fopen(argv[1], "r");

    if (!yyin)
    {
        printf("open file failed!\n");
        exit(EXIT_FAILURE);
    }
    outfile = argv[2];
    return yyparse();
}
