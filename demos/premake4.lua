-- A solution contains projects, and defines the available configurations
solution "Demos"
	configurations { "Debug", "Release" }
	
	includedirs { "../", "../glcommon", "/usr/include/SDL2" }

	-- stuff up here common to all projects
	kind "ConsoleApp"
	--location "build"
	--targetdir "build"
	targetdir "."

	configuration "linux"
		links { "SDL2", "m" }
	
	configuration "windows"
		--linkdir "/mingw64/lib"
		--buildoptions "-mwindows"
		links { "mingw32", "SDL2main", "SDL2" }

	configuration "Debug"
		defines { "DEBUG" }
		flags { "Symbols" }

	configuration "Release"
		defines { "NDEBUG" }
		flags { "Optimize" }

	configuration { "gmake", "Release" }
	buildoptions { "-O3" }

	-- A project defines one build target
	project "swrenderer"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./main.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_glframe.cpp",
			"../glcommon/rsw_primitives.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/controls.cpp",
			"../glcommon/c_utils.cpp"
		}

	project "sphereworld"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./sphereworld.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_glframe.cpp",
			"../glcommon/rsw_primitives.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/rsw_halfedge.cpp",
			"../glcommon/controls.cpp",
			"../glcommon/c_utils.cpp"
		}

	project "sphereworld_color"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./sphereworld_color.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_glframe.cpp",
			"../glcommon/rsw_primitives.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/rsw_halfedge.cpp",
			"../glcommon/controls.cpp",
			"../glcommon/c_utils.cpp"
		}

	project "cubemap"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./cubemap.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_primitives.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/rsw_glframe.cpp",
			"../glcommon/stb_image.h"
		}

	project "grass"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./grass.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_glframe.cpp"
		}

	project "gears"
		language "C"
		configuration { "gmake" }
			buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./gears.c"
		}

	project "modelviewer"
		language "C"
		configuration { "gmake" }
			buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./modelviewer.c",
			"../glcommon/chalfedge.c",
			"../glcommon/cprimitives.c"
		}

	project "pointsprites"
		language "C"
		configuration { "gmake" }
			buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }
		files {
			"./pointsprites.c",
			"../glcommon/gltools.c",
			"../glcommon/gltools.h"
		}

	project "shadertoy"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type", "-fopenmp" }
			links { "SDL2", "m", "gomp" }
		files {
			"./shadertoy.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/stb_image.h"
		}

	project "raytracing_1weekend"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type", "-fopenmp" }
			links { "SDL2", "m", "gomp" }
		files {
			"./raytracing_1weekend.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/stb_image.h"
		}

	project "texturing"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type", "-fopenmp" }
			links { "SDL2", "m", "gomp" }
		files {
			"./texturing.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/gltools.cpp",
			"../glcommon/stb_image.h"
		}

	project "multidraw"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
			links { "SDL2", "m" }
		files {
			"./multidraw.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_matstack.h",
		}

	project "testprimitives"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
			links { "SDL2", "m" }
		files {
			"./testprimitives.cpp",
			"../glcommon/rsw_math.cpp",
			"../glcommon/rsw_halfedge.cpp",
			"../glcommon/rsw_primitives.cpp",
		}

	project "sdl_renderer_imgui"
		language "C++"
		configuration { "gmake" }
			buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type", "-fopenmp" }
			links { "SDL2", "m", "gomp" }
		includedirs { "./imgui", "./imgui/backends" }
		files {
			"./imgui/main.cpp",
			--"./imgui/imgui.cpp",
			--"./imgui/imgui_demo.cpp",
			--"./imgui/imgui_draw.cpp",
			--"./imgui/imgui_tables.cpp",
			--"./imgui/imgui_widgets.cpp",
			"./imgui/backends/imgui_impl_sdl.cpp",
			"./imgui/backends/imgui_impl_sdlrenderer.cpp"
		}


	project "assimp_convert"
		language "C"
		files {
			"./assimp_convert.c",
		}

		links { "assimp", "m"}

		configuration { "gmake" }
		buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }

		configuration { "gmake", "Release" }
		buildoptions { "-O3" }
