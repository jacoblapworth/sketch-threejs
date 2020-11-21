attribute vec3 position;
attribute vec2 uv;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform vec3 cameraPosition;
uniform float time;

varying vec2 vUv;
varying float vEdge;

void main(void) {
  // coordinate transformation
  vec4 mPosition = modelMatrix * vec4(position, 1.0);

  float angleToCamera = acos(dot(normalize(cameraPosition), normalize(mPosition.xyz)));

  vUv = uv;
  vEdge = smoothstep(0.4, 1.0, abs(sin(angleToCamera)));

  gl_Position = projectionMatrix * viewMatrix * mPosition;
}
