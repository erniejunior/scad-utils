use<linalg.scad>
use<transformations.scad>
use<shapes.scad>
use<skin.scad>
use<easing.scad>
use<lists.scad>

function accel_deaccel(t) = 1-cos((t)*180)/2 - 0.5;

function get_center(profile) = [for (dim = [0:2]) (min([for (p=profile) vec3(p)[dim]]) + max([for (p=profile) vec3(p)[dim]]))/2];
    
function to_origin(profile) = transform(translation(get_center(profile)*-1), profile);

function interpolate(start, end, t) = (1-t) * start + t * end;

//assumes that the start_profile and end_profile are already set the the origin using to_origin
function interpolate_profiles(start_profile, end_profile, start_pos, end_pos, t_pos, t_shape) = 
    transform(
        translation(interpolate(vec3(start_pos), vec3(end_pos), t_pos)), 
        interpolate(start_profile, end_profile, t_shape)
    );

//assumes, that start_profile and end_profile have the same number of nodes
function gen_intermediates(start_profile, end_profile, steps, interpolator) = 
    let(start_normalized = to_origin(start_profile),
        end_normalized = to_origin(end_profile),
        start_pos = get_center(start_profile),
        end_pos = get_center(end_profile))
            [for (i = [0:steps-1]) let(t = i/(steps-1)) interpolate_profiles(start_normalized, end_normalized, start_pos, end_pos, t, accel_deaccel(t)) ];
                
function shifting_quality(p1, p2) = sum([for (i = [0:len(p1)-1]) norm(p1[i] - p2[i])]);        
function shifting_quality_fast(p1, p2) = norm(p1[0] - p2[0]);        

/*!
 profiles -- a list of profiles that you want to cover
 vertical_intersections -- controls the (minimal) number of nodes to be used for each profile. Only use if you need manual control over this.
 horizontal_intersections -- the number of intersections between the individual profiles to be used. 
 remove_twist -- depending on how you specify the geometry of your profiles, ther can be an ugly twist in your loft. If this flag is set, the twist is removed. Note that this slows down the computation AND does not guarantee that there are no self-intersections in really weird cases!
 fast_remove_twist -- Uses a heuristic to remove the twist which is a tiny bit faster but could give wrong results
 symmetry -- enable this flag when you feel like you need more symmetry between you low complexity profiles. Do not use with complex (many node) profiles because it can slow down the computation considerably.

 A note on the number of horizontal (along the profiles) intersections: We need at least max{ |profile1|, |profile2| } many intersections to loft between two
 profiles. No matter what you set for horizontal_intersections, it will be AT LEAST that many. If more symmetry (see symmetry flag) is required, |profile1| * |profile2| looks nicer but obviously requires more intersections and therefore more time to compute.
*/
module loft(profiles, vertical_intersections = 2, horizontal_intersections = 3, remove_twist = true, fast_remove_twist = false, symmetry = false) {
    for (i = [1:len(profiles)-1])
        loft2(profiles[i-1], profiles[i], vertical_intersections, horizontal_intersections, remove_twist, fast_remove_twist, symmetry);
}
        
module loft2(p1, p2, vertical_intersections = 2, horizontal_intersections = 3, remove_twist = true, fast_remove_twist = false, symmetry = false) {
    num_nodes = symmetry ? max(len(p1)*len(p2), horizontal_intersections) : max(len(p1), len(p2), horizontal_intersections);
    echo("num nodes", num_nodes);
    p1_aug = to_3d(augment_profile(p1, num_nodes));
    p2_aug = to_3d(augment_profile(p2, num_nodes));
    
    
    if(remove_twist) {
        p1_shiftings = [for (i = [0:num_nodes]) shift_right_d(p1_aug, i)];
        shifting_qualities = [for (shifting = p1_shiftings) fast_remove_twist ? 
            shifting_quality_fast(shifting , p2_aug) : shifting_quality(shifting , p2_aug)];
        best_shifting_pos = min_item_pos(shifting_qualities);
        best_shifting = p1_shiftings[best_shifting_pos];
        skin(gen_intermediates( best_shifting, p2_aug, vertical_intersections));
    } else {
        skin(gen_intermediates( p2_aug, p2_aug, vertical_intersections));
    }
    
}

translate([0, 0, -5]) loft([square(1), 
      transform(translation([0, 0, 5])*rotation([180,0,90]), regular(2, 50)),
      transform(translation([0, 0, 10]), [[0.5, 0.5], [0.5, -0.5], [0, -0.5], [0, 0], [-0.5, 0], [-0.5, 0.5]])], 40, symmetry = false);


