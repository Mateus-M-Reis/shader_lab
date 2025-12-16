return lovr.graphics.newShader([[
  out vec2 var_texcoord0;

  vec4 lovrmain() {
    // Expand plane from [-0.5,0.5] → [-1,1]
    vec2 pos = VertexPosition.xy * 2.0;
    
    // Write directly to clip space
    gl_Position = vec4(pos, 0.0, 1.0);
    
    // Pass normalized UV coordinates
    var_texcoord0 = VertexPosition.xy + 0.5;
    
    return gl_Position;
  }

]], [[
  // Star Nest by Pablo Román Andrioli - LÖVR Version
  // This content is under the MIT License.
  
  #define iterations 17
  #define formuparam 0.53
  #define volsteps 20
  #define stepsize 0.1
  #define zoom   0.800
  #define tile   0.850
  #define speed  0.005
  #define brightness 0.0015
  #define darkmatter 0.300
  #define distfading 0.730
  #define saturation 0.850

  in vec2 var_texcoord0;

  vec4 lovrmain() {
      vec2 uv = var_texcoord0;
      
      // Adjust for aspect ratio using built-in Resolution
      float aspect = Resolution.x / Resolution.y;
      vec2 res = vec2(aspect, 1.0);
      vec2 uv2 = uv * res.xy - res * 0.5;
      
      vec3 dir = vec3(uv2 * zoom, 1.0);
      float time = Time * speed + 0.25;

      float a1 = 0.5;
      float a2 = 0.8;
      mat2 rot1 = mat2(cos(a1), sin(a1), -sin(a1), cos(a1));
      mat2 rot2 = mat2(cos(a2), sin(a2), -sin(a2), cos(a2));
      dir.xz *= rot1;
      dir.xy *= rot2;
      
      vec3 from = vec3(1.0, 0.5, 0.5);
      from += vec3(0, time, -2.0);
      from.xz *= rot1;
      from.xy *= rot2;
      
      float s = 0.1, fade = 1.0;
      vec3 v = vec3(0.0);
      
      for(int r = 0; r < volsteps; r++) {
          vec3 p = from + s * dir * 0.5;
          p = abs(vec3(tile) - mod(p, vec3(tile * 2.0)));
          float pa, a = pa = 0.0;
          
          for (int i = 0; i < iterations; i++) { 
              p = abs(p) / dot(p, p) - formuparam;
              a += abs(length(p) - pa);
              pa = length(p);
          }
          
          float dm = max(0.0, darkmatter - a * a * 0.001);
          a *= a * a;
          
          if(r > 6) fade *= 1.0 - dm;
          v += fade;
          v += vec3(s, s * s, s * s * s * s) * a * brightness * fade;
          fade *= distfading; 
          s += stepsize;
      }
      
      v = mix(vec3(length(v)), v, saturation);
      return vec4(v * 0.01, length(v) * 0.25);
  }
]])
