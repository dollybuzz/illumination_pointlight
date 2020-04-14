precision mediump float;

uniform vec3 uLightDirection;
uniform vec3 uCameraPosition;
uniform sampler2D uTexture;

varying vec2 vTexcoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;

void main(void) {
    // todo - diffuse contribution
    // 1. normalize the light direction and store in a separate variable
    vec3 nLightDirection = normalize(uLightDirection);
    // 2. normalize the world normal and store in a separate variable
    vec3 nWorldNormal = normalize(vWorldNormal);
    // 3. calculate the lambert term
    float lambertian = max(dot(nWorldNormal, nLightDirection), 0.0);

    // todo - specular contribution
    // 1. in world space, calculate the direction from the surface point to the eye (normalized)
    //note - normalize(to-from)
    vec3 nEyeDirection = normalize(uCameraPosition - vWorldPosition);
    // 2. in world space, calculate the reflection vector (normalized)
    vec3 nReflectionDirection = normalize(reflect(-nLightDirection, nWorldNormal));
    // 3. calculate the phong term

    vec3 albedo = texture2D(uTexture, vTexcoords).rgb;

    // todo - combine
    // 1. apply light and material interaction for diffuse value by using the texture color as the material
    // 2. apply light and material interaction for phong, assume phong material color is (0.3, 0.3, 0.3)

    vec3 ambient = albedo * 0.1;
    // vec3 diffuseColor = todo;
    // vec3 specularColor = todo;
    vec3 finalColor = ambient; // + diffuseColor + specularColor;

    gl_FragColor = vec4(nEyeDirection, 1.0);
}
