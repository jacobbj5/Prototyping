import cc.arduino.*;
import processing.serial.*;
import processing.sound.*;

Arduino arduino;
SoundFile[] file = new SoundFile[5];
String[] sounds = new String[] { "fingerD1.wav", "fingerD2.wav", "fingerD3.wav", "fingerD4.wav", "fingerD5.wav"}; 
boolean sensedBefore[] = {false, false, false, false, false};
int sensor[] = {0, 0, 0, 0, 0};
int threshold = 600;

void setup() {

  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[5], 57600); 

  for (int i=0; i<file.length; i++) {
    file[i] = new SoundFile(this, sounds[i]);
  }
}

void draw() {

  for (int i=0; i<sensor.length; i++) {
    sensor[i] = arduino.analogRead(i);
      if (sensor[i] > threshold && !sensedBefore[i]) {
        sensedBefore[i] = true;
        file[i].play();
      } else if (sensor[i] <= threshold && sensedBefore[i]) {
        sensedBefore[i] = false;
      }
    }
  }