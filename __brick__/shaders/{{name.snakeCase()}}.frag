{{#instructions}}// Specify the version of GLSL to use.
{{/instructions}}#version 460 core
{{#instructions}}
// The default precision qualifier for floats.{{/instructions}}
precision mediump float;
{{#instructions}}
// Include the Flutter-provided "FlutterFragCoord" function.
// This function returns the fragment's position in logical pixels in both in skia and impeller{{/instructions}}
#include <flutter/runtime_effect.glsl>
{{#instructions}}
// User provided inputs (uniforms){{/instructions}}
uniform vec2 uSize;
uniform sampler2D tTexture;
{{#instructions}}
// The output variable.{{/instructions}}
out vec4 fragColor;
{{#instructions}}
// A function to proceed with the main processing of the output color.{{/instructions}}
void fragment(vec2 uv, vec2 pos, inout vec4 color) {
    float red = uv.x;
    float green = uv.y;
    float blue = 1.0 - red;

    color = vec4(red, green, blue, 1.0);
}
{{#instructions}}
// The main function, the actual entrypoint of the shader{{/instructions}}
void main() { {{#instructions}}
    // Get the fragment's position in logical pixels.{{/instructions}}
    vec2 pos = FlutterFragCoord().xy;{{#instructions}}

    // Calculate the UV coordinates of the fragment.{{/instructions}}
    vec2 uv = pos / uSize;
    vec4 color;
    {{#instructions}}
    // This is the perfect place for some pre-processing{{/instructions}}
    fragment(uv, pos, color);
    {{#instructions}}
    // This is the perfect place for some post processing{{/instructions}}
    fragColor = color;
}
