#define BTN_N 32
#define BTN_P 26
#define BTN_K 13
#define LDR_PIN 34
#define RELE 25

#include "DHT.h"
#define DHTPIN 23
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

const float PH_MIN = 5.5;
const float PH_MAX = 6.5;
const float UMIDADE_MIN = 60.0;

void setup() {
  Serial.begin(115200);
  dht.begin();

  pinMode(RELE, OUTPUT);
  digitalWrite(RELE, LOW);

  pinMode(BTN_N, INPUT_PULLUP);
  pinMode(BTN_P, INPUT_PULLUP);
  pinMode(BTN_K, INPUT_PULLUP);
}

void loop() {
  bool n = (digitalRead(BTN_N) == LOW);
  bool p = (digitalRead(BTN_P) == LOW);
  bool k = (digitalRead(BTN_K) == LOW);
  
  int leitura = analogRead(LDR_PIN);
  float ph = (leitura / 4095.0f) * 14.0f;

  float umidade = dht.readHumidity();

  bool phFora = (ph < PH_MIN || ph > PH_MAX);
  bool seco   = (umidade < UMIDADE_MIN);
  bool ligar  = seco || phFora;

  digitalWrite(RELE, ligar ? HIGH : LOW);
  Serial.println(ligar ? "Bomba LIGADA!" : "Bomba DESLIGADA.");

  Serial.print("Umidade: ");
  Serial.print(umidade, 1);
  Serial.print("%");

  Serial.print(" | pH=");
  Serial.print(ph, 2);

  Serial.print(" | N=");
  Serial.print(n ? "OK" : "FALTA");

  Serial.print(" | P=");
  Serial.print(p ? "OK" : "FALTA");

  Serial.print(" | K=");
  Serial.print(k ? "OK" : "FALTA");

  Serial.print(" | Limites pH[");
  Serial.print(PH_MIN);
  Serial.print("-");
  Serial.print(PH_MAX);
  Serial.print("] umid>=");
  Serial.print(UMIDADE_MIN);
  Serial.println("%");

  delay(1000);
}
