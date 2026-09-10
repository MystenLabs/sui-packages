module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid {
    struct DistanceField has drop {
        layers: vector<SearchMask>,
    }

    struct SearchMask has copy, drop {
        low: u256,
        high: u256,
    }

    struct GridSpec has copy, drop, store {
        width: u64,
        height: u64,
        shape_mask: vector<u64>,
        obstacles: vector<u64>,
        holes: vector<u64>,
        start_cells_a: vector<u64>,
        start_cells_b: vector<u64>,
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun approach_field(arg0: u64, arg1: &vector<u64>, arg2: u64) : DistanceField {
        let v0 = neighbours(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            if (!mask_get(arg1, v3)) {
                0x1::vector::push_back<u64>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        distance_field(v1, arg1, 380, arg2)
    }

    fun assert_cells_on_shape(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            assert!(in_grid(*0x1::vector::borrow<u64>(arg1, v0)) && mask_get(arg0, *0x1::vector::borrow<u64>(arg1, v0)), 1101);
            v0 = v0 + 1;
        };
    }

    fun assert_open_footing(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>) {
        assert_cells_on_shape(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg2)) {
            assert!(!mask_get(arg1, *0x1::vector::borrow<u64>(arg2, v0)), 1101);
            v0 = v0 + 1;
        };
    }

    fun assert_unique_starts(arg0: &vector<u64>, arg1: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<u64>(arg0)) {
                assert!(*0x1::vector::borrow<u64>(arg0, v0) != *0x1::vector::borrow<u64>(arg0, v1), 1101);
                v1 = v1 + 1;
            };
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(arg1)) {
                assert!(*0x1::vector::borrow<u64>(arg0, v0) != *0x1::vector::borrow<u64>(arg1, v2), 1101);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(arg1)) {
            let v4 = v3 + 1;
            while (v4 < 0x1::vector::length<u64>(arg1)) {
                assert!(*0x1::vector::borrow<u64>(arg1, v3) != *0x1::vector::borrow<u64>(arg1, v4), 1101);
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
    }

    public fun away_dir(arg0: u64, arg1: u64) : u8 {
        let v0 = arg0 % 20;
        let v1 = arg0 / 20;
        let v2 = arg1 % 20;
        let v3 = arg1 / 20;
        let v4 = abs_diff(v2, v0);
        let v5 = abs_diff(v3, v1);
        if (v4 == 0 && v5 == 0) {
            return 255
        };
        if (v4 >= v5) {
            if (v2 >= v0) {
                0
            } else {
                1
            }
        } else if (v3 >= v1) {
            2
        } else {
            3
        }
    }

    public fun best_step(arg0: u64, arg1: &DistanceField, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = 0x1::option::none<u64>();
        if (arg2 == 0 || 0x1::vector::is_empty<SearchMask>(&arg1.layers)) {
            return v0
        };
        let v1 = if (arg2 == 380) {
            0x1::vector::length<SearchMask>(&arg1.layers) - 1
        } else {
            arg2 - 1
        };
        let v2 = 0;
        while (v2 < 4) {
            let v3 = step_cell(arg0, v2);
            if (0x1::option::is_some<u64>(&v3)) {
                let v4 = 0x1::option::destroy_some<u64>(v3);
                let v5 = if (arg2 == 380) {
                    distance_at(arg1, v4)
                } else if (search_contains(0x1::vector::borrow<SearchMask>(&arg1.layers, v1), v4)) {
                    v1
                } else {
                    380
                };
                let v6 = if (v5 < arg2) {
                    true
                } else if (v5 == arg2) {
                    if (0x1::option::is_some<u64>(&v0)) {
                        v4 < *0x1::option::borrow<u64>(&v0)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    v0 = 0x1::option::some<u64>(v4);
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun bfs_cast_cell(arg0: u64, arg1: u64, arg2: &vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: &vector<u64>) : 0x1::option::Option<u64> {
        if (!in_grid(arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = arg0;
        let v1 = false;
        let v2 = 0;
        if (cell_can_cast(arg0, arg1, arg4, arg5, arg6, arg7, arg8)) {
            v1 = true;
            v2 = manhattan(arg0, arg1);
        };
        let v3 = empty_mask();
        let v4 = &mut v3;
        mask_set(v4, arg0);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, arg0);
        let v6 = 0;
        while (v6 < arg3 && !0x1::vector::is_empty<u64>(&v5)) {
            if (v1) {
                break
            };
            v6 = v6 + 1;
            let v7 = vector[];
            let v8 = 0;
            while (v8 < 0x1::vector::length<u64>(&v5)) {
                let v9 = neighbours(*0x1::vector::borrow<u64>(&v5, v8));
                let v10 = 0;
                while (v10 < 0x1::vector::length<u64>(&v9)) {
                    let v11 = *0x1::vector::borrow<u64>(&v9, v10);
                    if (!mask_get(&v3, v11) && !mask_get(arg2, v11)) {
                        let v12 = &mut v3;
                        mask_set(v12, v11);
                        0x1::vector::push_back<u64>(&mut v7, v11);
                        if (cell_can_cast(v11, arg1, arg4, arg5, arg6, arg7, arg8)) {
                            let v13 = manhattan(v11, arg1);
                            let v14 = if (!v1) {
                                true
                            } else if (v13 < v2) {
                                true
                            } else {
                                v13 == v2 && v11 < arg0
                            };
                            if (v14) {
                                v0 = v11;
                                v1 = true;
                                v2 = v13;
                            };
                        };
                    };
                    v10 = v10 + 1;
                };
                v8 = v8 + 1;
            };
            v5 = v7;
        };
        if (v1) {
            0x1::option::some<u64>(v0)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun bfs_distance_field(arg0: u64, arg1: &vector<u64>, arg2: u64) : DistanceField {
        if (!in_grid(arg0) || mask_get(arg1, arg0)) {
            return DistanceField{layers: 0x1::vector::empty<SearchMask>()}
        };
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg0);
        distance_field(v0, arg1, arg2, 380)
    }

    fun blocks(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = arg6 % 20;
        let v1 = arg6 / 20;
        if (v0 != arg0 && v0 >= arg0 != arg2 >= arg0) {
            return false
        };
        if (v1 != arg1 && v1 >= arg1 != arg3 >= arg1) {
            return false
        };
        let v2 = abs_diff(v0, arg0);
        let v3 = abs_diff(v1, arg1);
        if (arg4 < v2 || arg5 < v3) {
            return false
        };
        if (arg4 == v2 && arg5 == v3) {
            return false
        };
        let v4 = v2 == 0 || arg5 == 0 || arg4 * (2 * v3 + 1) > (2 * v2 - 1) * arg5;
        if (!v4) {
            return false
        };
        if (v3 == 0) {
            return v0 < arg0 || arg4 > v2
        };
        if (arg5 == 0) {
            return false
        };
        arg4 * (2 * v3 - 1) < (2 * v2 + 1) * arg5
    }

    public fun cell_can_cast(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &vector<u64>) : bool {
        let v0 = manhattan(arg0, arg1);
        if (v0 >= arg2) {
            if (v0 <= arg3) {
                if (!arg5 || same_line(arg0, arg1)) {
                    !arg4 || line_of_sight(arg0, arg1, arg6)
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

    public fun closed_mask(arg0: &GridSpec) : vector<u64> {
        let v0 = shape_mask(arg0);
        let v1 = empty_mask();
        let v2 = 0;
        while (v2 < 380) {
            if (!mask_get(&v0, v2)) {
                let v3 = &mut v1;
                mask_set(v3, v2);
            };
            v2 = v2 + 1;
        };
        let v4 = &mut v1;
        let v5 = obstacles(arg0);
        mask_add_cells(v4, &v5);
        let v6 = &mut v1;
        let v7 = holes(arg0);
        mask_add_cells(v6, &v7);
        v1
    }

    fun cone_depth_start(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 1) {
            0
        } else {
            1 + (arg0 - 2) * arg1
        }
    }

    fun cone_rank(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = away_dir(arg1, arg0);
        let v1 = step_cell(arg1, v0);
        if (0x1::option::is_none<u64>(&v1)) {
            return 0x1::option::none<u64>()
        };
        let (v2, v3) = perpendicular_dirs(v0);
        let v4 = *0x1::option::borrow<u64>(&v1);
        let v5 = step_cell(v4, v2);
        let v6 = 0x1::option::is_some<u64>(&v5);
        let v7 = step_cell(v4, v3);
        let v8 = if (v6) {
            1
        } else {
            0
        };
        let v9 = if (0x1::option::is_some<u64>(&v7)) {
            1
        } else {
            0
        };
        let v10 = walk_rank(arg1, v0, arg2, arg3);
        if (0x1::option::is_some<u64>(&v10)) {
            return 0x1::option::some<u64>(cone_depth_start(*0x1::option::borrow<u64>(&v10), 1 + v8 + v9))
        };
        if (arg2 < 2) {
            return 0x1::option::none<u64>()
        };
        let v11 = step_cell(arg3, opposite_dir(v2));
        if (0x1::option::is_some<u64>(&v11)) {
            let v12 = *0x1::option::borrow<u64>(&v11);
            let v13 = walk_rank(arg1, v0, arg2, v12);
            let v14 = if (0x1::option::is_some<u64>(&v13)) {
                if (*0x1::option::borrow<u64>(&v13) >= 2) {
                    step_equals(v12, v2, arg3)
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                return 0x1::option::some<u64>(cone_depth_start(*0x1::option::borrow<u64>(&v13), 1 + v8 + v9) + 1)
            };
        };
        let v15 = step_cell(arg3, opposite_dir(v3));
        if (0x1::option::is_some<u64>(&v15)) {
            let v16 = *0x1::option::borrow<u64>(&v15);
            let v17 = walk_rank(arg1, v0, arg2, v16);
            let v18 = if (0x1::option::is_some<u64>(&v17)) {
                if (*0x1::option::borrow<u64>(&v17) >= 2) {
                    step_equals(v16, v3, arg3)
                } else {
                    false
                }
            } else {
                false
            };
            if (v18) {
                let v19 = if (v6) {
                    1
                } else {
                    0
                };
                return 0x1::option::some<u64>(cone_depth_start(*0x1::option::borrow<u64>(&v17), 1 + v8 + v9) + 1 + v19)
            };
        };
        0x1::option::none<u64>()
    }

    public fun dir_none() : u8 {
        255
    }

    fun directed_distance(arg0: u64, arg1: u8, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 % 20;
        let v1 = arg0 / 20;
        let v2 = arg2 % 20;
        let v3 = arg2 / 20;
        let v4 = if (arg1 == 0) {
            if (v3 == v1) {
                v2 >= v0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            return 0x1::option::some<u64>(v2 - v0)
        };
        let v5 = if (arg1 == 1) {
            if (v3 == v1) {
                v2 <= v0
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            return 0x1::option::some<u64>(v0 - v2)
        };
        let v6 = if (arg1 == 2) {
            if (v2 == v0) {
                v3 >= v1
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            return 0x1::option::some<u64>(v3 - v1)
        };
        let v7 = if (arg1 == 3) {
            if (v2 == v0) {
                v3 <= v1
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return 0x1::option::some<u64>(v1 - v3)
        };
        0x1::option::none<u64>()
    }

    public fun distance_at(arg0: &DistanceField, arg1: u64) : u64 {
        if (arg1 >= 380) {
            return 380
        };
        let v0 = 0x1::vector::length<SearchMask>(&arg0.layers);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = if (arg1 >= 256) {
                0x1::vector::borrow<SearchMask>(&arg0.layers, v0).high
            } else {
                0x1::vector::borrow<SearchMask>(&arg0.layers, v0).low
            };
            if (v1 & 1 << ((arg1 % 256) as u8) != 0) {
                return v0
            };
        };
        380
    }

    fun distance_field(arg0: vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: u64) : DistanceField {
        let v0 = 0x1::vector::empty<SearchMask>();
        let v1 = mask_from_cells(&arg0);
        let v2 = search_mask(&v1);
        let v3 = search_mask(arg1);
        let v4 = 0;
        loop {
            if (v2.low == 0 && v2.high == 0) {
                return DistanceField{layers: v0}
            };
            v3.low = v3.low | v2.low;
            v3.high = v3.high | v2.high;
            0x1::vector::push_back<SearchMask>(&mut v0, v2);
            if (v4 >= arg2 || search_contains(&v2, arg3)) {
                break
            };
            let v5 = &v2;
            v2 = expand_frontier(v5, &v3);
            v4 = v4 + 1;
        };
        DistanceField{layers: v0}
    }

    public fun empty_mask() : vector<u64> {
        vector[0, 0, 0, 0, 0, 0]
    }

    public fun encode(arg0: u64, arg1: u64) : u64 {
        arg1 * 20 + arg0
    }

    fun expand_frontier(arg0: &SearchMask, arg1: &SearchMask) : SearchMask {
        let v0 = arg0.low;
        let v1 = arg0.high;
        SearchMask{
            low  : (v0 << 1 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 1766848749776657966075040660075823403812144820017880480300714154091610113) | (v0 >> 1 | v1 << 255) & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 883424374888328983037520330037911701906072410008940240150357077045805056) | v0 << 20 | v0 >> 20 | v1 << 236) & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ arg1.low),
            high : ((v1 << 1 | v0 >> 255) & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 20282428946483231019679958958096) | v1 >> 1 & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ 10633834107493800224845966322222235656) | v1 << 20 | v0 >> 236 | v1 >> 20) & (115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ arg1.high) & 21267647932558653966460912964485513215,
        }
    }

    public fun first_free(arg0: &vector<u64>, arg1: &vector<u64>) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (!0x1::vector::contains<u64>(arg1, 0x1::vector::borrow<u64>(arg0, v0))) {
                return 0x1::option::some<u64>(*0x1::vector::borrow<u64>(arg0, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun grid_cells() : u64 {
        380
    }

    public fun grid_spec(arg0: u64, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) : GridSpec {
        let v0 = if (arg0 >= 1) {
            if (arg0 <= 20) {
                if (arg1 >= 1) {
                    arg1 <= 19
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1101);
        assert!(0x1::vector::length<u64>(&arg2) == 6, 1101);
        assert!(0x1::vector::length<u64>(&arg5) == 6, 1101);
        assert!(0x1::vector::length<u64>(&arg6) == 6, 1101);
        assert_cells_on_shape(&arg2, &arg3);
        assert_cells_on_shape(&arg2, &arg4);
        0x1::vector::append<u64>(&mut arg3, arg4);
        let v1 = mask_from_cells(&arg3);
        assert_open_footing(&arg2, &v1, &arg5);
        assert_open_footing(&arg2, &v1, &arg6);
        assert_unique_starts(&arg5, &arg6);
        GridSpec{
            width         : arg0,
            height        : arg1,
            shape_mask    : arg2,
            obstacles     : arg3,
            holes         : arg4,
            start_cells_a : arg5,
            start_cells_b : arg6,
        }
    }

    public fun height(arg0: &GridSpec) : u64 {
        arg0.height
    }

    public fun holes(arg0: &GridSpec) : vector<u64> {
        arg0.holes
    }

    public fun in_grid(arg0: u64) : bool {
        arg0 < 380
    }

    public fun in_zone(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (!in_grid(arg3)) {
            return false
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_point()) {
            return arg3 == arg2
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_allmap()) {
            return true
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_ring()) {
            return manhattan(arg2, arg3) == arg1
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_cross()) {
            return manhattan(arg2, arg3) <= arg1 && (arg3 % 20 == arg2 % 20 || arg3 / 20 == arg2 / 20)
        };
        manhattan(arg2, arg3) <= arg1
    }

    public fun line_of_sight(arg0: u64, arg1: u64, arg2: &vector<u64>) : bool {
        let v0 = arg0 % 20;
        let v1 = arg0 / 20;
        let v2 = arg1 % 20;
        let v3 = arg1 / 20;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg2)) {
            let v5 = *0x1::vector::borrow<u64>(arg2, v4);
            let v6 = if (v5 != arg0) {
                if (v5 != arg1) {
                    blocks(v0, v1, v2, v3, abs_diff(v2, v0), abs_diff(v3, v1), v5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                return false
            };
            v4 = v4 + 1;
        };
        true
    }

    fun line_rank(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        if (arg3 == arg0) {
            0x1::option::some<u64>(0)
        } else {
            walk_rank(arg0, away_dir(arg1, arg0), arg2, arg3)
        }
    }

    public fun manhattan(arg0: u64, arg1: u64) : u64 {
        abs_diff(arg0 % 20, arg1 % 20) + abs_diff(arg0 / 20, arg1 / 20)
    }

    public fun mask_add_cells(arg0: &mut vector<u64>, arg1: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            mask_set(arg0, *0x1::vector::borrow<u64>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun mask_from_cells(arg0: &vector<u64>) : vector<u64> {
        let v0 = empty_mask();
        let v1 = &mut v0;
        mask_add_cells(v1, arg0);
        v0
    }

    public fun mask_get(arg0: &vector<u64>, arg1: u64) : bool {
        if (arg1 >= 380) {
            return false
        };
        let v0 = arg1 / 64;
        if (v0 >= 0x1::vector::length<u64>(arg0)) {
            return false
        };
        *0x1::vector::borrow<u64>(arg0, v0) >> ((arg1 % 64) as u8) & 1 == 1
    }

    public fun mask_set(arg0: &mut vector<u64>, arg1: u64) {
        if (arg1 >= 380) {
            return
        };
        let v0 = arg1 / 64;
        *0x1::vector::borrow_mut<u64>(arg0, v0) = *0x1::vector::borrow<u64>(arg0, v0) | 1 << ((arg1 % 64) as u8);
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun neighbours(arg0: u64) : vector<u64> {
        let v0 = arg0 % 20;
        let v1 = arg0 / 20;
        let v2 = vector[];
        if (v0 > 0) {
            0x1::vector::push_back<u64>(&mut v2, arg0 - 1);
        };
        if (v0 + 1 < 20) {
            0x1::vector::push_back<u64>(&mut v2, arg0 + 1);
        };
        if (v1 > 0) {
            0x1::vector::push_back<u64>(&mut v2, arg0 - 20);
        };
        if (v1 + 1 < 19) {
            0x1::vector::push_back<u64>(&mut v2, arg0 + 20);
        };
        v2
    }

    public fun obstacles(arg0: &GridSpec) : vector<u64> {
        arg0.obstacles
    }

    fun opposite_dir(arg0: u8) : u8 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            0
        } else if (arg0 == 2) {
            3
        } else if (arg0 == 3) {
            2
        } else {
            255
        }
    }

    public fun path_is_walkable(arg0: u64, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64) : bool {
        if (!in_grid(arg0) || 0x1::vector::length<u64>(arg1) > arg3) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            let v2 = if (!in_grid(v1)) {
                true
            } else if (mask_get(arg2, v1)) {
                true
            } else {
                manhattan(arg0, v1) != 1
            };
            if (v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun path_unreachable() : u64 {
        380
    }

    fun perpendicular_dirs(arg0: u8) : (u8, u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 255
        };
        if (v0) {
            (2, 3)
        } else {
            (0, 1)
        }
    }

    public fun same_line(arg0: u64, arg1: u64) : bool {
        arg0 % 20 == arg1 % 20 || arg0 / 20 == arg1 / 20
    }

    fun search_contains(arg0: &SearchMask, arg1: u64) : bool {
        if (arg1 >= 380) {
            return false
        };
        arg1 < 256 && arg0.low & 1 << (arg1 as u8) != 0 || arg0.high & 1 << ((arg1 - 256) as u8) != 0
    }

    fun search_mask(arg0: &vector<u64>) : SearchMask {
        let v0 = *arg0;
        while (0x1::vector::length<u64>(&v0) < 6) {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        SearchMask{
            low  : (*0x1::vector::borrow<u64>(&v0, 0) as u256) | (*0x1::vector::borrow<u64>(&v0, 1) as u256) << 64 | (*0x1::vector::borrow<u64>(&v0, 2) as u256) << 128 | (*0x1::vector::borrow<u64>(&v0, 3) as u256) << 192,
            high : (*0x1::vector::borrow<u64>(&v0, 4) as u256) | (*0x1::vector::borrow<u64>(&v0, 5) as u256) << 64,
        }
    }

    public fun shape_mask(arg0: &GridSpec) : vector<u64> {
        arg0.shape_mask
    }

    public fun start_cells_a(arg0: &GridSpec) : vector<u64> {
        arg0.start_cells_a
    }

    public fun start_cells_b(arg0: &GridSpec) : vector<u64> {
        arg0.start_cells_b
    }

    public fun step_cell(arg0: u64, arg1: u8) : 0x1::option::Option<u64> {
        let v0 = arg0 % 20;
        let v1 = arg0 / 20;
        if (arg1 == 0) {
            if (v0 + 1 < 20) {
                0x1::option::some<u64>(encode(v0 + 1, v1))
            } else {
                0x1::option::none<u64>()
            }
        } else if (arg1 == 1) {
            if (v0 >= 1) {
                0x1::option::some<u64>(encode(v0 - 1, v1))
            } else {
                0x1::option::none<u64>()
            }
        } else if (arg1 == 2) {
            if (v1 + 1 < 19) {
                0x1::option::some<u64>(encode(v0, v1 + 1))
            } else {
                0x1::option::none<u64>()
            }
        } else if (arg1 == 3) {
            if (v1 >= 1) {
                0x1::option::some<u64>(encode(v0, v1 - 1))
            } else {
                0x1::option::none<u64>()
            }
        } else {
            0x1::option::none<u64>()
        }
    }

    fun step_equals(arg0: u64, arg1: u8, arg2: u64) : bool {
        let v0 = step_cell(arg0, arg1);
        0x1::option::is_some<u64>(&v0) && *0x1::option::borrow<u64>(&v0) == arg2
    }

    fun tbar_length(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let (v0, v1) = perpendicular_dirs(arg1);
        1 + walk_capacity(arg0, v0, arg2) + walk_capacity(arg0, v1, arg2)
    }

    fun tbar_rank(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        if (arg3 == arg0) {
            return 0x1::option::some<u64>(0)
        };
        let (v0, v1) = perpendicular_dirs(away_dir(arg1, arg0));
        let v2 = walk_rank(arg0, v0, arg2, arg3);
        if (0x1::option::is_some<u64>(&v2)) {
            return v2
        };
        let v3 = walk_rank(arg0, v1, arg2, arg3);
        if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::some<u64>(walk_capacity(arg0, v0, arg2) + *0x1::option::borrow<u64>(&v3))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun toward_dir(arg0: u64, arg1: u64) : u8 {
        opposite_dir(away_dir(arg0, arg1))
    }

    public fun travel_order(arg0: vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: bool) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(&arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                let v3 = manhattan(*0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(&arg0, v2)), arg2);
                let v4 = manhattan(*0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(&arg0, v1)), arg2);
                if (arg3 && v3 > v4 || v3 < v4) {
                } else if (v3 == v4) {
                };
                v2 = v2 + 1;
            };
            0x1::vector::swap<u64>(&mut arg0, v1, v1);
            v1 = v1 + 1;
        };
        arg0
    }

    fun walk_capacity(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let v0 = if (arg1 == 0) {
            20 - 1 - arg0 % 20
        } else if (arg1 == 1) {
            arg0 % 20
        } else if (arg1 == 2) {
            19 - 1 - arg0 / 20
        } else if (arg1 == 3) {
            arg0 / 20
        } else {
            0
        };
        min_u64(arg2, v0)
    }

    fun walk_rank(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = directed_distance(arg0, arg1, arg3);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = *0x1::option::borrow<u64>(&v0);
        if (v1 >= 1 && v1 <= arg2) {
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun width(arg0: &GridSpec) : u64 {
        arg0.width
    }

    public fun zone_rank(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x1::option::Option<u64> {
        if (!in_grid(arg4)) {
            return 0x1::option::none<u64>()
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_point()) {
            return if (arg4 == arg2) {
                0x1::option::some<u64>(0)
            } else {
                0x1::option::none<u64>()
            }
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_line()) {
            return line_rank(arg2, arg3, arg1, arg4)
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_tbar()) {
            return tbar_rank(arg2, arg3, arg1, arg4)
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_podium()) {
            let v1 = tbar_rank(arg2, arg3, arg1, arg4);
            if (0x1::option::is_some<u64>(&v1)) {
                return v1
            };
            let v2 = away_dir(arg3, arg2);
            let v3 = step_cell(arg2, v2);
            return if (0x1::option::is_some<u64>(&v3) && *0x1::option::borrow<u64>(&v3) == arg4) {
                0x1::option::some<u64>(tbar_length(arg2, v2, arg1))
            } else {
                0x1::option::none<u64>()
            }
        };
        if (arg0 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::shape_cone()) {
            return cone_rank(arg2, arg3, arg1, arg4)
        };
        if (!in_zone(arg0, arg1, arg2, arg4)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(arg4)
    }

    // decompiled from Move bytecode v7
}

