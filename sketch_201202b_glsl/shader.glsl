#define M_PI 3.1415926535897932384626433832795

precision mediump float;
uniform float t;
uniform vec2  r;

void main(void) {
    vec2 p = (gl_FragCoord.xy * 2.0 - r) / min(r.x, r.y);
    vec3 destColor = vec3(0, 0, 0);

    for (float i = 1; i <= 4; i += 0.5) {
        float t2 = t / i;

        float theta = -t2 / 60 * 2 * M_PI;
        float radius = sin((t2 - int(t2)) * 2 * M_PI);

        float dx = p.x - cos(theta) * radius;
        float dy = p.y - sin(theta) * radius;

        float f = 0.005 * i * i * (radius + 1.5) / pow(dx * dx + dy * dy, 0.5);
        destColor += vec3(i / 8, 1 - i / 4, 0.4) * f;
    }

    gl_FragColor = vec4(destColor, 1.0);
}
