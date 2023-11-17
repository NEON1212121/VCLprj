
int SELECT_COLORDATA_NUMBER = 7;

color[][] colorDataBase = new color[][]{
  //背景、軸線、折れ線、インパクト、ピーク
  {#F2F2F2, #BFBFBF, #595959, #262626, #0D0D0D}, //モノクロ
  
  {#2E5902, #D96941, #A62B1F, #193C40, #214001}, //野菜とトマト
  {#A4A5A6, #262626, #0D0D0D, #A68256, #F2F2F2}, //素朴
  {#7278F2, #45488C, #05F2DB, #EE05F2, #8A038C}, //ネオン
  {#E9EBF2, #9BA8F2, #8091F2, #5E75F2, #2540D9}, //ブルー
  {#F2EBDF, #595046, #261F15, #BFB7A8, #8C8579}, //羊皮紙
  {#8C7A64, #353A8C, #F2F2F2, #BF0404, #8C030E}, //郵便デザイン
  {#181F2C, #8266F1, #E83B4B, #E6E2D9, #18303B}, //VALORANT
  {},
  {}
};

color[] colorCode = colorDataBase[SELECT_COLORDATA_NUMBER];

void ColorInitialize(){
  colorCode = colorDataBase[SELECT_COLORDATA_NUMBER];
}
