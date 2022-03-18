cmake_minimum_required(VERSION 3.0)

project(portablegl LANGUAGES C CXX)

set( SDL_STATIC ON CACHE BOOL "" FORCE )
set( SDL_SHARED OFF CACHE BOOL "" FORCE )

if(WIN32 OR APPLE)
	add_subdirectory(deps/SDL-release-2.0.16)
    	include_directories(deps/SDL-release-2.0.16/include)
        set(PGL_SDL_LIBRARIES SDL2-static SDL2main)
else()
	find_package(PkgConfig REQUIRED)
	pkg_check_modules(SDL2 REQUIRED sdl2)
        set(PGL_SDL_LIBRARIES ${SDL2_LIBRARIES})
endif(WIN32 OR APPLE)



include_directories(src/
  ./
  ./glcommon/
  ${SDL2_INCLUDE_DIRS}
  )

add_executable(
    ex1
    examples/ex1.c
)
set_property(TARGET ex1 PROPERTY C_STANDARD 11)

add_executable(
    ex2
    examples/ex2.c
)
set_property(TARGET ex2 PROPERTY C_STANDARD 11)

add_executable(
    ex3
    examples/ex3.c
)
set_property(TARGET ex3 PROPERTY C_STANDARD 11)

#add_executable(
#    assimp_convert
#    demos/assimp_convert.c
#)
#set_property(TARGET assimp_convert PROPERTY C_STANDARD 11)

add_executable(
    gears
    demos/gears.c
)
set_property(TARGET gears PROPERTY C_STANDARD 11)

add_executable(
    modelviewer
    demos/modelviewer.c
    glcommon/chalfedge.c
    glcommon/cprimitives.c
)
set_property(TARGET modelviewer PROPERTY C_STANDARD 11)

add_executable(
    pointsprites
    demos/pointsprites.c
    glcommon/gltools.c
    glcommon/gltools.h)

set_property(TARGET pointsprites PROPERTY C_STANDARD 11)

add_executable(
    sphereworld
    demos/sphereworld.cpp
    glcommon/rsw_math.cpp
    glcommon/rsw_glframe.cpp
    glcommon/rsw_primitives.cpp
    glcommon/gltools.cpp
    glcommon/rsw_halfedge.cpp
    glcommon/controls.cpp
    glcommon/c_utils.cpp)
set_property(TARGET sphereworld PROPERTY CMAKE_CXX_STANDARD 14)



if(WIN32 OR APPLE)
        set(LINK_LIBRARIES )
else()
        set(LINK_LIBRARIES dl m pthread)
endif(WIN32 OR APPLE)


include_directories(${SDL2_INCLUDE_DIR} )
target_link_libraries(ex1 ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(ex2 ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(ex3 ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

#target_link_libraries(assimp_convert ${LINK_LIBRARIES}
#  ${PGL_SDL_LIBRARIES} )

target_link_libraries(gears ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(modelviewer ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(pointsprites ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(sphereworld ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

install(TARGETS ex1 DESTINATION bin)
install(TARGETS ex2 DESTINATION bin)
install(TARGETS ex3 DESTINATION bin)
install(TARGETS gears DESTINATION bin)
install(TARGETS modelviewer DESTINATION bin)
install(TARGETS pointsprites DESTINATION bin)
install(TARGETS sphereworld DESTINATION bin)
