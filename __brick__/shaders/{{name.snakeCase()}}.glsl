// Specify the version of GLSL to use.
#version 460 core

// The default precision qualifier for floats.
precision mediump float;

// Include the Flutter-provided "FlutterFragCoord" function.
// This function returns the fragment's position in logical pixels in both in skia and impeller
#include <flutter/runtime_effect.glsl>

// User provided inputs (uniforms)
uniform vec2 uSize;
uniform sampler2D tTexture;

// The output variable.
out vec4 fragColor;

// A function to proceed with the main processing of the output color.
void fragment(vec2 uv, vec2 pos, inout vec4 color) {
    float red = uv.x;
    float green = uv.y;
    float blue = 1.0 - red;

    color = vec4(red, green, blue, 1.0);
}

// The main function, the actual entrypoint of the shader
void main() {
    // Get the fragment's position in logical pixels.
    vec2 pos = FlutterFragCoord().xy;
    // Calculate the UV coordinates of the fragment.
    vec2 uv = pos / uSize;

    vec4 color;

    // This is the perfect place for some pre-processing

    fragment(uv, pos, color);

    // This is the perfect place for some post processing

    fragColor = color;
}
