%{
/* include iostream for cout */
#include <iostream>
using namespace std;

/* Allow the use of C in C++ */
#define YY_DECL extern "C" int yylex()

/* Store line number for error output */
int line_num=1;

/* Include Bison parser skeleton
#include "simple.tab.h" 
%}
COMMA	","
DASH	"-"
text_no_dot [^.]+
uric "-" |  ":" | ";" | "," | "_" | "?" | "=" | "(" | ")" | "$" | "#" | "@" | "!" | "%" | "^" | "&" | "*" | "." | "/"
%%

\n		{ ++line_num;
		 return ENDL;}	

"GET"				{  cout<<"GET "<<endl; return GET; }
"POST"				{  cout<<"POST "<<endl;return POST; }
"HEAD"				{  cout<<"HEAD "<<endl;return HEAD; }
"HTTP/" { cout<<"HTTP_VERSION "<<endl;return HTTP_VERSION; }
"Connection: "		{ cout<<"CONNECTION "<<endl;return CONNECTION; }
"Date: "			{ cout<<"DATE "<<endl;return DATE; }
"Transfer-Encoding: " { cout<<"TRANSFER_ENCODING "<<endl;return TRANSFER_ENCODING; }
"Accept-Charset: "  { cout<<"ACCEPT_CHARSET "<<endl;return ACCEPT_CHARSET; }
"Content-Length: "  { cout<<"CONTENT_LENGTH "<<endl;return CONTENT_LENGTH; }
"Referer: "			{ cout<<"REFERER "<<endl;return REFERER; }
"User-Agent: "		{ cout<<"USER_AGENT "<<endl;return USER_AGENT; }
"Expires"/": "			{ cout<<endl<<"EXPIRES "<<endl;return EXPIRES; }
"chunked"			{ cout<<"CHUNKED"<<endl;return CHUNKED; }
"gzip"				{ cout<<"GZIP"<<endl;return GZIP; }
"deflate"			{ cout<<"DEFLATE"<<endl;return DEFLATE; }
"http"				{ cout<<"http "<<endl; return HTTP; }
"www"				{ cout<<"www"<<endl; return WWW; }
":"					{ cout<<"COLON"<<endl; return COLON; }
"."					{ cout<<" DOT "<<endl; return DOT;}
"/"					{ cout<<" SLASH "<<endl; return SLASH;}
" "					{cout<<" space "<<endl; return SP;}

[0-9]"."[0-9]		{cout<<"vers"; return VERS;}
[0-9][0-9]"/"[0-9][0-9]"/"[0-9][0-9][0-9][0-9] {cout<<"date";return date;}
[0-9][0-9]":"[0-9][0-9]							{cout<<"hourmin";return hourmin;}

[0-9]+ {cout<<"num"; return num;}
"-" | "/" | ":" | ";" | "," | "_" | "." | "=" | "(" | ")" {cout<<"symbol";return symb;}
[A-Za-z]+		{cout<<"word"; return word;}
	

%%
