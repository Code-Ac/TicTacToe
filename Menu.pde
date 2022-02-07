void menuMousePressed() {
  if (!menuGezeichnet) {
    menuGezeichnet = true;
    menuZeichnen();
    return;
  }
  
  // Start knopf
  if (mouseX > (width-100)/2-10 && mouseX < (width-100)/2+110 &&
      mouseY > 90 && mouseY < 150) {
    if (modus != "Spieler gegen Spieler") {
      switch (modus) {
      case "Einfach":
        chanse = 0;
        break;
      case "Mittel":
        chanse = 0.3;
        break;
      case "Schwer":
        chanse = 0.6;
        break;
      case "Unmöglich":
        chanse = 1;
        break;
      }
    }
    println("\n[MS] Neues Spiel! Schwierigkeit: " + Double.toString(chanse).substring(0, 3));
    spielerAmZug = KREUZ;
    spielerWechsel();
    menuOffen = false;
    menuGezeichnet = false;
    spielZeichnen();
    return;
  }
  // AI Knöpfe
  String modusDavor = modus;
  if (mouseY > height-60 && mouseY < height-30) {
    if (mouseX > width/3 && mouseX < width/3*2) {
      modus = "Einfach";
    } else if (mouseX > width/3*2){
      modus = "Mittel";
    }
  } else if (mouseY > height-30 && mouseY < height) {
    if (mouseX < width/3) {
      modus = "Spieler gegen Spieler";
    } else if (mouseX < width/3*2) {
      modus = "Schwer";
    } else {
      modus = "Unmöglich";
    }
  }
  if (modusDavor != modus) {
    punkteKreuz = 0;
    punkteKreis = 0;
  }
  menuZeichnen();
}

void menuZeichnen() {
  noStroke();
  fill(255);
  rect(0, hText, width, height);
  stroke(0);
  strokeWeight(width/60);
  line(0, hText, width, hText);

  // Felder reset
  for (int i = 0; i  < 3; i++) {
    for (int ii = 0; ii  < 3; ii++) {
      felder[i*3+ii] = new Feld(i+1, ii+1);
    }
  }

  // Startknopf
  knopfZeichnen("START", (width-100)/2, 100, 100, 40, color(0, 150, 0), 40);
  
  // Punktestand
  stroke(0);
  strokeWeight(1);
  textSize(20);
  line(width/2-40, 198, width/2+40, 198);
  text("Punkte", width/2-30, 195);
  text("Kreis: ", width/2-35, 220);
  text("Kreuz: ", width/2-35, 245);
  text(punkteKreis, width/2+20, 220);
  text(punkteKreuz, width/2+20, 245);

  // AI Einstellungen
  noStroke();
  fill(160);
  rect(0, height-60, width, 60);
  knopfZeichnen("AI Modus", 10, height-50, width/3-20, 10, 120, 20);
  int modusX = 10;
  int modusY = height-50;
  switch (modus) {
  case "Spieler gegen Spieler":
    modusX = 10;
    modusY = height-20;
    break;
  case "Einfach":
    modusX = width/3+10;
    modusY = height-50;
    break;
  case "Mittel":
    modusX = width/3*2+10;
    modusY = height-50;
    break;
  case "Schwer":
    modusX = width/3+10;
    modusY = height-20;
    break;
  case "Unmöglich":
    modusX = width/3*2+10;
    modusY = height-20;
    break;
  }
  knopfZeichnen("", modusX, modusY, width/3-20, 10, color(100, 100, 200), 20);
  textSize(20);
  text("AI aus", 10, height-10);
  text("Einfach", width/3+10, height-40);
  text("Mittel", width/3*2+10, height-40);
  text("Schwer", width/3+10, height-10);
  text("Unmöglich", width/3*2+10, height-10);
  nachricht("Modus: " + modus);
}

// Zeichnet einen Knopf mit abgerundeten Ecken
void knopfZeichnen(String text, int x, int y, int xs, int ys, color farbe, int size) {
  noStroke();
  fill(farbe);
  rect(x+2, y+2, xs, ys);
  stroke(farbe);
  strokeWeight(20);
  noFill();
  line(x, y, x, y+ys);
  line(x+xs, y+5, x+xs, y+ys);
  line(x, y, x+xs, y);
  line(x, y+ys, x+xs, y+ys);

  fill(0);
  textSize(size);
  text(text, x, y+(ys+size-5)/2);
}
