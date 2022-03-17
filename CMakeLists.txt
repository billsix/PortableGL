cmake_minimum_required(VERSION 3.0)

project(portablegl LANGUAGES C)

set( SDL_STATIC ON CACHE BOOL "" FORCE )
set( SDL_SHARED OFF CACHE BOOL "" FORCE )

if(WIN32 OR APPLE)
	add_subdirectory(deps/SDL-release-2.0.16)
    	include_directories(deps/SDL-release-2.0.16/include)
        set(PGL_SDL_LIBRARIES SDL2-static SDL2main)
else()
        find_package(SDL2 REQUIRED)
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

add_executable(
    ex2
    examples/ex2.c
)

add_executable(
    ex3
    examples/ex3.c
)


find_package(PkgConfig REQUIRED)
pkg_check_modules(SDL2 REQUIRED sdl2)

include_directories(${SDL2_INCLUDE_DIR} )
target_link_libraries(ex1 dl m pthread
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(ex2 dl m pthread
  ${PGL_SDL_LIBRARIES} )

target_link_libraries(ex3 dl m pthread
  ${PGL_SDL_LIBRARIES} )

install(TARGETS ex1 DESTINATION bin)
install(TARGETS ex2 DESTINATION bin)
install(TARGETS ex3 DESTINATION bin)
