module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon {
    struct Part has copy, drop, store {
        xs: vector<u64>,
        ys: vector<u64>,
        aabb: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB,
    }

    struct Polygon has store, key {
        id: 0x2::object::UID,
        parts: vector<Part>,
        global_aabb: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB,
        cells: vector<u64>,
        owner: address,
        created_epoch: u64,
        total_vertices: u64,
        part_count: u64,
    }

    public fun new(arg0: vector<Part>, arg1: &mut 0x2::tx_context::TxContext) : Polygon {
        let v0 = 0x1::vector::length<Part>(&arg0);
        assert!(v0 > 0, 2001);
        assert!(v0 <= 10, 2002);
        validate_multipart_topology(&arg0);
        Polygon{
            id             : 0x2::object::new(arg1),
            parts          : arg0,
            global_aabb    : compute_global_aabb(&arg0),
            cells          : 0x1::vector::empty<u64>(),
            owner          : 0x2::tx_context::sender(arg1),
            created_epoch  : 0x2::tx_context::epoch(arg1),
            total_vertices : total_vertices(&arg0),
            part_count     : v0,
        }
    }

    public fun intersects(arg0: &Polygon, arg1: &Polygon) : bool {
        if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&arg0.global_aabb, &arg1.global_aabb)) {
            return false
        };
        let v0 = arg0.part_count;
        let v1 = arg1.part_count;
        if (v0 == 1 && v1 == 1) {
            let v2 = 0x1::vector::borrow<Part>(&arg0.parts, 0);
            let v3 = 0x1::vector::borrow<Part>(&arg1.parts, 0);
            return 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::sat::overlaps(&v2.xs, &v2.ys, &v3.xs, &v3.ys)
        };
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<Part>(&arg0.parts, v4);
            let v6 = 0;
            while (v6 < v1) {
                let v7 = 0x1::vector::borrow<Part>(&arg1.parts, v6);
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v5.aabb, &v7.aabb) && 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::sat::overlaps(&v5.xs, &v5.ys, &v7.xs, &v7.ys)) {
                    return true
                };
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        false
    }

    fun aabb_contains_or_touches(arg0: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB) : bool {
        if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(arg0) <= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(arg1)) {
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(arg0) >= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(arg1)) {
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(arg0) <= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(arg1)) {
                    0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(arg0) >= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(arg1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun area(arg0: &Polygon) : u64 {
        ((polygon_twice_area_fp2(&arg0.parts) / 2000000000000) as u64)
    }

    public(friend) fun area_fp2(arg0: &Polygon) : u128 {
        polygon_twice_area_fp2(&arg0.parts)
    }

    public(friend) fun area_fp2_from_parts(arg0: &vector<Part>) : u128 {
        polygon_twice_area_fp2(arg0)
    }

    public(friend) fun area_from_parts(arg0: &vector<Part>) : u64 {
        ((polygon_twice_area_fp2(arg0) / 2000000000000) as u64)
    }

    public(friend) fun assert_area_conserved(arg0: u128, arg1: u128) {
        assert!(arg0 == arg1, 2012);
    }

    public fun bounds(arg0: &Polygon) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB {
        arg0.global_aabb
    }

    public fun cells(arg0: &Polygon) : &vector<u64> {
        &arg0.cells
    }

    public(friend) fun checked_area_sum(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x1::u128::checked_add(arg0, arg1);
        assert!(0x1::option::is_some<u128>(&v0), 2012);
        0x1::option::destroy_some<u128>(v0)
    }

    fun compute_global_aabb(arg0: &vector<Part>) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB {
        let v0 = 0x1::vector::length<Part>(arg0);
        if (v0 == 1) {
            return 0x1::vector::borrow<Part>(arg0, 0).aabb
        };
        let v1 = 0x1::vector::borrow<Part>(arg0, 0);
        let v2 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(&v1.aabb);
        let v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(&v1.aabb);
        let v4 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(&v1.aabb);
        let v5 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(&v1.aabb);
        let v6 = 1;
        while (v6 < v0) {
            let v7 = 0x1::vector::borrow<Part>(arg0, v6);
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(&v7.aabb) < v2) {
                v2 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(&v7.aabb);
            };
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(&v7.aabb) < v3) {
                v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(&v7.aabb);
            };
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(&v7.aabb) > v4) {
                v4 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(&v7.aabb);
            };
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(&v7.aabb) > v5) {
                v5 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(&v7.aabb);
            };
            v6 = v6 + 1;
        };
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::new(v2, v3, v4, v5)
    }

    public fun contains_polygon(arg0: &Polygon, arg1: &Polygon) : bool {
        if (!aabb_contains_or_touches(&arg0.global_aabb, &arg1.global_aabb)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(&arg1.parts)) {
            if (!part_is_inside_polygon(arg0, 0x1::vector::borrow<Part>(&arg1.parts, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun contains_polygon_by_parts(arg0: &vector<Part>, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg2: &Polygon) : bool {
        if (!aabb_contains_or_touches(arg1, &arg2.global_aabb)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(&arg2.parts)) {
            if (!part_is_inside_parts(arg0, 0x1::vector::borrow<Part>(&arg2.parts, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun created_epoch(arg0: &Polygon) : u64 {
        arg0.created_epoch
    }

    public(friend) fun destroy(arg0: Polygon) {
        let Polygon {
            id             : v0,
            parts          : _,
            global_aabb    : _,
            cells          : _,
            owner          : _,
            created_epoch  : _,
            total_vertices : _,
            part_count     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun edge_length_squared(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::sub_u64(arg2, arg0);
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::sub_u64(arg3, arg1);
        let v2 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::magnitude(&v0);
        let v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::magnitude(&v1);
        assert!(v2 <= (40075017000000 as u128), 2014);
        assert!(v3 <= (40075017000000 as u128), 2014);
        v2 * v2 + v3 * v3
    }

    public(friend) fun intersects_parts_by_parts(arg0: &vector<Part>, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg2: &vector<Part>, arg3: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB) : bool {
        if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(arg1, arg3)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(arg0)) {
            let v1 = 0x1::vector::borrow<Part>(arg0, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<Part>(arg2)) {
                let v3 = 0x1::vector::borrow<Part>(arg2, v2);
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v1.aabb, &v3.aabb) && 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::sat::overlaps(&v1.xs, &v1.ys, &v3.xs, &v3.ys)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun intersects_polygon_by_parts(arg0: &vector<Part>, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg2: &Polygon) : bool {
        if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(arg1, &arg2.global_aabb)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(arg0)) {
            let v1 = 0x1::vector::borrow<Part>(arg0, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<Part>(&arg2.parts)) {
                let v3 = 0x1::vector::borrow<Part>(&arg2.parts, v2);
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v1.aabb, &v3.aabb) && 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::sat::overlaps(&v1.xs, &v1.ys, &v3.xs, &v3.ys)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_convex_vertices(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 < 3) {
            return false
        };
        let v1 = 0;
        let v2 = v1;
        let v3 = *0x1::vector::borrow<u64>(arg0, v0 - 2);
        let v4 = *0x1::vector::borrow<u64>(arg1, v0 - 2);
        let v5 = *0x1::vector::borrow<u64>(arg0, v0 - 1);
        let v6 = *0x1::vector::borrow<u64>(arg1, v0 - 1);
        let v7 = 0;
        while (v7 < v0) {
            let v8 = *0x1::vector::borrow<u64>(arg0, v7);
            let v9 = *0x1::vector::borrow<u64>(arg1, v7);
            let v10 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::cross_sign(v3, v4, v5, v6, v8, v9);
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::magnitude(&v10) == 0) {
                v3 = v5;
                v4 = v6;
                v5 = v8;
                v6 = v9;
                v7 = v7 + 1;
                continue
            };
            let v11 = if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::is_negative(&v10)) {
                1
            } else {
                2
            };
            if (v1 == 0) {
                v2 = v11;
            } else if (v1 != v11) {
                return false
            };
            v3 = v5;
            v4 = v6;
            v5 = v8;
            v6 = v9;
            v7 = v7 + 1;
        };
        v2 != 0
    }

    public fun max_parts() : u64 {
        10
    }

    public fun max_vertices_per_part() : u64 {
        64
    }

    public fun owner(arg0: &Polygon) : address {
        arg0.owner
    }

    public fun part(arg0: vector<u64>, arg1: vector<u64>) : Part {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v0) <= 40075017000000, 2013);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v0) <= 40075017000000, 2013);
            v0 = v0 + 1;
        };
        validate_part_arrays(&arg0, &arg1);
        validate_part_edges(&arg0, &arg1);
        assert!(is_convex_vertices(&arg0, &arg1), 2003);
        Part{
            xs   : arg0,
            ys   : arg1,
            aabb : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::from_vertices(&arg0, &arg1),
        }
    }

    fun part_is_inside_parts(arg0: &vector<Part>, arg1: &Part) : bool {
        let v0 = 0x1::vector::length<u64>(&arg1.xs);
        let v1 = 0;
        while (v1 < v0) {
            if (!point_inside_any_part_or_on_boundary_parts(arg0, *0x1::vector::borrow<u64>(&arg1.xs, v1), *0x1::vector::borrow<u64>(&arg1.ys, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<Part>(arg0) > 1) {
            let v2 = 0;
            while (v2 < v0) {
                let v3 = if (v2 + 1 < v0) {
                    v2 + 1
                } else {
                    0
                };
                let v4 = *0x1::vector::borrow<u64>(&arg1.xs, v2);
                let v5 = *0x1::vector::borrow<u64>(&arg1.ys, v2);
                let v6 = *0x1::vector::borrow<u64>(&arg1.xs, v3);
                let v7 = *0x1::vector::borrow<u64>(&arg1.ys, v3);
                if (!point_inside_any_part_or_on_boundary_parts_scaled(arg0, 2 * v4 + v6, 2 * v5 + v7)) {
                    return false
                };
                if (!point_inside_any_part_or_on_boundary_parts_scaled(arg0, v4 + 2 * v6, v5 + 2 * v7)) {
                    return false
                };
                v2 = v2 + 1;
            };
        };
        true
    }

    fun part_is_inside_polygon(arg0: &Polygon, arg1: &Part) : bool {
        let v0 = 0x1::vector::length<u64>(&arg1.xs);
        let v1 = 0;
        while (v1 < v0) {
            if (!point_inside_any_part_or_on_boundary(arg0, *0x1::vector::borrow<u64>(&arg1.xs, v1), *0x1::vector::borrow<u64>(&arg1.ys, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<Part>(&arg0.parts) > 1) {
            let v2 = 0;
            while (v2 < v0) {
                let v3 = if (v2 + 1 < v0) {
                    v2 + 1
                } else {
                    0
                };
                let v4 = *0x1::vector::borrow<u64>(&arg1.xs, v2);
                let v5 = *0x1::vector::borrow<u64>(&arg1.ys, v2);
                let v6 = *0x1::vector::borrow<u64>(&arg1.xs, v3);
                let v7 = *0x1::vector::borrow<u64>(&arg1.ys, v3);
                if (!point_inside_any_part_or_on_boundary_parts_scaled(&arg0.parts, 2 * v4 + v6, 2 * v5 + v7)) {
                    return false
                };
                if (!point_inside_any_part_or_on_boundary_parts_scaled(&arg0.parts, v4 + 2 * v6, v5 + 2 * v7)) {
                    return false
                };
                v2 = v2 + 1;
            };
        };
        true
    }

    fun part_twice_area_fp2(arg0: &Part) : u128 {
        let v0 = 0;
        let v1 = 0;
        let v2 = *0x1::vector::borrow<u64>(&arg0.xs, 0);
        let v3 = *0x1::vector::borrow<u64>(&arg0.ys, 0);
        let v4 = 1;
        while (v4 < 0x1::vector::length<u64>(&arg0.xs)) {
            let v5 = *0x1::vector::borrow<u64>(&arg0.xs, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg0.ys, v4);
            let v7 = (v2 as u128) * (v6 as u128);
            let v8 = (v5 as u128) * (v3 as u128);
            if (v7 >= v8) {
                v0 = v0 + v7 - v8;
            } else {
                v1 = v1 + v8 - v7;
            };
            v2 = v5;
            v3 = v6;
            v4 = v4 + 1;
        };
        let v9 = (v2 as u128) * (v3 as u128);
        let v10 = (v2 as u128) * (v3 as u128);
        if (v9 >= v10) {
            v0 = v0 + v9 - v10;
        } else {
            v1 = v1 + v10 - v9;
        };
        if (v0 >= v1) {
            v0 - v1
        } else {
            v1 - v0
        }
    }

    public fun parts(arg0: &Polygon) : u64 {
        arg0.part_count
    }

    fun point_in_aabb_or_on_boundary(arg0: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg1: u64, arg2: u64) : bool {
        if (arg1 >= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(arg0)) {
            if (arg1 <= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(arg0)) {
                if (arg2 >= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(arg0)) {
                    arg2 <= 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun point_in_aabb_or_on_boundary_scaled(arg0: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg1: u64, arg2: u64) : bool {
        if (arg1 >= 3 * 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_x(arg0)) {
            if (arg1 <= 3 * 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_x(arg0)) {
                if (arg2 >= 3 * 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::min_y(arg0)) {
                    arg2 <= 3 * 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::max_y(arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun point_inside_any_part_or_on_boundary(arg0: &Polygon, arg1: u64, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(&arg0.parts)) {
            let v1 = 0x1::vector::borrow<Part>(&arg0.parts, v0);
            if (point_in_aabb_or_on_boundary(&v1.aabb, arg1, arg2) && point_inside_convex_part_or_on_boundary(v1, arg1, arg2)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun point_inside_any_part_or_on_boundary_parts(arg0: &vector<Part>, arg1: u64, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(arg0)) {
            let v1 = 0x1::vector::borrow<Part>(arg0, v0);
            if (point_in_aabb_or_on_boundary(&v1.aabb, arg1, arg2) && point_inside_convex_part_or_on_boundary(v1, arg1, arg2)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun point_inside_any_part_or_on_boundary_parts_scaled(arg0: &vector<Part>, arg1: u64, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Part>(arg0)) {
            let v1 = 0x1::vector::borrow<Part>(arg0, v0);
            if (point_in_aabb_or_on_boundary_scaled(&v1.aabb, arg1, arg2) && point_inside_convex_part_or_on_boundary_scaled(v1, arg1, arg2)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun point_inside_convex_part_or_on_boundary(arg0: &Part, arg1: u64, arg2: u64) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = false;
        let v2 = false;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (v3 + 1 < v0) {
                v3 + 1
            } else {
                0
            };
            let v5 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::cross_sign(*0x1::vector::borrow<u64>(&arg0.xs, v3), *0x1::vector::borrow<u64>(&arg0.ys, v3), *0x1::vector::borrow<u64>(&arg0.xs, v4), *0x1::vector::borrow<u64>(&arg0.ys, v4), arg1, arg2);
            if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::is_zero(&v5)) {
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::is_negative(&v5)) {
                    v2 = true;
                } else {
                    v1 = true;
                };
                if (v1 && v2) {
                    return false
                };
            };
            v3 = v3 + 1;
        };
        true
    }

    fun point_inside_convex_part_or_on_boundary_scaled(arg0: &Part, arg1: u64, arg2: u64) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = false;
        let v2 = false;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (v3 + 1 < v0) {
                v3 + 1
            } else {
                0
            };
            let v5 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::cross_sign(3 * *0x1::vector::borrow<u64>(&arg0.xs, v3), 3 * *0x1::vector::borrow<u64>(&arg0.ys, v3), 3 * *0x1::vector::borrow<u64>(&arg0.xs, v4), 3 * *0x1::vector::borrow<u64>(&arg0.ys, v4), arg1, arg2);
            if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::is_zero(&v5)) {
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed::is_negative(&v5)) {
                    v2 = true;
                } else {
                    v1 = true;
                };
                if (v1 && v2) {
                    return false
                };
            };
            v3 = v3 + 1;
        };
        true
    }

    fun polygon_twice_area_fp2(arg0: &vector<Part>) : u128 {
        let v0 = 0x1::vector::length<Part>(arg0);
        if (v0 == 1) {
            return part_twice_area_fp2(0x1::vector::borrow<Part>(arg0, 0))
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + part_twice_area_fp2(0x1::vector::borrow<Part>(arg0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun prepare_geometry(arg0: vector<vector<u64>>, arg1: vector<vector<u64>>, arg2: u64) : (vector<Part>, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, u64, u64) {
        let v0 = 0x1::vector::length<vector<u64>>(&arg0);
        assert!(v0 > 0, 2001);
        assert!(v0 <= 10, 2002);
        assert!(v0 == 0x1::vector::length<vector<u64>>(&arg1), 2005);
        let v1 = 0x1::vector::empty<Part>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::remove<vector<u64>>(&mut arg0, 0);
            assert!(0x1::vector::length<u64>(&v3) <= arg2, 2004);
            0x1::vector::push_back<Part>(&mut v1, part(v3, 0x1::vector::remove<vector<u64>>(&mut arg1, 0)));
            v2 = v2 + 1;
        };
        validate_multipart_topology(&v1);
        (v1, compute_global_aabb(&v1), total_vertices(&v1), v0)
    }

    public(friend) fun set_cells(arg0: &mut Polygon, arg1: vector<u64>) {
        arg0.cells = arg1;
    }

    public(friend) fun set_global_aabb(arg0: &mut Polygon, arg1: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB) {
        arg0.global_aabb = arg1;
    }

    public(friend) fun set_owner(arg0: &mut Polygon, arg1: address) {
        arg0.owner = arg1;
    }

    public(friend) fun set_part_count(arg0: &mut Polygon, arg1: u64) {
        arg0.part_count = arg1;
    }

    public(friend) fun set_parts(arg0: &mut Polygon, arg1: vector<Part>) {
        arg0.global_aabb = compute_global_aabb(&arg1);
        arg0.total_vertices = total_vertices(&arg1);
        arg0.part_count = 0x1::vector::length<Part>(&arg1);
        arg0.parts = arg1;
    }

    public(friend) fun set_total_vertices(arg0: &mut Polygon, arg1: u64) {
        arg0.total_vertices = arg1;
    }

    fun to_topology_part(arg0: &Part) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::Part {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::part(arg0.xs, arg0.ys, arg0.aabb)
    }

    fun to_topology_parts(arg0: &vector<Part>) : vector<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::Part> {
        let v0 = 0x1::vector::empty<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::Part>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Part>(arg0)) {
            0x1::vector::push_back<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::Part>(&mut v0, to_topology_part(0x1::vector::borrow<Part>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun total_vertices(arg0: &vector<Part>) : u64 {
        let v0 = 0x1::vector::length<Part>(arg0);
        if (v0 == 1) {
            return 0x1::vector::length<u64>(&0x1::vector::borrow<Part>(arg0, 0).xs)
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + 0x1::vector::length<u64>(&0x1::vector::borrow<Part>(arg0, v2).xs);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun touches_by_edge(arg0: &Polygon, arg1: &Polygon) : bool {
        if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::aabbs_may_contact(&arg0.global_aabb, &arg1.global_aabb)) {
            return false
        };
        let v0 = arg0.part_count;
        let v1 = arg1.part_count;
        if (v0 == 1 && v1 == 1) {
            let v2 = 0x1::vector::borrow<Part>(&arg0.parts, 0);
            let v3 = 0x1::vector::borrow<Part>(&arg1.parts, 0);
            let v4 = to_topology_part(v2);
            let v5 = to_topology_part(v3);
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::has_exact_shared_edge(&v4, &v5)) {
                let (v6, v7) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v4, &v5);
                assert!(v7 == 0, v7);
                return v6
            };
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v2.aabb, &v3.aabb)) {
                let (_, v9) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v4, &v5);
                assert!(v9 == 0, v9);
            };
            return false
        };
        let v10 = 0;
        while (v10 < v0) {
            let v11 = 0x1::vector::borrow<Part>(&arg0.parts, v10);
            let v12 = 0;
            while (v12 < v1) {
                let v13 = 0x1::vector::borrow<Part>(&arg1.parts, v12);
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::aabbs_may_contact(&v11.aabb, &v13.aabb)) {
                    let v14 = to_topology_part(v11);
                    let v15 = to_topology_part(v13);
                    if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::has_exact_shared_edge(&v14, &v15)) {
                        let (v16, v17) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v14, &v15);
                        assert!(v17 == 0, v17);
                        if (v16) {
                            return true
                        };
                    };
                };
                v12 = v12 + 1;
            };
            v10 = v10 + 1;
        };
        false
    }

    public(friend) fun touches_by_edge_by_parts(arg0: &vector<Part>, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB, arg2: &vector<Part>, arg3: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::AABB) : bool {
        if (!0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::aabbs_may_contact(arg1, arg3)) {
            return false
        };
        let v0 = 0x1::vector::length<Part>(arg0);
        let v1 = 0x1::vector::length<Part>(arg2);
        if (v0 == 1 && v1 == 1) {
            let v2 = 0x1::vector::borrow<Part>(arg0, 0);
            let v3 = 0x1::vector::borrow<Part>(arg2, 0);
            let v4 = to_topology_part(v2);
            let v5 = to_topology_part(v3);
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::has_exact_shared_edge(&v4, &v5)) {
                let (v6, v7) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v4, &v5);
                assert!(v7 == 0, v7);
                return v6
            };
            if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::aabb::intersects(&v2.aabb, &v3.aabb)) {
                let (_, v9) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v4, &v5);
                assert!(v9 == 0, v9);
            };
            return false
        };
        let v10 = 0;
        while (v10 < v0) {
            let v11 = 0x1::vector::borrow<Part>(arg0, v10);
            let v12 = 0;
            while (v12 < v1) {
                let v13 = 0x1::vector::borrow<Part>(arg2, v12);
                if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::aabbs_may_contact(&v11.aabb, &v13.aabb)) {
                    let v14 = to_topology_part(v11);
                    let v15 = to_topology_part(v13);
                    if (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::has_exact_shared_edge(&v14, &v15)) {
                        let (v16, v17) = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::shared_edge_relation(&v14, &v15);
                        assert!(v17 == 0, v17);
                        if (v16) {
                            return true
                        };
                    };
                };
                v12 = v12 + 1;
            };
            v10 = v10 + 1;
        };
        false
    }

    fun validate_multipart_topology(arg0: &vector<Part>) {
        let v0 = to_topology_parts(arg0);
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::topology::validate_multipart_topology(&v0);
        assert!(v1 == 0, v1);
    }

    fun validate_part_arrays(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 >= 3, 2004);
        assert!(v0 <= 64, 2004);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2005);
    }

    fun validate_part_edges(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = if (v1 + 1 < v0) {
                v1 + 1
            } else {
                0
            };
            assert!(edge_length_squared(*0x1::vector::borrow<u64>(arg0, v1), *0x1::vector::borrow<u64>(arg1, v1), *0x1::vector::borrow<u64>(arg0, v2), *0x1::vector::borrow<u64>(arg1, v2)) >= 1000000000000, 2010);
            v1 = v1 + 1;
        };
    }

    public fun vertices(arg0: &Polygon) : u64 {
        arg0.total_vertices
    }

    // decompiled from Move bytecode v7
}

