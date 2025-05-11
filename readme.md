# CarEgo Script

## Beschreibung
Das **CarEgo Script** bietet ein immersives Spielerlebnis, indem es Spieler automatisch in die Egoperspektive (First-Person-Ansicht) versetzt, sobald sie ein Fahrzeug betreten. Zusätzlich integriert es eine Rückfahrkamera mit dynamischen Abständen und akustischen Warnsignalen, um das Fahren und Parken realistischer zu gestalten.

---

## Hauptfeature

### **Automatischer Wechsel in die Egoperspektive**
- Sobald der Spieler ein Fahrzeug betritt, wird die Kamera automatisch in die Egoperspektive (First-Person-Ansicht) umgeschaltet.
- Dieses Feature sorgt für ein intensiveres und realistischeres Fahrerlebnis.

---

## Zusätzliche Features

### 1. **Rückfahrkamera**
- Aktivierung der Rückfahrkamera durch Drücken der **C-Taste** (Standard).
- Dynamische Kameraansicht, die sich basierend auf den Fahrzeugdimensionen anpasst.
- Realistische Rückansicht mit einem speziellen Kamerafilter (Helikopter-Kameraeffekt).

### 2. **Abstandssensor**
- Zeigt die Entfernung zu Objekten hinter dem Fahrzeug in Echtzeit an.
- Unterstützt die Erkennung von Objekten mit und ohne Physik.
- Farbige und dynamische Anzeige der Entfernung im Overlay.

### 3. **Akustische Warnsignale**
- Warnt den Spieler mit Pieptönen, wenn sich das Fahrzeug Objekten nähert.
- Die Frequenz der Pieptöne erhöht sich, je näher das Fahrzeug einem Hindernis kommt.

### 4. **Fahrzeugspezifische Konfiguration**
- Unterstützt nur bestimmte Fahrzeuge, die in der Konfigurationsdatei definiert sind.
- Jedes Fahrzeug hat einen individuellen Offset für die Rückfahrkamera, um die Position der Kamera zu optimieren.

### 5. **Overlay-Anzeige**
- Ein visuelles Overlay zeigt an, wenn die Rückfahrkamera aktiv ist.
- Echtzeit-Updates der Entfernung zu Hindernissen.
- Automatische Ein- und Ausblendung des Overlays basierend auf der Kameranutzung.

---

## Unterstützte Fahrzeuge
Das Script unterstützt nur bestimmte Fahrzeuge, die in der Konfigurationsdatei `config.lua` definiert sind. Beispiele:
- **Benson**
- **Biff**
- **Hauler**
- **Mule**
- **Packer**
- **Phantom**
- **Pounder**
- **Stockade**
- **Terbyte**

---

## Steuerung
- **C-Taste gedrückt halten**: Rückfahrkamera aktivieren.
- **C-Taste loslassen**: Rückfahrkamera deaktivieren.

---

## Installation
1. Kopiere den Ordner `CarEgo Script` in deinen GTA 5 Server-Ordner.
2. Stelle sicher, dass die Datei `fxmanifest.lua` korrekt eingebunden ist.
3. Starte den Server und genieße die neuen Features!

---

## Hinweise
- Die Egoperspektive wird nur in unterstützten Fahrzeugen erzwungen.
- Die Rückfahrkamera funktioniert nur bei den in der Konfiguration definierten Fahrzeugen.
- Der Abstandssensor kann in der Konfigurationsdatei deaktiviert werden, falls gewünscht.

---

## Autor
**DorAqua**  
Version: 1.0.0  
Beschreibung: Advanced Egoview in GTA 5
