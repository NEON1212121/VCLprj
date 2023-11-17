
//サイズ以上のキューの場合は、headを上書き
// [7](head),[5],[3],[2],[](tail),…
class Queue{
  int index;
  int head; //先頭インデックス
  int tail; //最後尾インデックス(空いてるところ)
  int size; //最大キュー数
  int count; //現在のキュー数
  float[] queue;

  Queue(int size){
    this.size = size;
    queue = new float[size];
    
    index = 0;
    head = 0;
    tail = 0;
  }
  
  // 先入れ
  void Enqueue(float num){
    index = tail;
    
    if(tail < size-1) {
      tail ++;
    }
    else {
      tail = 0;
    }
    
    //サイズを超えるキューが入った場合はキャンセル
    if(count >= size){
      tail = index;
      return;
    }
    
    count ++;
    queue[index] = num;
  }
  
  // 先出し
  float Dequeue(){
    if(count <= 0) return -9999999;
    index = head;
    if(head < size-1) {
      head ++;
    }
    else {
      head = 0;
    }
    
    count --;
    float out = queue[index];
    queue[index] = 0;
    return out;
  }
  
 float Access(int index){
   return queue[index];
 }
  
  String Show(){
    String s = new String();
    for(float f : queue){
      s += "[" + f + "]";
    }
    s += "head:" +head+ ",tail:" +tail + ",index:"+ index;
    return s;
  }
}
