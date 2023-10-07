//By Kyra July 2023
//Tested in Godot 4.1
//Made with help from Blackle Mori at suricrasia.online

shader_type spatial;

uniform sampler2D albedo;

uniform int directions = 1; //The number of direction frames on the sheet

uniform int frame_count = 1; //The number of animation frames on the sheet

instance uniform int frame = 0; //The animation frame to display

void vertex() {
    MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
        vec4(normalize(cross(vec3(0.0, 1.0, 0.0), INV_VIEW_MATRIX[2].xyz)), 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
        MODEL_MATRIX[3]
    );
    vec3 direction_to_camera = normalize(CAMERA_POSITION_WORLD-NODE_POSITION_WORLD);
    float angle_to_camera_y = atan(direction_to_camera.x,direction_to_camera.z);
    vec4 model_direction = MODEL_MATRIX*vec4(1.0,0.0,0.0,0.0);
    float y_angle = atan(model_direction.x,model_direction.z)-PI;
    float final_angle_y = angle_to_camera_y-y_angle;
    float int_y_angle = round((final_angle_y/TAU)*float(directions))/float(directions);
    float final_frame = float( frame ) / float( frame_count );
    UV /= vec2( float( directions ), float( frame_count ) );
    UV += vec2( int_y_angle, final_frame );
}

void fragment() {
    vec4 albedo_tex = texture(albedo,UV);
    ALPHA_SCISSOR_THRESHOLD = 0.5;
    ALPHA = albedo_tex.a;
    ALBEDO = albedo_tex.rgb;
}