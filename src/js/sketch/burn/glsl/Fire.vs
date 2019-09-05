attribute vec3 position;
attribute vec2 uv;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform float time;
uniform float duration;
uniform vec2 imgRatio;
uniform sampler2D texNoise;

varying vec3 vPosition;
varying vec2 vUv;
varying float vTime;

void main(void) {
  float t = mod(time / duration, 1.0);

  vec2 updateUv = uv * imgRatio + vec2(
    (1.0 - imgRatio.x) * 0.5,
    (1.0 - imgRatio.y) * 0.5
    );

  float noiseR = texture2D(texNoise, updateUv + vec2(time * 0.1, 0.0)).r;
  float noiseG = texture2D(texNoise, updateUv + vec2(time * 0.2, 0.0)).g;
  float slide = texture2D(texNoise, uv * vec2(0.998) + 0.001).b;

  float mask = t * 1.12 - (slide * 0.6 + noiseR * 0.2 + noiseG * 0.2);
  float maskPrev = smoothstep(0.0, 0.04, mask);
  float maskNext = 1.0 - smoothstep(0.0, 0.2, mask);
  float height = maskNext * 14.0;

  // coordinate transformation
  vec4 mPosition = modelMatrix * vec4(position + vec3(0.0, 0.0, height), 1.0);

  vPosition = mPosition.xyz;
  vUv = uv;
  vTime = t;

  gl_Position = projectionMatrix * viewMatrix * mPosition;
}