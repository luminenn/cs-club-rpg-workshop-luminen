shader_type canvas_item;

uniform vec4 color_overlay : source_color;

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, color_overlay.rgb, color_overlay.a);
}
