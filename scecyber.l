/****************************************
	 Lex program to check whether the document is based on certain topic or not
*****************************************/

%{
	int nkeywords = 0, nwords = 0;
	float percent;
%}


KEYWORDS		cybersecurity|internet|data|threat|protect|access|computer|cyber|unauthorized|attack|security|server|network|mobile|device|malice|malicious|delete|extort|sensitive|vital|personal|download|upload|secur|remote|critical|vulnerable|mail|email|privacy|info|information|breach|target|virus|phish|ransomware|guard|prevent|malware|harm|worm|trojan|spyware|lock|encrypt|decrypt|break|fraud|steal|password|recovery|risk|dangerous|website|web|www|http|ssl|hack|vulnerab|detect|infect|cisco|mcafee|redhat|rhel|cloud|iot|darkweb|honeypot|sql|Injection|response|browser|secur|data|root|npav|antivirus|ctf|software|domain|vpn|mac|address|ip|exploit|breach|firewall|bot|ddos|dos|pentest|clickjack|deepfake|blacklist|backup|recaptcha|captcha|adware|keylog
WORDS			[a-zA-Z]+
NUMBERS			[0-9]+
PUNCTUATION		[ \t \n () , \- . \' \" : ? ! ; \$ % \|]+

%option noyywrap
%option caseless


%%


{KEYWORDS}[a-zA-Z\-]*	{ nkeywords++; nwords++; }
{WORDS}					{ ECHO; nwords++; printf(" "); }
{NUMBERS}				{ ECHO; nwords++; printf(" "); }
{PUNCTUATION}			{  }


%%


int main() 
{
	char filename[50];
	printf("\nEnter the filename : ");
	scanf("%s", filename);
	
	yyin = fopen(filename,"r");		//FILE *yyin
	
	yylex();
	
	percent = (float)nkeywords/nwords * 100;
	printf("\nKeywords : %d\nWords    : %d\n", nkeywords, nwords);
	printf("\nPercentage of \"Cyber Security\" related Keywords in the document : %f\n", percent);
	
	if(percent > 10) {
		printf("\nThe Document is surely related to \"Cyber Security\".\n");
	}
	else if(percent > 6) {
		printf("\nThe Document may be related to \"Cyber Security\".\n");
	}
	else if(percent > 3) {
		printf("\nThe Document may not be related to \"Cyber Security\".\n");
	}
	else {
		printf("\nThe Document is not related to \"Cyber Security\".\n");
	}
			
	return 0;
}

