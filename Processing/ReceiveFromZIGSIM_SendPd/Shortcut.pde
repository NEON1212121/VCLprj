void keyPressed(){
  switch(key){
    case '0': SELECT_COLORDATA_NUMBER = 0; break;
    case '1': SELECT_COLORDATA_NUMBER = 1; break;
    case '2': SELECT_COLORDATA_NUMBER = 2; break;
    case '3': SELECT_COLORDATA_NUMBER = 3; break;
    case '4': SELECT_COLORDATA_NUMBER = 4; break;
    case '5': SELECT_COLORDATA_NUMBER = 5; break;
    case '6': SELECT_COLORDATA_NUMBER = 6; break;
    case '7': SELECT_COLORDATA_NUMBER = 7; break;
  }
  
  ColorInitialize();
}
