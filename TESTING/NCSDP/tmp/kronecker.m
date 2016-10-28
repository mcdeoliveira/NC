AppendTo[$Echo, "stdout"]
SetOptions[$Output,PageWidth->120];

<< Kronecker`

m = 5;
n = 5;

(* These should be all zeros *)
ans = {1, 2, 3, 4, 5, 7, 8, 9, 10, 13, 14, 15, 19, 20, 25};
LowerTriangularProjection[m, n];
Norm[% - ans]

ans = {1, 6, 11, 16, 21, 7, 12, 17, 22, 13, 18, 23, 19, 24, 25};
UpperTriangularProjection[m, n];
Norm[% - ans]

M = { 
  {4, 1, -7, -1, -6}, 
  {-3, 4, 8, 5, -4}, 
  {-3, -6, -2, -7, -7}, 
  {5, -8, 8, 10, 5}, 
  {-6, 8, 5, -1, 7}
};

ans = {4, -3, -3, 5, -6, 4, -6, -8, 8, -2, 8, 5, 10, -1, 7};
Part[ToVector[M], LowerTriangularProjection[m, n]];
Norm[% - ans]

ans = {4, 1, -7, -1, -6, 4, 8, 5, -4, -2, -7, -7, 10, 5, 7};
Part[ToVector[M], UpperTriangularProjection[m, n]];
Norm[% - ans]

m = 4; n = 4;
p = 5; q = 3;

M = {
  {-9, 8, 7, 5, -2, -2, 2, -3, 8, -4, 10, -4, 7, -9, -6, -1}, 
  {-4, -8, 9, 7, -8, 9, -6, -1, -4, 2, 8, -9, 10, -4, -4, -10}, 
  {8, -1, 9, -9, 3, -2, -4, 6, -6, 1, -6, -5, 3, 9, 0, -1}, 
  {-9, -3, -8, 1, -5, 2, 2, 10, 1, -3, -9, 1, 4, 2, -8, 8}, 
  {-5, 8, -9, 2, 4, 7, 9, -9, -4, 10, 7, -10, 5, 9, -5, 0}, 
  {0, 4, -10, 5, 7, -7, -1, 4, 4, -7, 9, -7, -6, 10, -2, 7}, 
  {6, 3, 2, -6, 3, -2, 3, 10, 6, -3, -1, 3, -5, -6, -8, 1}, 
  {0, -8, -1, 0, -10, -9, 2, 0, 10, 6, 1, -10, -3, 2, -9, 9}, 
  {4, 3, -8, 7, 8, 8, -7, -7, 4, -8, 9, 9, 0, -2, 1, -5}, 
  {-7, -10, 6, 7, -5, -4, 9, -2, -10, -7, 2, 0, -8, -1, -1, 8}, 
  {7, 2, 6, 7, -5, -3, -6, -8, -6, -9, 4, 3, 1, -6, 7, -8}, 
  {-7, 0, 6, -2, -8, 4, 7, -8, -2, 0, 0, 0, 6, 1, 4, 1}, 
  {-7, 4, -10, -6, -6, 5, -1, 8, 0, -5, -1, -10, -1, -7, -10, 4}, 
  {4, 7, 6, -4, -9, 10, 9, -5, 4, -2, 1, 3, 8, 6, 3, 9}, 
  {9, 10, -4, -7, -6, -1, 8, 3, -6, -4, 7, -3, 1, -5, 8, 5}
};

ans = {
  {-9, 3, 15/2, 6, -2, -1, -6, 10, -5, -1},
  {-4, -8, 5/2, 17/2, 9, -2, -5/2, 8, -13/2, -10},
  {8,  1, 3/2, -3, -2, -3/2, 15/2, -6, -5/2, -1},
  {-9, -4, -7/2, 5/2, 2, -1/2, 6, -9, -7/2, 8},
  {-5, 6, -13/2, 7/2, 7, 19/2, 0, 7, -15/2, 0},
  {0, 11/2, -3, -1/2, -7, -4, 7, 9, -9/2, 7},
  {6, 3, 4, -11/2, -2, 0, 2, -1, -5/2, 1},
  {0, -9, 9/2, -3/2, -9, 4, 1, 1, -19/2, 9},
  {4, 11/2, -2, 7/2, 8, -15/2, -9/2, 9, 5, -5},
  {-7, -15/2, -2, -1/2, -4, 1, -3/2, 2, -1/2, 8},
  {7, -3/2, 0, 4, -3, -15/2, -7, 4, 5, -8},
  {-7, -4, 2,  2,  4, 7/2, -7/2, 0, 2, 1},
  {-7, -1, -5, -7/2, 5, -3, 1/2, -1, -10, 4},
  {4, -1, 5, 2, 10, 7/2, 1/2, 1, 3, 9},
  {9, 2, -5, -3, -1, 2, -1, 7, 5/2, 5}
};
(Part[M, All, LowerTriangularProjection[m, n]] +
    Part[M, All, UpperTriangularProjection[m, n]])/2;
Norm[% - ans]

M = {{1,3},{2,4}}
Norm[ToVector[M] - {1,2,3,4}]

M = {{1,2},{2,3}}
Norm[SymmetricToVector[M] - {1,2,3}]

SymmetricToVector[M]
ToSymmetricMatrix[SymmetricToVector[M], 2]

M = {{1,2},{2,3}}
Norm[SymmetricToVector[M, 2] - {1,4,3}]

SymmetricToVector[M, 2]
ToSymmetricMatrix[SymmetricToVector[M, 2], 2]

$Echo = DeleteCases[$Echo, "stdout"];