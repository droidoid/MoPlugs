
//////////////////////////////////////////////////////////////////////////////////////////////////
//
// file: filterBlur.cs
//
//	composition toolkit filter
//
//	Author Sergey Solokhin (Neill3d)
//
//	GitHub page - https://github.com/Neill3d/MoPlugs
//	Licensed under BSD 3-Clause - https://github.com/Neill3d/MoPlugs/blob/master/LICENSE
//
///////////////////////////////////////////////////////////////////////////////////////////////////


uniform vec2	outputSize;	// stored in a format ( 1.0/w, 1.0/h )

layout(binding=0, rgba8) uniform writeonly image2D resultImage;
layout(binding=1) 		uniform sampler2D 	colorSampler;

uniform vec4		scale;

#include "misc_masking.cs"

vec4 textureWithKernel(in sampler2D sampler, in vec2 tx)
{
	vec2 texelSize = outputSize;
	
	vec4 color, color2;
	vec4 tap0 = texture(sampler, tx);
	vec4 tap1 = texture(sampler, tx + texelSize * vec2( 0.4,  0.9));
	vec4 tap2 = texture(sampler, tx + texelSize * vec2(-0.4, -0.9));
	vec4 tap3 = texture(sampler, tx + texelSize * vec2(-0.9,  0.4));
	vec4 tap4 = texture(sampler, tx + texelSize * vec2( 0.9, -0.4));
	
	color = 0.2 * (tap0 + tap1 + tap2 + tap3 + tap4);
	
	vec4 tap11 = texture(sampler, tx + texelSize * vec2( 0.9,  1.9));
	vec4 tap21 = texture(sampler, tx + texelSize * vec2(-0.9, -1.9));
	vec4 tap31 = texture(sampler, tx + texelSize * vec2(-1.9,  0.9));
	vec4 tap41 = texture(sampler, tx + texelSize * vec2( 1.9, -0.9));
	
	color2 = 0.2 * (tap0 + tap11 + tap21 + tap31 + tap41);
	
	float mask = clamp(color2.w, 0.0, 1.0);
	
	vec4 result = vec4(color.rgb * mask + color2.rgb * (1.0-mask), mask);
	return result;
}

void main (void)
{
	ivec2 pixelPosition = ivec2(gl_GlobalInvocationID.xy);
	vec2 texCoord = vec2(outputSize.x * (0.5 + pixelPosition.x), outputSize.y * (0.5 + pixelPosition.y));

	vec2 dx  = scale.xy;
	vec2 sdx = dx;
	vec4 srccolor = textureWithKernel ( colorSampler, texCoord );
	vec4 sum = srccolor * 0.134598;

	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.127325; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.107778; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.081638; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.055335; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.033562; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.018216; 
	sdx += dx;
	sum += (textureWithKernel ( colorSampler, texCoord + sdx ) + textureWithKernel ( colorSampler, texCoord - sdx ) )* 0.008847; 
	sdx += dx;

	vec4 outColor = ApplyMask(texCoord, srccolor, sum);
	imageStore(resultImage, pixelPosition, outColor);
}
