# GiTil_Compilers
Syntax and Lexical Compiler Analysis University Project

Fundamentals of Programming Languages & Compilers  
Computer Engineering and Informatics Department  
University of Patras  
Spring Semester 2014  

#### Authors: Tilemachos S. Doganis, Georgios Katsandris

The following exercise had the aim of familiarization with the description of a language grammar in Backus-Naur form (BNF), the basic concepts of compilers, and the implementation of two compiler phases: lexical analysis via Flex and syntax analysis via Bison.

---

### Prerequisites
A folder containing all three initial files listed below, Bison, Flex and GCC.

##### The project contains three initial files
message.txt
simple.l
simple.y

##### message.txt 
The request message used as input, adhering to the RFC 2616 HTTP protocol. 

##### simple.l
The input of lexical analyzer Flex. It contains the definitions of the tokens to be identified. The output is the lex.yy.c file.

##### simple.y
The input of syntax analyzer Bison. It contains all the information from the BNF description of the program. Its aim is to identify the token sequence from the flex output and to combine tokens or expressions into higher-level expressions. Its output are the simple.tab.c and simple.tab.h files.

### Command sequence
1. flex simple.l
2. bison -d simple.y
3. g++ simple.tab.c lex.yy.c -lfl -o -simple
4. ./simple.exe message.txt

After running commands 1-3, parser simple.exe is produced. It can be used to parse a request message and point out syntax errors (command 4).

---

##### Below is a list of accepted values for the request message 
```
First message line: GET, HEAD, POST
general-header: Connection, Date, Transfer-Encoding
Transfer-Encoding: chunked, gzip, deflate
Date: dd/mm/yyyy hh:mm
request-header: Accept-Charset, Referer, User-Agent
entity-header: Content-Length, Expires
message-body: Any characters
```
##### Below is the language grammar in BNF
```request-line = rule1 rule2
rule1 = GET | HEAD | POST
rule2 = SP WWW DOT uri DOT word SP HTTP_VERSION VERS ENDL+

general-header = Connection Date Transfer-Encoding ENDL+
Connection = CONNECTION word ENDL+
Date = DATE date SP hourmin ENDL+
Transfer-Encoding = TRANSFER_ENCODING rule_3
rule_3 = CHUNKED | GZIP | DEFLATE

request-header = Accept-Charset Referer User-Agent ENDL
Accept-Charset = ACCEPT_CHARSET any VERS ENDL+
Referer = REFERER HTTP COLON SLASH SLASH WWW DOT uri DOT word uri ENDL+
User-Agent = USER_AGENT word SLASH VERS

entity-header = Content-Length Expires ENDL
Content-Length = CONTENT_LENGTH num ENDL
Expires = EXPIRES SP date SP hourmin

message-body = message-body message-part | message-part
message-part = text | ENDL+
uri = 
	uri word
	| uri num
	| uri uric
	| uri DOT word
	| SLASH uri 
	| uri SLASH
	| word
	| num
	| uric

any = 
	any symb 
	| any num
	| any word
	| any SP
	|symb
	|num
	|word
	| SP
```
---

### References
http://150.140.9.29/arxes_glwsswn/diafaneies.htm  
http://www.w3.org/Protocols/rfc2616/rfc2616.html  
www.capsl.udel.edu/courses/cpeg421/2012/slides/Tutorial-Flex_Bison.pdf  
http://aquamentus.com/flex_bison.html  
