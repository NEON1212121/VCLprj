import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int receivePort = 9999;
String sendIP = "127.0.0.1";
int sendPort = 50000;

void setup() {
  size(400,400);
  frameRate(30);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,receivePort);

  myRemoteLocation = new NetAddress(sendIP,sendPort);
  
}


void draw() {
  background(colorCode[0]);
  
  GraphUpdate();
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  if(theOscMessage.checkAddrPattern("/ZIGSIM/neonald/accel") == true){
    OscMessage myMessage = new OscMessage("/ZIGSIM/neonald/accel");
    
    ax = theOscMessage.get(0).floatValue() * 10;
    myMessage.add(ax);
    ay = theOscMessage.get(1).floatValue() * 10;
    myMessage.add(ay);
    az = theOscMessage.get(2).floatValue() * 10;
    myMessage.add(az);
  
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation); 
  }
  
  if(theOscMessage.checkAddrPattern("/ZIGSIM/neonald/gyro") == true){
    OscMessage myMessage = new OscMessage("/ZIGSIM/neonald/gyro");
    
    gx = theOscMessage.get(0).floatValue() * 10;
    myMessage.add(gx);
    gy = theOscMessage.get(1).floatValue() * 10;
    myMessage.add(gy);
    gz = theOscMessage.get(2).floatValue() * 10;
    myMessage.add(gz);
  
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation); 
  }
  
  theOscMessage.print();
}
