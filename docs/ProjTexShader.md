[Back To Main Page](README.md)

[Back To Plugins](Plugins.md)

# ProjTex Shader

It's a shader plugin, that has been developed to support projected textures on a mesh with masking and special features of composition toolkit and moRenderer

Common features:

 * Project up to 5 textures into mesh in a line of original diffuse texture
 * Color correction (brightness, saturation, contrast), color blend
 * Wide number of blend modes for projections and color correction
 * Support for transparency channel
 * Shading (flat, phong, toon, matte)
 * Support for render into mask (for composition toolkit)
 * Support to render into layers (Background, Main, Secondary for composition Toolkit)

## How to use projector

For projection you need to place a camera model in the scene. Then assign some image as a foreground camera plane image.

This shader works with the FX_ColorCorrection, FX_Shading, FX_ProjectiveMapping shaders. 

You can manipulate a shader by using a shader UI panel in navigator or using properties view.
