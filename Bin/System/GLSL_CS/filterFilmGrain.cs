
//////////////////////////////////////////////////////////////////////////////////////////////////
//
// file: filterFilmGrain.cs
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

#include "misc_masking.cs"

uniform float 		timer;

const float permTexUnit = 1.0/256.0;		// Perm texture texel-size
const float permTexUnitHalf = 0.5/256.0;	// Half perm texture texel-size

uniform float grainamount; // = 0.05; //grain amount
uniform float colored; // = false; //colored noise?
uniform float coloramount; // = 0.6;
uniform float grainsize; // = 1.6; //grain particle size (1.5 - 2.5)
uniform float lumamount; // = 1.0; //
    
//a random texture generator, but you can also use a pre-computed perturbation texture
vec4 rnm(in vec2 tc) 
{
    float noise =  sin(dot(tc + vec2(timer,timer),vec2(12.9898,78.233))) * 43758.5453;

	float noiseR =  fract(noise)*2.0-1.0;
	float noiseG =  fract(noise*1.2154)*2.0-1.0; 
	float noiseB =  fract(noise*1.3453)*2.0-1.0;
	float noiseA =  fract(noise*1.3647)*2.0-1.0;
	
	return vec4(noiseR,noiseG,noiseB,noiseA);
}

float fade(in float t) {
	return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float pnoise3D(in vec3 p)
{
	vec3 pi = permTexUnit*floor(p)+permTexUnitHalf; // Integer part, scaled so +1 moves permTexUnit texel
	// and offset 1/2 texel to sample texel centers
	vec3 pf = fract(p);     // Fractional part for interpolation

	// Noise contributions from (x=0, y=0), z=0 and z=1
	float perm00 = rnm(pi.xy).a ;
	vec3  grad000 = rnm(vec2(perm00, pi.z)).rgb * 4.0 - 1.0;
	float n000 = dot(grad000, pf);
	vec3  grad001 = rnm(vec2(perm00, pi.z + permTexUnit)).rgb * 4.0 - 1.0;
	float n001 = dot(grad001, pf - vec3(0.0, 0.0, 1.0));

	// Noise contributions from (x=0, y=1), z=0 and z=1
	float perm01 = rnm(pi.xy + vec2(0.0, permTexUnit)).a ;
	vec3  grad010 = rnm(vec2(perm01, pi.z)).rgb * 4.0 - 1.0;
	float n010 = dot(grad010, pf - vec3(0.0, 1.0, 0.0));
	vec3  grad011 = rnm(vec2(perm01, pi.z + permTexUnit)).rgb * 4.0 - 1.0;
	float n011 = dot(grad011, pf - vec3(0.0, 1.0, 1.0));

	// Noise contributions from (x=1, y=0), z=0 and z=1
	float perm10 = rnm(pi.xy + vec2(permTexUnit, 0.0)).a ;
	vec3  grad100 = rnm(vec2(perm10, pi.z)).rgb * 4.0 - 1.0;
	float n100 = dot(grad100, pf - vec3(1.0, 0.0, 0.0));
	vec3  grad101 = rnm(vec2(perm10, pi.z + permTexUnit)).rgb * 4.0 - 1.0;
	float n101 = dot(grad101, pf - vec3(1.0, 0.0, 1.0));

	// Noise contributions from (x=1, y=1), z=0 and z=1
	float perm11 = rnm(pi.xy + vec2(permTexUnit, permTexUnit)).a ;
	vec3  grad110 = rnm(vec2(perm11, pi.z)).rgb * 4.0 - 1.0;
	float n110 = dot(grad110, pf - vec3(1.0, 1.0, 0.0));
	vec3  grad111 = rnm(vec2(perm11, pi.z + permTexUnit)).rgb * 4.0 - 1.0;
	float n111 = dot(grad111, pf - vec3(1.0, 1.0, 1.0));

	// Blend contributions along x
	vec4 n_x = mix(vec4(n000, n001, n010, n011), vec4(n100, n101, n110, n111), fade(pf.x));

	// Blend contributions along y
	vec2 n_xy = mix(n_x.xy, n_x.zw, fade(pf.y));

	// Blend contributions along z
	float n_xyz = mix(n_xy.x, n_xy.y, fade(pf.z));

	// We're done, return the final noise value.
	return n_xyz;
}

//2d coordinate orientation thing
vec2 coordRot(in vec2 tc, in float angle)
{
	float aspect = outputSize.x/outputSize.y;
	float rotX = ((tc.x*2.0-1.0)*aspect*cos(angle)) - ((tc.y*2.0-1.0)*sin(angle));
	float rotY = ((tc.y*2.0-1.0)*cos(angle)) + ((tc.x*2.0-1.0)*aspect*sin(angle));
	rotX = ((rotX/aspect)*0.5+0.5);
	rotY = rotY*0.5+0.5;
	return vec2(rotX,rotY);
}

void main (void)
{
	ivec2 pixelPosition = ivec2(gl_GlobalInvocationID.xy);
	vec2 texCoord = vec2(outputSize.x * (0.5 + pixelPosition.x), outputSize.y * (0.5 + pixelPosition.y));
	
#ifdef SAME_SIZE
	vec4 srccolor = texelFetch(colorSampler, pixelPosition, 0);
#else
	// do some scaling with bilinear filtering
	vec4 srccolor = texture(colorSampler, texCoord );
#endif
	
	float width = 1.0/outputSize.x;
	float height = 1.0/outputSize.y;
	
	vec3 rotOffset = vec3(1.425,3.892,5.835); //rotation offset values	
	vec2 rotCoordsR = coordRot(texCoord, timer + rotOffset.x);
	vec3 noise = vec3(pnoise3D(vec3(rotCoordsR*vec2(width/grainsize,height/grainsize),0.0)));
  
	if (colored > 0.0)
	{
		vec2 rotCoordsG = coordRot(texCoord, timer + rotOffset.y);
		vec2 rotCoordsB = coordRot(texCoord, timer + rotOffset.z);
		noise.g = mix(noise.r,pnoise3D(vec3(rotCoordsG*vec2(width/grainsize,height/grainsize),1.0)),coloramount);
		noise.b = mix(noise.r,pnoise3D(vec3(rotCoordsB*vec2(width/grainsize,height/grainsize),2.0)),coloramount);
	}

	vec3 col = srccolor.rgb;

	//noisiness response curve based on scene luminance
	vec3 lumcoeff = vec3(0.299,0.587,0.114);
	float luminance = mix(0.0,dot(col, lumcoeff),lumamount);
	float lum = smoothstep(0.2,0.0,luminance);
	lum += luminance;
	
	
	noise = mix(noise,vec3(0.0),pow(lum,4.0));
	col = col+noise*grainamount;
	
	vec4 outColor = ApplyMask(texCoord, srccolor, vec4(col, srccolor.a));
	imageStore(resultImage, pixelPosition, outColor);	
}
