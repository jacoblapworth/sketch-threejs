import * as THREE from 'three';
import MathEx from 'js-util/MathEx';

import vs from './glsl/typo.vs';
import fs from './glsl/typo.fs';

export default class Typo extends THREE.Mesh {
  constructor() {
    // Define Geometry
    const geometry = new THREE.PlaneBufferGeometry(20, 10);

    // Define Material
    const material = new THREE.RawShaderMaterial({
      uniforms: {
        time: {
          type: 'f',
          value: 0
        },
        texture: {
          type: 't',
          value: null
        },
        textureNoise: {
          type: 't',
          value: null
        },
      },
      vertexShader: vs,
      fragmentShader: fs,
      transparent: true,
    });

    // Create Object3D
    super(geometry, material);
    this.name = 'Mesh';
  }
  start(texture, textureNoise) {
    this.material.uniforms.texture.value = texture;
    this.material.uniforms.textureNoise.value = textureNoise;
  }
  update(time) {
    this.material.uniforms.time.value += time;
  }
}
