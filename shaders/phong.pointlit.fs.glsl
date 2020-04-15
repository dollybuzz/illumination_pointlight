precision mediump float;

uniform vec3 uLightPosition;
uniform vec3 uCameraPosition;
uniform sampler2D uTexture;

varying vec2 vTexcoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;

void main(void) {
    
    // todo - diffuse contribution
    // 1. normalize the light direction and store in a separate variable
    vec3 nLightDirection = normalize(uLightPosition - vWorldPosition);
    // 2. normalize the world normal and store in a separate variable
    vec3 nWorldNormal = normalize(vWorldNormal);
    // 3. calculate the lambert term
    float lambertian = max(dot(nWorldNormal, nLightDirection), 0.0);

    // todo - specular contribution
    // 1. in world space, calculate the direction from the surface point to the eye (normalized)
    //note - normalize(to-from)
    vec3 eyeDirection = normalize(uCameraPosition - vWorldPosition);
    // 2. in world space, calculate the reflection vector (normalized)
    vec3 reflectionDirection = normalize(reflect(-nLightDirection, nWorldNormal));
    // 3. calculate the phong term
    float specularPow = 64.0;
    float specularAngle = dot(eyeDirection, reflectionDirection);
    if (specularAngle < 0.0)
    {
        specularAngle = 0.0;
    }
    float phong = pow(specularAngle, specularPow);

    vec3 albedo = texture2D(uTexture, vTexcoords).rgb;

    // todo - combine
    // 1. apply light and material interaction for diffuse value by using the texture color as the material
    vec3 diffuseValue = texture2D(uTexture, vTexcoords).rgb * lambertian;    
    // 2. apply light and material interaction for phong, assume phong material color is (0.3, 0.3, 0.3)
    vec3 specularColorMat = texture2D(uTexture, vTexcoords).rgb * phong;

    vec3 ambient = albedo * 0.1;
    vec3 diffuseColor = diffuseValue;
    vec3 specularColor = specularColorMat;
    vec3 finalColor = ambient + diffuseColor + specularColor;

    gl_FragColor = vec4(finalColor, 1.0);
}

