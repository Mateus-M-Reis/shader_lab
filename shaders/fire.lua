return lovr.graphics.newShader([[
  // Vertex Shader
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
  // Fragment Shader
  mat3 rotm;

  mat3 rot(vec3 v, float angle)
  {
    float c = cos(angle);
    float s = sin(angle);

    return mat3(c + (1.0 - c) * v.x * v.x, (1.0 - c) * v.x * v.y - s * v.z, (1.0 - c) * v.x * v.z + s * v.y,
                (1.0 - c) * v.x * v.y + s * v.z, c + (1.0 - c) * v.y * v.y, (1.0 - c) * v.y * v.z - s * v.x,
                (1.0 - c) * v.x * v.z - s * v.y, (1.0 - c) * v.y * v.z + s * v.x, c + (1.0 - c) * v.z * v.z
                );
  }

  vec2 dragonkifs(vec3 p) {
    float otrap=1000.;
    float l=0.;
    for (int i=0; i<20; i++) {
      p.y*=-sign(p.x);
      p.x=abs(p.x);
      p=p*rotm*1.18-vec3(1.2);
      l=length(p);
      if (l>100.) otrap=0.;
      otrap=min(otrap,l);		
    }
    return vec2(l*pow(1.18,float(-20))*.15,clamp(otrap*.3,0.,1.));
  }

  in vec2 var_texcoord0;

  vec4 lovrmain() {
    float time = Time * 0.5;
    
    // Convert UV to normalized screen coordinates [-1, 1]
    vec2 coord = var_texcoord0 * 2.0 - vec2(1.0);
    
    // Adjust for aspect ratio
    coord.y *= Resolution.y / Resolution.x;
    
    vec3 from = 16.0 * normalize(vec3(sin(time), cos(time), 0.5 + sin(time)));
    vec3 up = vec3(1.0, sin(time * 2.0) * 0.5, 1.0);
    vec3 edir = normalize(-from);
    vec3 udir = normalize(up - dot(edir, up) * edir);
    vec3 rdir = normalize(cross(edir, udir));
    vec3 dir = normalize((coord.x * rdir + coord.y * udir) * 0.9 + edir);
    vec3 col = vec3(0.0);
    float dist = 0.0;
    
    rotm = rot(normalize(vec3(1.0)), time * 3.0);
    
    for (int r = 0; r < 120; r++) {
      vec3 p = from + dist * dir;
      vec2 d = dragonkifs(p);
      dist += max(0.02, abs(d.x));
      if (dist > 20.0) break;
      col += vec3(1.0 + d.y * 1.8, 0.5 + d.y, d.y * 0.5) * 0.125 * sign(d.y);
    }
    
    col = col * length(col) * 0.001;
    return vec4(col, 1.0);	
  }
]])
