//==========================================================================
// This file has been automatically generated for SYCL standalone by
%(info_lines)s
//==========================================================================

#include <algorithm>
#include <array>
#include <cstring>
#include <memory>

#include "mgOnGpuConfig.h"
#include "mgOnGpuTypes.h"
#include "mgOnGpuVectors.h"

#include "CPPProcess.h"

#ifdef MGONGPU_SUPPORTS_MULTICHANNEL
    #include "coloramps.h"
#endif

%(hel_amps_h)s

%(process_function_definitions)s
