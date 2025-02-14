// Generate simple X across 2D box

lc = 0.3;
lc2 = 0.3;

Point(1) = {0, 0, 0, lc};
Point(2) = {1, 0, 0, lc};
Point(3) = {1, 1, 0, lc};
Point(4) = {0, 1, 0, lc};

Point(5) = {0.5, 0.5, 0, lc2};

Point(6) = {0.3, 0, 0, lc2};
Point(7) = {0.7, 1, 0, lc2};
Point(9) = {0.25, 1, 0, lc2};

Line(1) = {4, 1};
Line(2) = {1, 6};
Line(3) = {6, 2};
Line(9) = {2, 3};
Line(10) = {3, 7};
Line(11) = {7, 9};
Line(12) = {9, 4};

Line(5) = {6, 5};
Line(6) = {5, 7};
Line(7) = {9, 5};


Curve Loop(1) = {1, 2, 5, -7, 12};
Plane Surface(1) = {1};
Curve Loop(2) = {3, 9, 10, -6, -5};
Plane Surface(2) = {2};
Curve Loop(3) = {6, 11, 7};
Plane Surface(3) = {3};


Physical Surface("blockA") = {1};
Physical Surface("blockB") = {2};
Physical Surface("blockC") = {3};


Physical Curve("ss2") = {5,6};
Physical Curve("ss3") = {7};
Physical Curve("bottom") = {2,3};
Physical Curve("top") = {10,11,12};
Physical Curve("right") = {9};
Physical Curve("left") = {1};




