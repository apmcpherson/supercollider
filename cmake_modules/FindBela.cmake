# - Try to find Bela (BeagleRT)
# Once done this will define
#
#  BELA_FOUND - system has bela
#  BELA_INCLUDE_DIRS - the bela include directory
#  BELA_DEFINITIONS - Compiler switches required for using bela
#
#  Copyright (c) 2008 Andreas Schneider <mail@cynapses.org>
#  Modified for other libraries by Lasse Kärkkäinen <tronic>
#
#  Redistribution and use is allowed according to the terms of the New
#  BSD license.
#  For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

if (BELA_INCLUDE_DIRS)
  # in cache already
  set(BELA_FOUND TRUE)
else (BELA_INCLUDE_DIRS)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIBRARY() calls
  if (${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4)
    include(UsePkgConfig)
    pkgconfig(xenomai _BELA_INCLUDEDIR _BELA_LIBDIR _BELA_LDFLAGS _BELA_CFLAGS)
  else (${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4)
    find_package(PkgConfig)
    if (PKG_CONFIG_FOUND)
      pkg_check_modules(_BELA xenomai)
    endif (PKG_CONFIG_FOUND)
  endif (${CMAKE_MAJOR_VERSION} EQUAL 2 AND ${CMAKE_MINOR_VERSION} EQUAL 4)
  find_path(BELA_INCLUDE_DIR
    NAMES
      BeagleRT.h
    PATHS
      ${_BELA_INCLUDEDIR}
      /root/BeagleRT/include
      /usr/include
      /usr/local/include
      /opt/local/include
      /sw/include
  )
  
  find_library(BELA_LIBRARY
    NAMES
      xenomai
    PATHS
      ${_BELA_LIBDIR}
      /usr/xenomai/lib
      /usr/lib
      /usr/local/lib
      /opt/local/lib
      /sw/lib
  )

  if (BELA_LIBRARY)
    set(BELA_FOUND TRUE)
  endif (BELA_LIBRARY)

  set(BELA_INCLUDE_DIRS
    ${BELA_INCLUDE_DIR}
  )

  if (BELA_INCLUDE_DIRS)
     set(BELA_FOUND TRUE)
  endif (BELA_INCLUDE_DIRS)

  if (BELA_FOUND)
    if (NOT BELA_FIND_QUIETLY)
      message(STATUS "Found xenomai: ${BELA_LIBRARY}")
    endif (NOT BELA_FIND_QUIETLY)
  else (BELA_FOUND)
    if (BELA_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find BELA")
    endif (BELA_FIND_REQUIRED)
  endif (BELA_FOUND)

  # show the BELA_INCLUDE_DIRS variables only in the advanced view
  mark_as_advanced(BELA_INCLUDE_DIRS)

endif (BELA_INCLUDE_DIRS)
