set(GPU_ARCH "
GeForce GTX TITAN Z 	3.5
GeForce GTX TITAN Black 	3.5
GeForce GTX TITAN 	3.5
GeForce GTX 1080 	6.1
GeForce GTX 1070 	6.1
GeForce GTX 1060 3GB	6.1
GeForce GTX 980 	5.2
GeForce GTX 970 	5.2
GeForce GTX 960 	5.2
GeForce GTX 780 Ti 	3.5
GeForce GTX 780 	3.5
GeForce GTX 770 	3.0
GeForce GTX 760 	3.0
GeForce GTX 750 Ti 	5.0
GeForce GTX 750 	5.0
GeForce GTX 690 	3.0
GeForce GTX 680 	3.0
GeForce GTX 670 	3.0
GeForce GTX 660 Ti 	3.0
GeForce GTX 660 	3.0
GeForce GTX 650 Ti BOOST 	3.0
GeForce GTX 650 Ti 	3.0
GeForce GTX 650 	3.0
GeForce GTX 560 Ti 	2.1
GeForce GTX 550 Ti 	2.1
GeForce GTX 460 	2.1
GeForce GTS 450 	2.1
GeForce GTS 450* 	2.1
GeForce GTX 590 	2.0
GeForce GTX 580 	2.0
GeForce GTX 570 	2.0
GeForce GTX 480 	2.0
GeForce GTX 470 	2.0
GeForce GTX 465 	2.0
GeForce GT 740 	3.0
GeForce GT 730 	3.5
GeForce GT 730 DDR3,128bit 	2.1
GeForce GT 720 	3.5
GeForce GT 640 (GDDR5) 	3.5
GeForce GT 640 (GDDR3) 	2.1
GeForce GT 630 	2.1
GeForce GT 620 	2.1
GeForce GT 610 	2.1
GeForce GT 520 	2.1
GeForce GT 440 	2.1
GeForce GT 440* 	2.1
GeForce GT 430 	2.1
GeForce GT 430* 	2.1
GeForce 210 	2.0
GeForce GTX 980M 	5.2
GeForce GTX 970M 	5.2
GeForce GTX 965M 	5.2
GeForce GTX 880M 	3.0
GeForce GTX 870M 	3.0
GeForce GTX 860M 	3.0
GeForce GTX 850M 	5.0
GeForce 840M 	5.0
GeForce 830M 	5.0
GeForce 820M 	2.1
GeForce GTX 780M 	3.0
GeForce GTX 770M 	3.0
GeForce GTX 765M 	3.0
GeForce GTX 760M 	3.0
GeForce GTX 680MX 	3.0
GeForce GTX 680M 	3.0
GeForce GTX 675MX 	3.0
GeForce GTX 675M 	2.1
GeForce GTX 670MX 	3.0
GeForce GTX 670M 	2.1
GeForce GTX 660M 	3.0
GeForce GT 750M 	3.0
GeForce GT 650M 	3.0
GeForce GT 745M 	3.0
GeForce GT 645M 	3.0
GeForce GT 740M 	3.0
GeForce GT 730M 	3.0
GeForce GT 640M 	3.0
GeForce GT 640M LE 	3.0
GeForce GT 735M 	3.0
GeForce GT 635M 	2.1
GeForce GT 730M 	3.0
GeForce GT 630M 	2.1
GeForce GT 625M 	2.1
GeForce GT 720M 	2.1
GeForce GT 620M 	2.1
GeForce 710M 	2.1
GeForce 610M 	2.1
GeForce GTX 580M 	2.1
GeForce GTX 570M 	2.1
GeForce GTX 560M 	2.1
GeForce GTX 560		2.1
GeForce GT 555M 	2.1
GeForce GT 550M 	2.1
GeForce GT 540M 	2.1
GeForce GT 525M 	2.1
GeForce GT 520MX 	2.1
GeForce GT 520M 	2.1
GeForce GTX 485M 	2.1
GeForce GTX 470M 	2.1
GeForce GTX 460M 	2.1
GeForce GT 445M 	2.1
GeForce GT 435M 	2.1
GeForce GT 420M 	2.1
GeForce GT 415M 	2.1
GeForce GTX 480M 	2.0
GeForce 710M 	2.1
GeForce 410M 	2.1
GeForce 9400M 	1.1
GeForce GT 750M Mac Edition    3.0
GeForce GTX 1050 Ti	6.1
GeForce GTX 1060 	6.1
GeForce RTX 2060 	7.5
GeForce RTX 2070        7.5
GeForce RTX 2080        7.5
GeForce RTX 3050 	    8.6
GeForce RTX 3060 	    8.6
GeForce RTX 3070        8.6
GeForce RTX 3080        8.6
GeForce RTX 3090        8.6
NVIDIA GeForce RTX 2070 7.5
NVIDIA GeForce RTX 3070 Ti 8.6
NVIDIA GeForce RTX 2080 Super with Max-Q Design 7.5
")

STRING(REGEX REPLACE "\n" ";" LIST_GPU_ARCH ${GPU_ARCH})

execute_process(COMMAND nvidia-smi --query-gpu=name --format=csv,noheader
                OUTPUT_VARIABLE LSPCIOUT )

STRING(STRIP ${LSPCIOUT} LSPCIOUT)

#set(PLUGIN_SOFACUDA ON CACHE BOOL "FORCE VALUE" FORCE)
#set(SOFACUDA_DOUBLE ON CACHE BOOL "FORCE VALUE" FORCE)
#set(SOFACUDA_CUBLAS ON CACHE BOOL "FORCE VALUE" FORCE)

#here we try to find you GPU if it's not found in the found (no message written in cmake) you need to define arch_sm manually in the cmake of sofa

message("YOUR GPU IS " ${LSPCIOUT})
foreach(ITER ${LIST_GPU_ARCH})
    string(LENGTH "${ITER}" ITER_LEN)
    math(EXPR ITER_LEN "${ITER_LEN} - 3")    
    string(SUBSTRING ${ITER} ${ITER_LEN} -1 ARCH)
    string(SUBSTRING ${ITER} 0 ${ITER_LEN} GPU)
    STRING(STRIP ${GPU} GPU)
    
    if("${LSPCIOUT}" STREQUAL "${GPU}")       
        STRING(REGEX REPLACE "\\." "" ARCH ${ARCH})
        message("Found your GPU : '${GPU}' Set arch_sm to sm_${ARCH}")
        set(CUDA_ARCH "sm_${ARCH}" CACHE STRING "FORCE VALUE" FORCE)
        set(CMAKE_CUDA_ARCHITECTURES ${ARCH} CACHE STRING "" FORCE)
    endif()
endforeach()

find_package(CUDA REQUIRED)
find_package(CUDAToolkit REQUIRED)
set(CMAKE_CUDA_COMPILER ${CUDAToolkit_NVCC_EXECUTABLE})
#set(CUDACXX ${CUDAToolkit_NVCC_EXECUTABLE})



