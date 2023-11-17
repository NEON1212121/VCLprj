float ax, ay, az, a; //加速度
float vx, vy, vz, v; //速度

int historySize = 180;
float unitw = 400/(float)(historySize+10); // グラフの点の描画幅
Queue vHistoryQueue = new Queue(historySize);

void GraphUpdate(){
  a = mag(ax, ay, az);
  vx += ax;
  vy += ay;
  vz += az;
  v =  mag(vx, vy, vz);
  
  if(vHistoryQueue.count == historySize){
    vHistoryQueue.Dequeue();
  }
  //vQueue.Enqueue(v);
  vHistoryQueue.Enqueue(a);
  
  ImpactDraw(int(a));

  QueueDraw(vHistoryQueue);
  
}



void QueueDraw(Queue target){
  stroke(colorCode[1]);
  line(0, height/2, width, height/2);
  
  stroke(colorCode[2]);
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
