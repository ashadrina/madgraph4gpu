#ifndef COLORAMPS_H
#define COLORAMPS_H 1

namespace mgOnGpu
{

  template <typename T>
  constexpr T icolamp[] = { // FIXME: assume process.nprocesses == 1 for the moment
     true, true,
     true, false,
     false, true
  };

}
#endif // COLORAMPS_H
