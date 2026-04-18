module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::mutations {
    struct ParcelReshaped has copy, drop {
        polygon_id: 0x2::object::ID,
        old_area: u64,
        new_area: u64,
        caller: address,
    }

    struct ParcelsRepartitioned has copy, drop {
        a_id: 0x2::object::ID,
        b_id: 0x2::object::ID,
        caller: address,
    }

    struct ParcelRetired has copy, drop {
        polygon_id: 0x2::object::ID,
        caller: address,
    }

    struct ParcelSplit has copy, drop {
        parent_id: 0x2::object::ID,
        child_ids: vector<0x2::object::ID>,
        caller: address,
    }

    struct ParcelsMerged has copy, drop {
        keep_id: 0x2::object::ID,
        absorbed_id: 0x2::object::ID,
        caller: address,
    }

    fun assert_no_overlap_with_others_merged(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Part>, arg4: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB) {
        let (v0, v1, v2, v3) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg0, arg4);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::broadphase_from_aabb(arg0, v0, v1, v2, v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&v4, v5);
            if (v6 != arg1 && v6 != arg2) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects_polygon_by_parts(arg3, arg4, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg0, v6))) {
                    abort 5002
                };
            };
            v5 = v5 + 1;
        };
    }

    fun assert_no_overlap_with_others_pair(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Part>, arg4: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB, arg5: &vector<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Part>, arg6: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB) {
        let (v0, v1, v2, v3) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg0, arg4);
        let (v4, v5, v6, v7) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg0, arg6);
        let v8 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::broadphase_from_aabb(arg0, v0, v1, v2, v3);
        let v9 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::broadphase_from_aabb(arg0, v4, v5, v6, v7);
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x2::object::ID>(&v9)) {
            let v11 = *0x1::vector::borrow<0x2::object::ID>(&v9, v10);
            if (!0x1::vector::contains<0x2::object::ID>(&v8, &v11)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v8, v11);
            };
            v10 = v10 + 1;
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<0x2::object::ID>(&v8)) {
            let v13 = *0x1::vector::borrow<0x2::object::ID>(&v8, v12);
            if (v13 != arg1 && v13 != arg2) {
                let v14 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg0, v13);
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects_polygon_by_parts(arg3, arg4, v14) || 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects_polygon_by_parts(arg5, arg6, v14)) {
                    abort 5002
                };
            };
            v12 = v12 + 1;
        };
    }

    public fun merge_keep(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<vector<u64>>, arg5: vector<vector<u64>>, arg6: &0x2::tx_context::TxContext) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_cap_authorized(arg1, arg0);
        assert!(arg2 != arg3, 5006);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg3);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v1) == 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2), 5005);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v1) == 0x2::tx_context::sender(arg6), 5005);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::touches_by_edge(v1, v2), 5004);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(v2);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::cells(v1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(v4, v5));
            v5 = v5 + 1;
        };
        let (v6, v7, v8, v9) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::prepare_geometry(arg4, arg5, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_vertices_per_part(arg1));
        let v10 = v7;
        let v11 = v6;
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_vertex_limit(arg1, v8, v9);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::assert_area_conserved(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::checked_area_sum(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(v1), v3), 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2_from_parts(&v11));
        if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::count(arg1) > 2) {
            assert_no_overlap_with_others_merged(arg1, arg2, arg3, &v11, &v10);
        };
        let (v12, v13, v14, v15) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v10);
        let v16 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::natural_depth(v12, v13, v14, v15, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1));
        let v17 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1) - v16;
        let v18 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::depth_prefix(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::interleave_n(v12 >> v17, v13 >> v17, v16), v16);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unregister_from_cells(arg1, arg2, &v0);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::set_polygon_geometry(arg1, arg2, v11, v18);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register_in_cell(arg1, arg2, v18, v16);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata::force_remove_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid_mut(arg1), arg3);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::remove_unchecked(arg1, arg3);
        let v19 = ParcelRetired{
            polygon_id : arg3,
            caller     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ParcelRetired>(v19);
        let v20 = ParcelsMerged{
            keep_id     : arg2,
            absorbed_id : arg3,
            caller      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ParcelsMerged>(v20);
    }

    public fun remove_polygon(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata::force_remove_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid_mut(arg1), arg2);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::remove(arg0, arg1, arg2, arg3);
    }

    public fun repartition_adjacent(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<u64>>, arg4: vector<vector<u64>>, arg5: 0x2::object::ID, arg6: vector<vector<u64>>, arg7: vector<vector<u64>>, arg8: &0x2::tx_context::TxContext) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_cap_authorized(arg1, arg0);
        assert!(arg2 != arg5, 5003);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg5);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v2) == 0x2::tx_context::sender(arg8), 5005);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v3) == 0x2::tx_context::sender(arg8), 5005);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::touches_by_edge(v2, v3), 5004);
        let v4 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(v3);
        let v5 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::bounds(v2);
        let v6 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::bounds(v3);
        let v7 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::cells(v2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(v7)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(v7, v8));
            v8 = v8 + 1;
        };
        let v9 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::cells(v3);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(v9)) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(v9, v10));
            v10 = v10 + 1;
        };
        let (v11, v12, v13, v14) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::prepare_geometry(arg3, arg4, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_vertices_per_part(arg1));
        let v15 = v12;
        let v16 = v11;
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_vertex_limit(arg1, v13, v14);
        let (v17, v18, v19, v20) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::prepare_geometry(arg6, arg7, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_vertices_per_part(arg1));
        let v21 = v18;
        let v22 = v17;
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_vertex_limit(arg1, v19, v20);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::assert_area_conserved(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::checked_area_sum(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(v2), v4), 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::checked_area_sum(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2_from_parts(&v16), 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2_from_parts(&v22)));
        assert!(!0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects_parts_by_parts(&v16, &v15, &v22, &v21), 5002);
        let v23 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v5) < 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v6)) {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v5)
        } else {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v6)
        };
        let v24 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v5) < 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v6)) {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v5)
        } else {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v6)
        };
        let v25 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v5) > 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v6)) {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v5)
        } else {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v6)
        };
        let v26 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v5) > 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v6)) {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v5)
        } else {
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v6)
        };
        let v27 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v15) >= v23) {
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v15) >= v24) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v15) <= v25) {
                    0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v15) <= v26
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v27, 5001);
        let v28 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v21) >= v23) {
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v21) >= v24) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v21) <= v25) {
                    0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v21) <= v26
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v28, 5001);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::touches_by_edge_by_parts(&v16, &v15, &v22, &v21), 5004);
        if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::count(arg1) > 2) {
            assert_no_overlap_with_others_pair(arg1, arg2, arg5, &v16, &v15, &v22, &v21);
        };
        let v29 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1);
        let (v30, v31, v32, v33) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v15);
        let v34 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::natural_depth(v30, v31, v32, v33, v29);
        let v35 = v29 - v34;
        let v36 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::depth_prefix(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::interleave_n(v30 >> v35, v31 >> v35, v34), v34);
        let (v37, v38, v39, v40) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v21);
        let v41 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::natural_depth(v37, v38, v39, v40, v29);
        let v42 = v29 - v41;
        let v43 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::depth_prefix(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::interleave_n(v37 >> v42, v38 >> v42, v41), v41);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unregister_from_cells(arg1, arg2, &v0);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::set_polygon_geometry(arg1, arg2, v16, v36);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register_in_cell(arg1, arg2, v36, v34);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unregister_from_cells(arg1, arg5, &v1);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::set_polygon_geometry(arg1, arg5, v22, v43);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register_in_cell(arg1, arg5, v43, v41);
        let v44 = ParcelsRepartitioned{
            a_id   : arg2,
            b_id   : arg5,
            caller : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<ParcelsRepartitioned>(v44);
    }

    public fun reshape_unclaimed(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<u64>>, arg4: vector<vector<u64>>, arg5: &0x2::tx_context::TxContext) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_cap_authorized(arg1, arg0);
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v0) == 0x2::tx_context::sender(arg5), 5005);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area(v0);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::bounds(v0);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::cells(v0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v3)) {
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(v3, v5));
            v5 = v5 + 1;
        };
        let (v6, v7, v8, v9) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::prepare_geometry(arg3, arg4, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_vertices_per_part(arg1));
        let v10 = v7;
        let v11 = v6;
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_vertex_limit(arg1, v8, v9);
        let v12 = if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v10) <= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(&v2)) {
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v10) <= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(&v2)) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v10) >= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(&v2)) {
                    0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v10) >= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(&v2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 5001);
        assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::contains_polygon_by_parts(&v11, &v10, v0), 5001);
        let (v13, v14, v15, v16) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v10);
        let v17 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::broadphase_from_aabb(arg1, v13, v14, v15, v16);
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x2::object::ID>(&v17)) {
            let v19 = *0x1::vector::borrow<0x2::object::ID>(&v17, v18);
            if (v19 != arg2) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects_polygon_by_parts(&v11, &v10, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, v19))) {
                    abort 5002
                };
            };
            v18 = v18 + 1;
        };
        let v20 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::natural_depth(v13, v14, v15, v16, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1));
        let v21 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1) - v20;
        let v22 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::depth_prefix(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::interleave_n(v13 >> v21, v14 >> v21, v20), v20);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unregister_from_cells(arg1, arg2, &v4);
        let v23 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::set_polygon_geometry(arg1, arg2, v11, v22);
        assert!(v23 >= v1, 5009);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register_in_cell(arg1, arg2, v22, v20);
        let v24 = ParcelReshaped{
            polygon_id : arg2,
            old_area   : v1,
            new_area   : v23,
            caller     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ParcelReshaped>(v24);
    }

    public fun split_replace(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID, arg3: vector<vector<vector<u64>>>, arg4: vector<vector<vector<u64>>>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_cap_authorized(arg1, arg0);
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::owner(v0);
        assert!(v1 == 0x2::tx_context::sender(arg5), 5005);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::cells(v0);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(v2)) {
            0x1::vector::push_back<u64>(&mut v3, *0x1::vector::borrow<u64>(v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::length<vector<vector<u64>>>(&arg3);
        assert!(v5 == 0x1::vector::length<vector<vector<u64>>>(&arg4), 5001);
        assert!(v5 >= 2, 5007);
        assert!(v5 <= 10, 5008);
        let v6 = 0x1::vector::empty<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>();
        let v7 = 0;
        let v8 = 0;
        while (v7 < v5) {
            let (v9, _, v11, v12) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::prepare_geometry(0x1::vector::remove<vector<vector<u64>>>(&mut arg3, 0), 0x1::vector::remove<vector<vector<u64>>>(&mut arg4, 0), 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_vertices_per_part(arg1));
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::assert_vertex_limit(arg1, v11, v12);
            let v13 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::new(v9, arg5);
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::set_owner(&mut v13, v1);
            v8 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::checked_area_sum(v8, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(&v13));
            0x1::vector::push_back<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&mut v6, v13);
            v7 = v7 + 1;
        };
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::assert_area_conserved(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::area_fp2(v0), v8);
        let v14 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, arg2);
        let v15 = 0;
        while (v15 < v5) {
            assert!(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::contains_polygon(v14, 0x1::vector::borrow<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&v6, v15)), 5001);
            v15 = v15 + 1;
        };
        let v16 = 0;
        while (v16 < v5) {
            let v17 = 0x1::vector::borrow<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&v6, v16);
            let v18 = v16 + 1;
            while (v18 < v5) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects(v17, 0x1::vector::borrow<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&v6, v18))) {
                    abort 5002
                };
                v18 = v18 + 1;
            };
            v16 = v16 + 1;
        };
        v7 = 0;
        while (v7 < v5) {
            let v19 = 0x1::vector::borrow<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&v6, v7);
            let v20 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::bounds(v19);
            let (v21, v22, v23, v24) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v20);
            let v25 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::broadphase_from_aabb(arg1, v21, v22, v23, v24);
            let v26 = 0;
            while (v26 < 0x1::vector::length<0x2::object::ID>(&v25)) {
                let v27 = *0x1::vector::borrow<0x2::object::ID>(&v25, v26);
                if (v27 != arg2) {
                    if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::intersects(v19, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::get(arg1, v27))) {
                        abort 5002
                    };
                };
                v26 = v26 + 1;
            };
            v7 = v7 + 1;
        };
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unregister_from_cells(arg1, arg2, &v3);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::metadata::force_remove_metadata(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::uid_mut(arg1), arg2);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::destroy(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::take_polygon(arg1, arg2));
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::decrement_count(arg1);
        let v28 = ParcelRetired{
            polygon_id : arg2,
            caller     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ParcelRetired>(v28);
        let v29 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::max_depth(arg1);
        let v30 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&v6) > 0) {
            let v31 = 0x1::vector::remove<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(&mut v6, 0);
            let v32 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::bounds(&v31);
            let (v33, v34, v35, v36) = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::grid_bounds_for_aabb(arg1, &v32);
            let v37 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::natural_depth(v33, v34, v35, v36, v29);
            let v38 = v29 - v37;
            let v39 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::depth_prefix(0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::morton::interleave_n(v33 >> v38, v34 >> v38, v37), v37);
            let v40 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v40, v39);
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::set_cells(&mut v31, v40);
            let v41 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::put_polygon(arg1, v31);
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::register_in_cell(arg1, v41, v39, v37);
            0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::increment_count(arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v30, v41);
        };
        0x1::vector::destroy_empty<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::Polygon>(v6);
        let v42 = 0x1::vector::empty<0x2::object::ID>();
        v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(&v30)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v42, *0x1::vector::borrow<0x2::object::ID>(&v30, v7));
            v7 = v7 + 1;
        };
        let v43 = ParcelSplit{
            parent_id : arg2,
            child_ids : v42,
            caller    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ParcelSplit>(v43);
        v30
    }

    // decompiled from Move bytecode v7
}

