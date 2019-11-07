//kortspil
String[] kulor    = {"hjerter", "klor", "ruder", "spar"};
String[] vaerdi   ={"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "D", "K"};
String[] kortSpil = new String[52];

//Spiller
String[] spillerKort=new String[52];

//hus
String[] husKort=new String[52];

//variabler
int traek=2;
int spillerSum;
int husSum;
int husK;

void setup() {
  size(1600, 800);
  background(142,10,10);
  textSize(30);
  //intro tekst
  textAlign(CENTER);
  text("Tryk på R for at starte et nyt spil    Tryk på D for at trækkke    Tryk på E for at stoppe", width/2, height/2);
}

void draw() {
}

//hvis der trykkes på en knap
void keyPressed() {
  //ved tryk på d
  if (key=='d') {
    //spillekortet i arrayet med pladsen traek får tildelt et kort
    spillerKort[traek]=tilfaeldigKort();
    //spillersum opdateres
    spillerSum+=hvorMangePoint(spillerKort[traek]);
    //spillerkortet tegnes hvor kortet placeres på den nederste tredjsedel af skærmen
    tegnKort(spillerKort[traek], traek, 2);

    //der lægges en til traek
    traek+=1;
  }
  //hvis der trykkes på e
  if (key=='e') {
    //for loop der kører når den er mindre end m
    for (int m=1; m<husK; m++) {
      //de resterende af husets kort tegnes på den øverste del af skærmen
      tegnKort(husKort[m], m, 0);
    }
    //tekst der viser resultatet
    textSize(100);
    textAlign(CENTER);
    text(vinder(spillerSum, husSum), width/2, height/2);
    point();
  }
  //hvis der trykkes på r
  if (key=='r') {
    //Kortspil laves
    lavKortSpil();
    //Baggrundsfarve
    background(142,10,10);

    //variablerne sættes til standardværdierne
    spillerKort=new String[52];
    husKort=new String[52];

    traek=2;
    spillerSum=0;
    husSum=0;
    husK=0;

    //forloop der giver spilleren to kort og udregner værdien for spillerens aktuelle hånd, samt at tegne kortene
    for (int i=0; i<traek; i++) {
      spillerKort[i]=tilfaeldigKort();

      spillerSum+=hvorMangePoint(spillerKort[i]);

      tegnKort(spillerKort[i], i, 2);
    }

    //forloop der tildeler huset kort indtil husets hånd indtil summen heraf er 16
    for (int j=0; j<52; j++) {
      husKort[j]=tilfaeldigKort();
      husSum+=hvorMangePoint(husKort[j]);
      husK+=1;
      if (husSum>=16) break;
    }
    //kortene tegnes
    tegnKort(husKort[0], 0, 0);
  }
}

//værdiudregning
int hvorMangePoint(String kort) {
  //lokale variabler
  String[] list=split(kort, " ");
  String value=list[1];
  int s;
  //Værdien af kortet findes
  if (value.equals("A")) {
    s=11;
  } else if (value.equals("J")) {
    s=10;
  } else if (value.equals("D")) {
    s=10;
  } else if (value.equals("K")) {
    s=10;
  } else {
    s=Integer.parseInt(value);
  }
  return s;
}

//korttrækning
String tilfaeldigKort() {
  //lokale variabler
  String k="";
  int valgtKort=(int)random(0, 52);
  //der tjekkes om  værdien af det valgte kort er "Er trukket", hvis dette er sandt kaldes funktionen igen, elles sættes k variablen til det valgte kort og nummeret i kortspillet sættes til "Er trukket"
  if (kortSpil[valgtKort].equals("Er trukket")) {
    return tilfaeldigKort();
  } else {
    k=kortSpil[valgtKort];
    kortSpil[valgtKort]="Er trukket";
    return k;
  }
}

//resultatet
String vinder(int spiller, int hus) {
  //lokale variabler
  String t="";
  //der tjekkes hvem der er tættest på 21
  if (abs(21-spiller)>=abs(21-hus)) {
    t="Du taber";
    return t;
  } else {
    t="Du vinder";
    return t;
  }
}

//tegn kort
void tegnKort(String kort, int j, int placY) {
  //lokale variabler
  float x=(width/8)*j;
  float y=(placY*height)/3;

  //kortene der tegnes
  fill(10);
  rect(x, y, width/8-10, height/3);
  fill(240);
  //teksten der skrives 
  textAlign(LEFT);
  textSize(20);
  text(kort, x+30, y+40);
}

//angivelse af point
void point() {
  textAlign(LEFT);
  textSize(20);
  text("Du har: " + spillerSum + " Dealer har: " + husSum, 10, 10+height/2);
}

//kortspil
void lavKortSpil() {
  int nr = 0;
  for (int k=0; k<4; k++ ) {
    for (int v=0; v<13; v++) {
      kortSpil[nr] = kulor[k] + " " + vaerdi[v];
      nr++;
    }
  }
}
