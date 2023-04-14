%{
#include <stdio.h>

//Definir los equipos
char* japan[] = {"japan" ,"Kyo Kusanagi", "Benimaru Nikaido", "Goro Daimon"};
char* usa[] = {"usa" ,"Terry Bogard", "Andy Bogard", "Joe Higashi"};
char* china[] = {"china" ,"Chin Gentsai", "Chang Koehan", "Choi Bounge"};
char* brazil[] = {"brazil" ,"Ryo Sakazaki", "Robert Garcia", "Takuma Sakazaki"};
char* korea[] = {"korea" ,"Kim Kaphwan", "Chang Koehan", "Choi Bounge"};
char* italy[] = {"italy" ,"Mai Shiranui", "King", "Yuri Sakazaki"};
char* england[] = {"england" ,"Billy Kane", "Eiji Kisaragi", "Raiden"};
char* mexico[] = {"mexico" ,"Ralf Jones", "Clark Still", "Athena Asamiya"};
char* ikari[] = {"ikari" ,"Leona Heidern", "Ralf Jones", "Clark Still"};

char equipos[2][4];
int num_equipos = 0;


%}
%%

"japan" {
  for(int i = 0; i < 4; i++) {
    equipos[num_equipos++][i] = japan[i];
}
"usa" {
  for(int i = 0; i < 4; i++) {
    equipos[num_equipos++][i] = usa[i];
}



("A")  { printf("Weak Punch: %s\n", yytext); }
("B")  { printf("Weak Kick: %s\n", yytext); }
("C")  { printf("Strong Punch: %s\n", yytext); }
("D")  { printf("Strong Kick: %s\n", yytext); }
("A,B,C")+  { printf("Charge POW meter: %s\n", yytext); }
("A,B")+  { printf("Dodge: %s\n", yytext); }
("C,D")  { printf("Knockdown attack: %s\n", yytext); }
("ub")  { printf("Jumps backwards: %s\n", yytext); }
("u")  { printf("Jumps straight up: %s\n", yytext); }
("uf")  { printf("Jumps forwards: %s\n", yytext); }
("f")+  { printf("Walks forward: %s\n", yytext); }
("df")  { printf("Duckwalks: %s\n", yytext); }
("d")+  { printf("Crouches: %s\n", yytext); }
("db")  { printf("Blocks low-standing: %s\n", yytext); }
("b")+  { printf("Blocks standing-jump: %s\n", yytext); }
("~")+  { printf("Hold direction: %s\n", yytext); }
(b|f)\+C  { printf("HThrow or Grab: %s\n", yytext); }
("f+f")+  { printf("Dash forward: %s\n", yytext); }
("b+b")+  { printf("Dash backward: %s\n", yytext); }
f\+(A|B)  { printf("Defensive attack: %s\n", yytext); }

f\+D  { printf("Ge Shiki Gou Fu You: %s\n", yytext); }
(u|ub|uf)\+d\+C  { printf("Ge Shiki Naraku Otoshi: %s\n", yytext); }
(d,df,f)\+(A|C)  { printf("108 Shiki Yami Barai: %s\n", yytext); }
(f,d,df)\+(A|C)  { printf("100 Shiki Oni Yaki: %s\n", yytext); }
(b,d,db)\+(B|D)  { printf("101 Shiki Oboro Guruma: %s\n", yytext); }
(d,db,b,db,d,df,f)\+C  { printf("Ura 108 Shiki Orochi Nagi: %s\n", yytext); }

(u|ub|uf)\+(b|f|d)\+D { printf("Yume Zakura: %s\n", yytext); }
(d,df,f)\+(A|C)  { printf("Ka Cho Sen: %s\n", yytext); }
(d,db,b)\+(A|C)  { printf("Ryu En Bu: %s\n", yytext); }
(d,~,u)\+C  { printf("Musasabi no Mai: %s\n", yytext); }
(b,db,d,df,f)\+(B|D)  { printf("Hissatsu Shinobibachi: %s\n", yytext); }
(f,db,f)\+B\+C  { printf("Cho Hissatsu Shinobibachi: %s\n", yytext); }

.          { /* Ignorar todos los demás caracteres */ }
%%


int yywrap(){}
int main(int argc, char** argv) {
  FILE* archivo = fopen(argv[1], "r");

  if (archivo == NULL) {
    printf("Error al abrir el archivo.\n");
    return 1;
  }

  int c;  
  char linea[100];

  while (fgets(linea, 100, archivo) != NULL) {
    yy_scan_string(linea);
    yylex();
  }

  for (int i = 0; i < num_equipos; i++) {
      printf("Equipo: "equipos[i][0]);
      for (int j = 1; j < 4; j++) {
          printf("- %s\n", equipos[i][j]);
      }
  }

  fclose(archivo);

  return 0;
}