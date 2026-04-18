module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::sat {
    struct Axis has copy, drop {
        dx: u64,
        dy: u64,
        negative_dx: bool,
        negative_dy: bool,
    }

    fun dot_signed(arg0: u64, arg1: u64, arg2: &Axis) : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::new((arg0 as u128) * (arg2.dx as u128), arg2.negative_dx);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::new((arg1 as u128) * (arg2.dy as u128), arg2.negative_dy);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::add(&v0, &v1)
    }

    fun has_separating_axis(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>) : bool {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = if (v1 + 1 < v0) {
                v1 + 1
            } else {
                0
            };
            let v3 = perp_axis(*0x1::vector::borrow<u64>(arg0, v1), *0x1::vector::borrow<u64>(arg1, v1), *0x1::vector::borrow<u64>(arg0, v2), *0x1::vector::borrow<u64>(arg1, v2));
            assert!(v3.dx != 0 || v3.dy != 0, 1004);
            let (v4, v5) = project(arg2, arg3, &v3);
            let v6 = v5;
            let v7 = v4;
            let (v8, v9) = project(arg4, arg5, &v3);
            let v10 = v9;
            let v11 = v8;
            if (!projections_overlap(&v7, &v6, &v11, &v10)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun negated_sign(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed) : bool {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(arg0) != 0 && !0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::is_negative(arg0)
    }

    public fun overlaps(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>) : bool {
        sat_intersect_parts(arg0, arg1, arg2, arg3)
    }

    public fun overlaps_with_aabb(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>) : bool {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::from_vertices(arg0, arg1);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::from_vertices(arg2, arg3);
        if (!0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::intersects(&v0, &v1)) {
            return false
        };
        sat_intersect_parts(arg0, arg1, arg2, arg3)
    }

    fun perp_axis(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Axis {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::sub_u64(arg2, arg0);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::sub_u64(arg3, arg1);
        Axis{
            dx          : (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(&v1) as u64),
            dy          : (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(&v0) as u64),
            negative_dx : negated_sign(&v1),
            negative_dy : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::is_negative(&v0),
        }
    }

    fun project(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &Axis) : (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed) {
        let v0 = dot_signed(*0x1::vector::borrow<u64>(arg0, 0), *0x1::vector::borrow<u64>(arg1, 0), arg2);
        let v1 = v0;
        let v2 = v0;
        let v3 = 1;
        while (v3 < 0x1::vector::length<u64>(arg0)) {
            let v4 = dot_signed(*0x1::vector::borrow<u64>(arg0, v3), *0x1::vector::borrow<u64>(arg1, v3), arg2);
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::lt(&v4, &v1)) {
                v1 = v4;
            };
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::gt(&v4, &v2)) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun projections_overlap(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed, arg2: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed, arg3: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed) : bool {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::gt(arg1, arg2) && 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::gt(arg3, arg0)
    }

    public fun sat_intersect_parts(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>) : bool {
        validate_polygon(arg0, arg1);
        validate_polygon(arg2, arg3);
        if (has_separating_axis(arg0, arg1, arg0, arg1, arg2, arg3)) {
            return false
        };
        if (has_separating_axis(arg2, arg3, arg0, arg1, arg2, arg3)) {
            return false
        };
        true
    }

    fun validate_polygon(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 >= 3, 1001);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 1002);
    }

    // decompiled from Move bytecode v7
}

