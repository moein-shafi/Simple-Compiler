%{
#include <stdio.h>
extern int yylex(void);
static void yyerror(const char *msg);
%}

%token ID
%token NUM
%token BASIC
%token TRUE
%token FALSE
%token REAL
%token STRING
%token SEMICOLON

%token IF
%token DO
%token WHILE
%token ELSE
%token BREAK

%token OPAR
%token CPAR
%token OBRA
%token CBRA
%token OCUR
%token CCUR

%right ASSIGN
%right NOT
%right MINUS

%left OR
%left AND

%left EQ
%left NEQ
%left LT
%left LTE
%left GT
%left GTE

%left PLUS
%left MULT
%left DIV

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

program :   block                                   { printf("%s\n", "program -> block"); }
        ;
block   :   OBRA decls stmts CBRA                   { printf("%s\n", "block -> {decls stmts}"); }
        ;
decls   :   decls decl                              { printf("%s\n", "decls -> decls decl"); }
        |   ""                                      { printf("%s\n", "decls -> EPSILON"); }
        ;
decl    :   type ID SEMICOLON                       { printf("%s\n", "decl -> type ID SEMICOLON"); }
        ;
type    :   type OCUR NUM CCUR                      { printf("%s\n", "type -> type [NUM]"); }
        |   BASIC                                   { printf("%s\n", "type -> BASIC"); }
        ;
stmts   :   stmts stmt                              { printf("%s\n", "stmts -> stmt"); }
        |   ""
        ;
stmt    :   loc ASSIGN bool SEMICOLON               { printf("%s\n", "stmt -> loc = bool SEMICOLON"); }
        |   IF OPAR bool CPAR stmt                  %prec LOWER_THAN_ELSE { printf("%s\n", "stmt -> IF (bool)"); }
        |   IF OPAR bool CPAR stmt ELSE stmt        { printf("%s\n", "stmt -> IF (bool) stmt ELSE stmt"); }
        |   WHILE OPAR bool CPAR stmt               { printf("%s\n", "stmt -> WHILE (bool) stmt"); }
        |   DO stmt WHILE OPAR bool CPAR SEMICOLON  { printf("%s\n", "stmt -> DO stmt WHILE (bool) SEMICOLON"); }
        |   BREAK SEMICOLON                         { printf("%s\n", "stmt -> BREAK SEMICOLON"); }
        |   block                                   { printf("%s\n", "stmt -> block"); }
        ;
loc     :   loc OCUR bool CCUR                      { printf("%s\n", "loc -> loc [bool]"); }
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
        |   MINUS unary                               { printf("%s\n", "unary -> - unary"); }
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

void yyerror(const char* str)
{
    printf("input error! %s\n", str);
}

int main()
{
    yyparse();
    return 0;
}
