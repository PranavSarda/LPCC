/****************************************
	 Lex program to check whether the document is based on certain topic or not
*****************************************/

%{
	int nkeywords = 0, nwords = 0;
	float percent;
%}


KEYWORDS		cricket|bat|ball|stump|out|bowler|batsman|batsmen|batswoman|batswomen|umpire|wicket|bails|pitch|fielder|fielding|catch|boundary|four|six|t20|oneday|match|player
WORDS			[a-zA-Z]+
NUMBERS			[0-9]+
PUNCTUATION		[ \t\n\-(),.\'\"]+

%option noyywrap
%option caseless


%%


{KEYWORDS}		{ nkeywords++; nwords++; }
{WORDS}			{ nwords++; }
{NUMBERS}		{ nwords++; }
{PUNCTUATION}	{  }


%%


int main() 
{
	yyin = fopen("cricketinput.txt","r");		//FILE *yyin
	
	yylex();
	
	percent = (float)nkeywords/nwords * 100;
	printf("\nKeywords : %d\nWords    : %d\n", nkeywords, nwords);
	printf("\nPercentage of \"Cricket\" related Keywords in the document : %f\n", percent);
	
	if(percent > 15) {
		printf("\nThe Document is surely related to \"Cricket\".\n");
	}
	else if(percent > 8) {
		printf("\nThe Document may be related to \"Cricket\".\n");
	}
	else if(percent > 4) {
		printf("\nThe Document may not be related to \"Cricket\".\n");
	}
	else {
		printf("\nThe Document is not related to \"Cricket\".\n");
	}
		
	return 0;
}
