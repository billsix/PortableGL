cmake_minimum_required(VERSION 3.0)

project(portablegl LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

set( SDL_STATIC ON CACHE BOOL "" FORCE )
set( SDL_SHARED OFF CACHE BOOL "" FORCE )

if(WIN32 OR APPLE)
	add_subdirectory(deps/SDL)
    	include_directories(deps/include)
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
  demos/imgui/
  demos/imgui/backends
)

add_executable(
    ex1
    examples/ex1.c
)

add_executable(
    ex2
    examples/ex2.c
)

add_executable(
    ex3
    examples/ex3.c
)

#add_executable(
#    assimp_convert
#    demos/assimp_convert.c
#)

add_executable(
    gears
    demos/gears.c
)

add_executable(
    modelviewer
    demos/modelviewer.c
    glcommon/chalfedge.c
    glcommon/cprimitives.c
)

add_executable(
    pointsprites
    demos/pointsprites.c
    glcommon/gltools.c
    glcommon/gltools.h)


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


add_executable(
    imguidemo
    demos/imgui/main.cpp
    demos/imgui/backends/imgui_impl_sdl.cpp
    demos/imgui/backends/imgui_impl_sdlrenderer.cpp
)




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

target_link_libraries(imguidemo ${LINK_LIBRARIES}
  ${PGL_SDL_LIBRARIES} )

install(TARGETS ex1 DESTINATION bin)
install(TARGETS ex2 DESTINATION bin)
install(TARGETS ex3 DESTINATION bin)
install(TARGETS gears DESTINATION bin)
install(TARGETS modelviewer DESTINATION bin)
install(TARGETS pointsprites DESTINATION bin)
install(TARGETS sphereworld DESTINATION bin)
install(TARGETS imguidemo DESTINATION bin)
install(DIRECTORY media DESTINATION share/PortableGL/media)
