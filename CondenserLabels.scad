// 6/04/2023 Read Me - Condenser labels
// 28 per plate, 6.5 hours per plate

pageNum = 1;  // [1:2]

// X in inches
inX = 2;

// Y in inches
inY = 1;

// Z in millimeters
Z = 2.9;

// margin between labels in millimeters.
margin = 3;

legends = [
  "502",
  "505",
  "510",
  "514",
  "517",
  "518",
  "601",
  "605",
  "611",
  "615",
  "616",
  "618",
  "622",
  "701",
  "710",
  "711",
  "712",
  "714",
  "716",
  "717",
  "720",
  "722",
  "810",
  "816",
  "817",
  "818",
  "819",
  "902",
  "905",
  "906",
  "909",
  "913",
  "915 S",
  "918 N",
  "918 S",
  "920",
  "1002",
  "1007",
  "1009",
  "1012",
  "1016",
  "1101",
  "1103 a",
  "1103 b",
  "1106 N",
  "1106 S",
  "1206 N",
];

// like square, but round the corners by radius 'r'
module RoundedSquare(v, r) {
  translate([r,r])
  hull(){
      for(ix = [0,1], iy = [0,1]){
      translate([ix*(v[0] - 2*r), iy*(v[1] - 2*r)]) circle(r, $fn=20);
    }
  }
}

// given n in inches, return it in millimeters.
function inch(n) = 25.4 * n;

// our 3D blank label.
module blankLabel(){
  linear_extrude(Z)RoundedSquare([inch(inX), inch(inY)], 1);
}

// label with centered, incised text.
module label(s) {
  difference(){
    blankLabel();
    translate([inch(inX)/2, inch(inY)/2, Z-1])linear_extrude(1.1)text(s, size=12, font="Helvetica Neue:style=Bold", halign="center", valign="center");
  }
}

module labelPage(pageNum){
  for(x=[0:3], y=[0:6]){
    n = x*7 + y + (pageNum - 1)*28;
    if (n < len(legends)) {
      translate([x*(inch(inX)+margin), y*(inch(inY)+margin), 0])label(legends[n]);
    }
  }
}

labelPage(pageNum);

