void spielMousePressed() {
  int spalte = 0;
  if (mouseX < width/3) {
    spalte = 1;
  } else if (mouseX < width/3*2 && mouseX > width/3) {
    spalte = 2;
  } else if (mouseX > width/3*2) {
    spalte = 3;
  }

  int reihe = 0;
  if (mouseY < (height-hText)/3 + hText && mouseY > hText) {
    reihe = 1;
  } else if (mouseY < (height-hText)/3 * 2 + hText && mouseY > (height-hText)/3 + hText) {
    reihe = 2;
  } else if (mouseY > (height-hText)/3 * 2) {
    reihe = 3;
  }

  if (reihe != 0 && spalte != 0) {
    int feld = (reihe-1)*3 + spalte;
    if (!felder[feld-1].belegt) {
      felder[feld-1].click(spielerAmZug);

      String gewinner = gewinnerPrüfen();
      if (gewinner != null) {
        menuOffen = true;
        nachricht("Gewinner ist " + gewinner);
        if (gewinner == KREIS) punkteKreis++;
        else punkteKreuz++;
      } else spielerWechsel();
    } else {
      nachricht(spielerAmZug + " am Zug. Feld belegt.");
    }
  }

  spielZeichnen(); // Spielfelder aktualisieren
}

class Feld {
  int spalte;
  int reihe;
  boolean belegt = false;
  String von = null;

  public Feld(int reihe, int spalte) {
    this.reihe = reihe;
    this.spalte = spalte;
  }

  void click(String spieler) {
    belegt = true;
    von = spieler;
  }

  void zeichnen() {
    strokeWeight(width/30);
    stroke(0);
    if (von == KREUZ) {
      line((spalte-1)*(width/3)+randEnf, (reihe-1)*((height-hText)/3)+randEnf+hText, (spalte)*(width/3)-randEnf, (reihe)*((height-hText)/3)-randEnf+hText);
      line((spalte-1)*(width/3)+randEnf, (reihe)*((height-hText)/3)-randEnf+hText, (spalte)*(width/3)-randEnf, (reihe-1)*((height-hText)/3)+randEnf+hText);
    } else if (von == KREIS) {
      noFill();
      ellipse(spalte*(width/3)-width/6, reihe*((height-hText)/3)-(height-hText)/6+hText, width/3-randEnf*2, width/3-randEnf*2);
    }
  }
}

void spielerWechsel() {
  for (int i = 0; i < 9; i++) {
    if (!felder[i].belegt) break;
    if (i == 8) {
      menuOffen = true;
      nachricht("Unentschieden!");
      return;
    }
  }
  if (spielerAmZug == KREIS) {
    spielerAmZug = KREUZ;
    nachricht(spielerAmZug + " ist am Zug.");
    if (modus != "Spieler gegen Spieler") {
      aiMakeMove();
      spielZeichnen();

      String gewinner = gewinnerPrüfen();
      if (gewinner != null) {
        menuOffen = true;
        nachricht("Gewinner ist " + gewinner);
        if (gewinner == KREIS) punkteKreis++;
        else punkteKreuz++;
        return;
      }
      spielerWechsel();
    }
  } else {
    spielerAmZug = KREIS;
    nachricht(spielerAmZug + " ist am Zug.");
  }
}

String gewinnerPrüfen() {
  // Mögliche Gewinnkombinationen
  int[][] winList = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9},
    {1, 5, 9},
    {3, 5, 7},
    {1, 4, 7},
    {2, 5, 8},
    {3, 6, 9}
  };
  for (int[] list : winList) {
    String spieler = felder[list[0]-1].von;
    if (felder[list[1]-1].von == spieler &&
      felder[list[2]-1].von == spieler)
      return spieler;
  }
  return null;
}

void spielZeichnen() {
  noStroke();
  fill(255);
  rect(0, hText, width, height);
  stroke(0);
  strokeWeight(width/60);
  line(0, hText, width, hText);
  line(0, (height-hText)/3+hText, width, (height-hText)/3+hText);
  line(0, (height-hText)/3*2+hText, width, (height-hText)/3*2+hText);
  line(width/3, hText, width/3, height);
  line(width/3*2, hText, width/3*2, height);

  for (Feld f : felder) {
    f.zeichnen();
  }
}
