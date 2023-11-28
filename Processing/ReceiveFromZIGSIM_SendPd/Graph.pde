float o_ax = 0, o_ay = 0, o_az = 0; //前回の加速度
float ax, ay, az, a; //加速度
float gx, gy, gz, g; //ジャイロ
float vx, vy, vz, v; //速度

int historySize = 180;
float unitw = 400/(float)(historySize+10); // グラフの点の描画幅
Queue aHistoryQueue = new Queue(historySize);
Queue gyroHistoryQueue = new Queue(historySize);
Queue vHistoryQueue = new Queue(historySize);

void GraphUpdate(){
  stroke(colorCode[1]);
  line(0, height/2, width, height/2);
  
  a = mag(ax, ay, az);
  vx = vIntegral(ax, o_ax);
  vy = vIntegral(ay, o_ay);
  vz = vIntegral(az, o_az);
  v =  mag(vx, vy, vz);
  
  g = mag(gx, gy, gz);

  //ImpactDraw(int(a));
  
  // ↓折れ線が左へ流れていくよう描画をずらすコール（そのためのQueue）
  if(aHistoryQueue.count == historySize){
    aHistoryQueue.Dequeue();
  }
  //vQueue.Enqueue(v);
  aHistoryQueue.Enqueue(a);
  
  QueueDraw(aHistoryQueue, 2);
  
  
  if(gyroHistoryQueue.count == historySize){
    gyroHistoryQueue.Dequeue();
  }
  gyroHistoryQueue.Enqueue(g);
  
  QueueDraw(gyroHistoryQueue, 1);
  
  
  if(vHistoryQueue.count == historySize){
    vHistoryQueue.Dequeue();
  }
  
  vHistoryQueue.Enqueue(v);
  
  QueueDraw(vHistoryQueue, 3);
}



void QueueDraw(Queue target, int colornum){  
  stroke(colorCode[colornum]);
  strokeWeight(2);
  PVector prePoint = new PVector(0, height/2 - target.Access(target.head));
  PVector currentPoint = new PVector(0, height/2);
  
  for(int i = 0; i < historySize; i ++){
    target.index = (i + target.head)%historySize; // キューの見る場所
    //グラフの点の位置を設定
    currentPoint.x = i * unitw;
    currentPoint.y = height/2 - target.Access(target.index);
    //描画
    line(prePoint.x, prePoint.y, currentPoint.x, currentPoint.y);
    //↓値渡し
    prePoint.x = i * unitw;
    prePoint.y = height/2 - target.Access(target.index);
    
    //↓これだと参照渡しとなり、preとcurrentが常に同じ値になってしまう
    //prePoint = currentPoint;
  }
  strokeWeight(1);
}

int peak = 0;
float aFall = 0;

void ImpactDraw(int impact){
  peak = abs(peak);
  peak -= aFall / frameRate; // 3秒かけて落ちてくる感じ
  
  if(impact > peak){
    peak = (int)impact;
    aFall = 0;
  }else{
    aFall += 20;
  }
  
  
  stroke(colorCode[4]);
  fill(colorCode[4]);
  rect(width/5*2, height/2-peak, width/5, constrain(peak, 0, 10));
  stroke(colorCode[3]);
  fill(colorCode[3]);
  rect(width/4, height/2-impact, width/4*2, impact);
}

float vIntegral(float accel, float oldAccel){
  /*↓値が小さくなりすぎてfloatだとビット数が足りない、
    どうせあとでframeRate値を掛け算するので(Δvを蓄積させて速度にするため)、
    先にframeRateを掛けて１にしたということ
    https://www.tsukutsuku-lab.com/%E3%82%B9%E3%83%9E%E3%83%9B%E5%86%85%E8%94%B5%E3%82%BB%E3%83%B3%E3%82%B5%E3%83%BC%E3%81%A7%E5%AE%9F%E9%A8%93/%E6%9C%AC%E5%BD%93%E3%81%AB%E5%8A%A0%E9%80%9F%E5%BA%A6%E3%82%92%E8%A8%88%E6%B8%AC%E3%81%A7%E3%81%8D%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B/
  */
  //return (accel + oldAccel) * (1/_frameRate) / 2;
  return (accel + oldAccel) * 1 / 2;
}
