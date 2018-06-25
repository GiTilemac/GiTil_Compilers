%{
#include <cstdio> /* For opening / closing files */
#include <iostream> /* For output */
using namespace std;

/* Flex declarations needed for Bison */
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern "C" int line_num;
 
void yyerror(const char *s); /* Declare error handling function */
%}

/* Define the constant - string tokens */
%token GET
%token HEAD
%token POST
%token HTTP_VERSION
%token CONNECTION
%token DATE
%token ENDL
%token TRANSFER_ENCODING
%token ACCEPT_CHARSET
%token REFERER
%token USER_AGENT
%token EXPIRES
%token CONTENT_LENGTH

%token CHUNKED
%token GZIP
%token DEFLATE
%token date
%token hourmin
%token text
%token word
%token COMMA
%token DASH
%token DOT
%token SP
%token COLON
%token SLASH
%token letter
%token digit
%token text_no_dot
%token HTTP
%token WWW
%token symb
%token VERS
%token uric
%token num

 
%start request
%%

request:
	request-line general-header request-header entity-header ENDL message-body
	;
request-line:
	rule1 rule2
	;
rule1:
	GET | HEAD | POST | error
	;
rule2:
	SP WWW DOT uri DOT word SP HTTP_VERSION VERS ENDLS | error
	;
general-header:
	Connection  Date  Transfer-Encoding ENDLS
	;
Connection:
	CONNECTION word ENDLS | error
	;
Date:
	DATE date SP hourmin ENDLS | error
	;
Transfer-Encoding:
	TRANSFER_ENCODING rule_3 | error
rule_3:
	CHUNKED | GZIP | DEFLATE
	;
request-header:
	Accept-Charset  Referer  User-Agent ENDL
	;
Accept-Charset:
	ACCEPT_CHARSET any VERS ENDLS | error
	;
Referer:
	REFERER HTTP COLON SLASH SLASH WWW DOT uri DOT word uri ENDLS | error
	;
User-Agent:
	USER_AGENT word SLASH VERS | error
	;
entity-header:
	Content-Length Expires ENDL
	;
Content-Length:
	CONTENT_LENGTH num ENDL | error
	;
Expires:
	EXPIRES COLON SP date SP hourmin | error
	;
message-body:
	message-body  message-part
	| message-part
	;
message-part:
	word | ENDLS | SP | uric | num | DOT
	;
ENDLS:
	ENDLS ENDL
	| ENDL
	;

uri: 
	uri word
	| uri num
	| uri uric
	| uri DOT word
	| SLASH uri 
	| uri SLASH
	| word
	| num
	| uric
	;
	
any: 
	any symb 
	| any num
	| any word
	| any SP
	|symb
	|num
	|word
	| SP
	;


%%

main(int argc, char **argv)
{
	if(argc == 1) yyparse();
	else
	{
		yyin = fopen(argv[1], "r");
		yyparse();
		fclose(yyin);
	}

}

/* Error output */
void yyerror(const char *s) {
	cout << "Parse error at line " << line_num <<"! Message: " << s << endl;
	
	yyclearin; /* Error recovery to continue parsing */
}