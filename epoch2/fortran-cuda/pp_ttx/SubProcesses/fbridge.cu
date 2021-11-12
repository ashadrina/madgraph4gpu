#include "transpose.h"
#include <iostream>

// m == DOUBLE PRECISION P_MULTI(0:3, NEXTERNAL, NB_PAGE)
// NEXTERNAL = 4 (nexternal.inc)
// NB_PAGE = 16 (vector.inc)

struct CudaInit {
  CudaInit();
};

CudaInit::CudaInit() { std::cout << "cuda init" << std::endl; }

static CudaInit cuInit;

void bridge(double *m) {

  Matrix<double> t = Matrix<double>(16, 4, 4, 2);
  t.hst_transpose(m);
}

extern "C" {

void bridge_(double *m) { bridge(m); }
}
