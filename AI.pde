// Lässt die AI ziehen.
void aiMakeMove() {
  class AILösung {
    // Felder, die belegt sein müssen, damit
    // lösung (darunter) angekreuzt wird.
    boolean[] belegt;
    int lösung;

    AILösung(int[] belegt, int lösung) {
      this.belegt = zuBelegtFeld(belegt);
      this.lösung = lösung;
    }

    // Probiere diese lösung am aktuellen Spielfeld.
    // Dabei wird der angegebene Spieler gegenüber <belegt> betrachtet.
    boolean versuche(String spieler) {
      boolean[] spielerFelder = zuFeld(spieler);
      boolean[] tmpBelegt = belegt;
      // Für alle möglichen rotationen (4)
      for (int r = 0; r < 3; r++) {
        boolean success = true;
        for (int i = 0; i < 9; i++) {
          if (tmpBelegt[i]) {
            if (!spielerFelder[i]) {
              success = false;
            }
          };
        }
        // Wenn alle <belegt> felder von <spieler> belegt sind,
        // prüfe ob <lösung> belegt, wenn nein clicke <lösung>
        // in aktueller rotation und beende Zug.
        if (success) {
          boolean[] lösungFeld = zuBelegtFeld(new int[]{lösung});
          for (int i = 0; i < r; i++) {
            lösungFeld = feldDrehen(lösungFeld);
          }
          for (int i = 0; i < 9; i++) {
            if (lösungFeld[i]) {
              if (!felder[i].belegt && chanse >= Math.random()) {
                felder[i].click(KREUZ);
                // Lösung eingetragen, keine Lösung mehr probieren.
                return true;
              }
              break;
            }
          }
        }
        // Rotiere feld.
        tmpBelegt = feldDrehen(tmpBelegt);
      }
      // Keine Lösung eingetragen, nächste probieren.
      return false;
    }

    // Dreht rechnerisches feld 90° im Uhrzeigersinn.
    boolean[] feldDrehen(boolean[] i) {
      boolean[] o = new boolean[9];
      o[3-1] = i[1-1];
      o[6-1] = i[2-1]; // 1 2 3
      o[9-1] = i[3-1]; // 4 5 6
      o[2-1] = i[4-1]; // 7 8 9
      o[5-1] = i[5-1]; //  /\
      o[8-1] = i[6-1]; // 3 6 9
      o[1-1] = i[7-1]; // 2 5 8
      o[4-1] = i[8-1]; // 1 4 7
      o[7-1] = i[9-1];
      return o;
    }

    // Erstellt rechnerisches Feld für den angegebenen Spieler.
    boolean[] zuFeld(String spieler) {
      boolean[] o = new boolean[9];
      for (int i = 0; i < 9; i++) o[i] = felder[i].von == spieler;
      return o;
    }

    // Erstellt rechnerisches Feld von belegten feldern.
    boolean[] zuBelegtFeld(int[] f) {
      boolean[] o = {false, false, false, false, false, false, false, false, false};
      for (int i : f) o[i-1] = true;
      return o;
    }
  }

  nachricht("[AI] Rechne...");

  // Mögliche spielsituationen:
  AILösung[] lösungen = {
    new AILösung(new int[]{1, 2}, 3), // 2 Gerade hintereinander
    new AILösung(new int[]{3, 1}, 2),
    new AILösung(new int[]{2, 3}, 1),
    new AILösung(new int[]{4, 5}, 6),
    new AILösung(new int[]{6, 4}, 5),
    new AILösung(new int[]{5, 6}, 4),

    new AILösung(new int[]{1, 5}, 9), // 2 Diagonal hintereinander
    new AILösung(new int[]{9, 1}, 5),
    new AILösung(new int[]{5, 9}, 1),
  };

  AILösung[] zwickmühlen = {
    new AILösung(new int[]{1, 9}, 2), // Zwickmühlen-Verhinderung
    new AILösung(new int[]{5}, 1),
    new AILösung(new int[]{}, 5),
  };

  // Zuerst schauen, ob direkt gewonnen werden kann.
  for (AILösung lösung : lösungen)
    if (lösung.versuche(KREUZ)) return;

  // 2 hintereinander verhindern.
  for (AILösung lösung : lösungen)
    if (lösung.versuche(KREIS)) return;
  // Dann Zwickmühlen verhindern.
  for (AILösung lösung : zwickmühlen)
    if (lösung.versuche(KREIS)) return;

  // Wenn keine Lösung gefunden wurde,
  // erstbestes unbelegtes Feld anclicken.
  while (true) {
    int zufall = (int) random(9);
    if (!felder[zufall].belegt) {
      felder[zufall].click(KREUZ);
      return;
    }
  }
}
