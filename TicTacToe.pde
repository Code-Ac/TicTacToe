boolean menuOffen = true;
boolean menuGezeichnet = true;
Feld[] felder = new Feld[9];
String KREUZ = "Kreuz";
String KREIS = "Kreis";
int punkteKreuz = 0;
int punkteKreis = 0;
String spielerAmZug = KREIS;
int hText = 40; // Text-Nachrichten höhe
int randEnf = 20;
String modus = "Spieler gegen Spieler";
// Wahrscheinlichkeit, dass die Lösung auch angewendet wird.
// Gedacht für verschiedene "Schwierigkeitslevel". 
// 1 ist unbesiegbar, 0 ist zufällige Auswahl.
double chanse = 0;

// Startfunktion 
void setup() {
  size(300, 340); // +40Pixel für Nachrichten Empfohlen.
  surface.setResizable(true);
  menuZeichnen();
}

//PRF - Wenn entfernt, funktioniert <mouseClicked> nicht.
void draw() {
  // Optional, sorgt dafür, das das Spiel immer aktualisiert wird, nicht nur nach Aktionen.
  // Benötigt, um Spiel nach größer oder kleiner ziehen ohne Mausclick wieder anzuzeigen.
  if (menuGezeichnet && menuOffen) {
    menuZeichnen();
  } else if (!menuOffen) {
    spielZeichnen();
  }
}

// PRF - Aufgerufen wenn Maus geklickt hat.
void mouseClicked() {
  if (menuOffen)
    menuMousePressed();
  else
    spielMousePressed();
}

// Aktualisiert den Nachrichtentext oben auf dem Bildschirm.
void nachricht(String text) {
  println("[MS] " + text);
  fill(255);
  noStroke();
  rect(0, 0, width, hText);
  fill(0);
  textSize(25);
  text(text, 0, hText/4*3);
}
