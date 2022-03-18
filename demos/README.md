Demos
=====

This is where everything that doesn't fit into examples goes.  Basically
a free for all of me experimenting and having fun.

ESC will exit all of them.

Flying controls = 6DOF flying controls ala Descent. Mouse + WASDQE + LShift + Space

If you run any of these and they don't look like the screenshots and you can't
figure out why, please let me know by opening an issue, thanks!

### Gears

![gears](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/gears.png)

This is a straight conversion of the well knows [gears demo](https://cgit.freedesktop.org/mesa/demos/tree/src/egl/opengles2/es2gears.c),
via a conversion to OpenGL 3.3 in my [opengl_reference](https://github.com/rswinkle/opengl_reference/blob/master/src/gears.c)
repo.  Controls are the arrow keys to rotate the gears, and I added 'p' to toggle polygon mode.

### Grass

![grass](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/grass.png)

This is an incomplete port of the instanced rendering
[grass demo](https://github.com/rswinkle/oglsuperbible5/blob/1a92eb6b4eeb665582acd69bc41ba793ff974bd1/Src/Chapter12/Grass/Grass.cpp)
from Superbible 5.  Flying controls.

### Modelviewer

![modelviewer](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/modelviewer.png)

This demonstrates gouraud and phong shading with a single directional light.  It will load one of the models in ./media/models if it's passed
as a command line argument, otherwise it generates a sphere.  The model then rotates counter clockwise.  's' and 'p' to switch between shaders
and polygon modes.  The program assimp_convert will, if you have libassimp installed and can compile it, convert other model formats to the plain
text format modelviewer reads.  Be aware you might have to scale and translate them to make them visible.  The stanford models provided are
already centered.

### Texturing

![texturing1](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/texturing1.png)
![texturing2](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/texturing2.png)
![texturing3](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/texturing3.png)
![texturing4](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/texturing4.png)

What it says on the tin.  Arrow keys to zoom/rotate, 1 to switch between 5 textures, 'f' to switch between GL_NEAREST and GL_LINEAR. Note,
PortableGL doesn't actually use min_filter.  You can set it, but only mag_filter is used in all the texel access functions.
The fourth texture is a texture array (a GIF of Nathan Fillion from "Two Guys and a Girl" if you were wondering).
You can't really tell the difference between the filtering options on the gif, I hope because the quality is so low/GIF artifacts and
not because of a bug.  The last texture is a GL_TEXTURE_RECTANGLE, though obviously there's no visible difference, just making sure
it works.

### Pointsprites

![pointsprites](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/pointsprites.png)

This draws 3 large pointsprites, making 2 targets using 1 shader, and creating a disolving textured point with a different shader that shows
how multitexturing works.  There is no glActiveTexture or texture units in PortableGL.  Shaders access textures by the handles
returned from glGenTextures.  It's much more convenient imo.

### Cubemap

![cubemap](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/cubemap.png)

This uses a cubemap texture to create the reflective sphere + skybox demo.  Partial flying controls (WASD + mouse).
Unfortunately there is a bug that I've never bothered to track down so when you look around, the skybox wobbles.  Just moving has no effect,
only turning with the mouse which makes sense since the skybox is "infinitely" distant iirc.  It's likely that the problem is with the application code, and not
PortableGL given that the sphere looks fine meaning the cubemap sampling is correct.

### Sphereworld

![sphereworld](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/sphereworld.png)

Another demo from [Superbible 5](https://github.com/rswinkle/oglsuperbible5/blob/1a92eb6b4eeb665582acd69bc41ba793ff974bd1/Src/Chapter05/Sphereworld/Sphereworld.cpp)
but with better controls and a slightly different shader and light direction.  The controls are shown in the commandline on startup (read from a user editable
controls.config file).  This is also, along with swrenderer, one of 3 current demos that show one way to resize the window, by calling pglResizeFramebuffer so the resolution always
matches the window size.  The other simpler more performant way is to let SDL2 scale for
you like I do with shadertoy and raytracing_1wekend.

### Sphereworld Color

![sphereworld_color](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/sphereworld_color.png)

Similar to Sphereworld, but with fewer controls (just 6DOF + mouse + tilt) and using colors not textures naturally.  This one does let you switch
between gouraud and phong shading, with the semi-interesting result that the latter actually has better performance.

### Shadertoy

![shadertoy1](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy1.png)
![shadertoy2](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy2.png)
![shadertoy3](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy3.png)
![shadertoy4](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy4.png)
![shadertoy5](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy5.png)
![shadertoy6](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy6.png)
![shadertoy7](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy7.png)
![shadertoy8](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/shadertoy8.png)

This is basically a standalone reimplementation of the graphical component of [shadertoy.com](https://www.shadertoy.com/).
Use the left and right arrow keys to cycle through 11 different shaders, roughly in order of increasing complexity and
decreasing performance.  I include links/attribution in the comments above the shaders taken directly from shadertoy.com
if you want to see them in their full glory.

Originaly, it used the normal method of drawing 2 triangles that fill the screen (and you can still see that code commented out)
but making this in PortableGL meant I could add an extension, pglDrawFrame(), for this special use case that
bypasses the vertex shader entirely and just sets everything up the way shadertoy shaders need things.  Unfortunately, it doesn't
increase frame rate as much as I'd hoped so I ended up changing the resolution to 320x240 get "bearable" framerates on the harder shaders.
Even so, the last few shaders can hardly be called "realtime".  Also the tunnel light one seems to have some graphical bug.

Since 320x240 is so small, especially on high-DPI monitors, I made this one resizable but unlike Sphereworld, where
I change the framebuffer (and the projection and glViewport) to match, here I just let SDL2 scale the texture; it's slower
than leaving the window at the small size but *much* faster than actually rendering at a higher resolution.

Also, if you want to play with a real standalone shadertoy (with live updating) that uses actual OpenGL and hardware acceleration, here are
[two](https://github.com/rswinkle/shadertoy) [options](https://github.com/githole/Live-Coder).

### Swrenderer

![swrenderer1](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/swrenderer1.png)
![swrenderer2](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/swrenderer2.png)

I need to think of a better name for this.  This dates back to the *very* beginning of this project, based off of a tutorial.  That's why it's main.cpp.
Basically, for the longest time this was where I tested each new feature I added.  So this has interpolation, textures, depth test toggle, and a pseudo-
render to texture that's really just an extra manual copy via TexSubImage2D after the first pass.  There are also multiple methods of doing things
commented out.  Same controls as Sphereworld and 1 to switch between textures (only seen when you're using the texture shader, switched to with 's').

TODO: I use dvorak, so I need to make a controls.config for QWERTY for others' convenience though it's not hard to edit the file by hand.


### Raytracing_1weekend

![raytracing_1weekend](https://raw.githubusercontent.com/rswinkle/PortableGL/master/media/screenshots/raytracing_1weekend.png)

This is an adaptation of the code from ["Ray Tracing In One Weekend"](https://raytracing.github.io/) book to PortableGL, using the same pglDrawFrame extension
I use for shadertoy.  Mostly I just did it for fun since I've never written
a raytracer but I plan to continue playing with it, cleaning it up, and
moving useful pieces (with my own changes/preferences) into crsw_math and rsw_math.

Currently there are no controls (yet) but there are optional command line args to control
the number of samples and the max depth of reflection recursion.  They default to 25
and 12 respectively, for "decent" 0.2 FPS on my desktop.

