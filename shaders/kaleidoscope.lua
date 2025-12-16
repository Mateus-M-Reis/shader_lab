return lovr.graphics.newShader([[

  vec4 lovrmain() {
    // Expand plane from [-0.5,0.5] → [-1,1]
    vec2 pos = VertexPosition.xy * 2.0;

    // Write directly to clip space
    return vec4(pos, 0.0, 1.0);
  }

]], [[

  vec3 palette(float t) {
    vec3 a = vec3(0.5);
    vec3 b = vec3(0.5);
    vec3 c = vec3(1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b * cos(6.28318 * (c * t + d));
  }

  vec4 lovrmain() {
    // Normalize UV to [-1,1], adjusted for aspect ratio
    vec2 uv = (UV * 2.0 - 1.0) * vec2(Resolution.x / Resolution.y, 1.0);
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i < 4.0; i++) {
      uv = fract(uv * 1.5) - 0.5;

      float d = length(uv) * exp(-length(uv0));
      vec3 col = palette(length(uv0) + i * 0.4 + Time * 0.4);

      d = sin(d * 8.0 + Time) / 8.0;
      d = abs(d);
      d = pow(0.01 / d, 1.2);
      finalColor += col * d;
    }

    return vec4(finalColor, 1.0);
  }

]])
