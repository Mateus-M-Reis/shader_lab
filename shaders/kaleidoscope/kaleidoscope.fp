// texture coordinates that are set in the vertex shader
varying mediump vec2 var_texcoord0;

// uniforms that are altered by script
uniform lowp vec4 iResolution;
uniform lowp vec4 iTime;

vec3 palette(float t) {
	vec3 a = vec3(0.5, 0.5, 0.5);
	vec3 b = vec3(0.5, 0.5, 0.5);
	vec3 c = vec3(1.0, 1.0, 1.0);
	vec3 d = vec3(0.263,0.416,0.557);

	return a + b*cos( 6.28318*(c*t+d) );
}

void main()
{
	vec2 uv = (var_texcoord0 * 2.0 - 1.0) * vec2(iResolution.x/iResolution.y, 1.0);
	vec2 uv0 = uv;
	vec3 finalColor = vec3(0.0);

	for (float i = 0.0; i < 4.0; i++) {
		uv = fract(uv * 1.5) - 0.5;

		float d = length(uv) * exp(-length(uv0));

		vec3 col = palette(length(uv0) + i*.4 + iTime.x*.4);

		d = sin(d*8. + iTime.x)/8.;
		d = abs(d);

		d = pow(0.01 / d, 1.2);

		finalColor += col * d;
	}

	gl_FragColor = vec4(finalColor, 1.0);
}
