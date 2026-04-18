module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::topology {
    struct Part has copy, drop, store {
        xs: vector<u64>,
        ys: vector<u64>,
        aabb: 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB,
    }

    struct EdgeKey has copy, drop, store {
        start_x: u64,
        start_y: u64,
        end_x: u64,
        end_y: u64,
    }

    struct EdgeCount has copy, drop, store {
        key: EdgeKey,
        count: u64,
    }

    struct VertexKey has copy, drop, store {
        x: u64,
        y: u64,
    }

    public(friend) fun aabbs_may_contact(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB) : bool {
        if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(arg0) <= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(arg1)) {
            if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_x(arg0) >= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_x(arg1)) {
                if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(arg0) <= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(arg1)) {
                    0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::max_y(arg0) >= 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::min_y(arg1)
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

    fun append_part_edges(arg0: &Part, arg1: &mut vector<EdgeCount>) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = if (v1 + 1 < v0) {
                v1 + 1
            } else {
                0
            };
            let v3 = normalize_edge(*0x1::vector::borrow<u64>(&arg0.xs, v1), *0x1::vector::borrow<u64>(&arg0.ys, v1), *0x1::vector::borrow<u64>(&arg0.xs, v2), *0x1::vector::borrow<u64>(&arg0.ys, v2));
            let v4 = false;
            let v5 = 0;
            let v6 = 0x1::vector::length<EdgeCount>(arg1);
            while (v5 < v6) {
                let v7 = 0x1::vector::borrow_mut<EdgeCount>(arg1, v5);
                if (edge_keys_equal(&v7.key, &v3)) {
                    v7.count = v7.count + 1;
                    if (v7.count > 2) {
                        return 2009
                    };
                    v4 = true;
                    v5 = v6;
                    continue
                };
                v5 = v5 + 1;
            };
            if (!v4) {
                let v8 = EdgeCount{
                    key   : v3,
                    count : 1,
                };
                0x1::vector::push_back<EdgeCount>(arg1, v8);
            };
            v1 = v1 + 1;
        };
        0
    }

    fun boundary_graph_connected(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) : bool {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0);
        *0x1::vector::borrow_mut<bool>(&mut v0, 0) = true;
        let v3 = 0;
        let v4 = 1;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v5 = *0x1::vector::borrow<u64>(&v2, v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<u64>(arg0)) {
                let v7 = *0x1::vector::borrow<u64>(arg0, v6);
                let v8 = if (v7 == v5) {
                    *0x1::vector::borrow<u64>(arg1, v6)
                } else if (*0x1::vector::borrow<u64>(arg1, v6) == v5) {
                    v7
                } else {
                    arg2
                };
                if (v8 < arg2 && !*0x1::vector::borrow<bool>(&v0, v8)) {
                    *0x1::vector::borrow_mut<bool>(&mut v0, v8) = true;
                    0x1::vector::push_back<u64>(&mut v2, v8);
                    v4 = v4 + 1;
                };
                v6 = v6 + 1;
            };
            v3 = v3 + 1;
        };
        v4 == arg2
    }

    fun collect_edge_counts(arg0: &vector<Part>) : (vector<EdgeCount>, u64) {
        let v0 = 0x1::vector::empty<EdgeCount>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Part>(arg0)) {
            let v2 = &mut v0;
            let v3 = append_part_edges(0x1::vector::borrow<Part>(arg0, v1), v2);
            if (v3 != 0) {
                return (v0, v3)
            };
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    fun compute_shared_edge_components(arg0: &vector<u8>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg1) {
            if (*0x1::vector::borrow<u64>(&v0, v3) < arg1) {
                v3 = v3 + 1;
                continue
            };
            *0x1::vector::borrow_mut<u64>(&mut v0, v3) = v2;
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u64>(&v4)) {
                let v6 = 0;
                while (v6 < arg1) {
                    if (relation_at(arg0, arg1, *0x1::vector::borrow<u64>(&v4, v5), v6) == 1 && *0x1::vector::borrow<u64>(&v0, v6) == arg1) {
                        *0x1::vector::borrow_mut<u64>(&mut v0, v6) = v2;
                        0x1::vector::push_back<u64>(&mut v4, v6);
                    };
                    v6 = v6 + 1;
                };
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
            v3 = v3 + 1;
        };
        v0
    }

    fun edge_keys_equal(arg0: &EdgeKey, arg1: &EdgeKey) : bool {
        if (arg0.start_x == arg1.start_x) {
            if (arg0.start_y == arg1.start_y) {
                if (arg0.end_x == arg1.end_x) {
                    arg0.end_y == arg1.end_y
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

    fun edge_l1_length(arg0: &EdgeKey) : u128 {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::sub_u64(arg0.end_x, arg0.start_x);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::sub_u64(arg0.end_y, arg0.start_y);
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(&v0) + 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(&v1)
    }

    fun edges_match_exactly(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        let v0 = normalize_edge(arg0, arg1, arg2, arg3);
        let v1 = normalize_edge(arg4, arg5, arg6, arg7);
        edge_keys_equal(&v0, &v1)
    }

    fun empty_relation_matrix(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0 * arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    fun find_or_push_vertex(arg0: &mut vector<VertexKey>, arg1: &mut vector<u64>, arg2: u64, arg3: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VertexKey>(arg0)) {
            let v1 = 0x1::vector::borrow<VertexKey>(arg0, v0);
            if (v1.x == arg2 && v1.y == arg3) {
                return v0
            };
            v0 = v0 + 1;
        };
        let v2 = VertexKey{
            x : arg2,
            y : arg3,
        };
        0x1::vector::push_back<VertexKey>(arg0, v2);
        0x1::vector::push_back<u64>(arg1, 0);
        0x1::vector::length<VertexKey>(arg0) - 1
    }

    public(friend) fun has_exact_shared_edge(arg0: &Part, arg1: &Part) : bool {
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = 0x1::vector::length<u64>(&arg1.xs);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = if (v2 + 1 < v0) {
                v2 + 1
            } else {
                0
            };
            let v4 = 0;
            while (v4 < v1) {
                let v5 = if (v4 + 1 < v1) {
                    v4 + 1
                } else {
                    0
                };
                if (edges_match_exactly(*0x1::vector::borrow<u64>(&arg0.xs, v2), *0x1::vector::borrow<u64>(&arg0.ys, v2), *0x1::vector::borrow<u64>(&arg0.xs, v3), *0x1::vector::borrow<u64>(&arg0.ys, v3), *0x1::vector::borrow<u64>(&arg1.xs, v4), *0x1::vector::borrow<u64>(&arg1.ys, v4), *0x1::vector::borrow<u64>(&arg1.xs, v5), *0x1::vector::borrow<u64>(&arg1.ys, v5))) {
                    return true
                };
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        false
    }

    public(friend) fun is_zero(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed) : bool {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::magnitude(arg0) == 0
    }

    fun normalize_edge(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : EdgeKey {
        if (point_precedes(arg0, arg1, arg2, arg3)) {
            EdgeKey{start_x: arg0, start_y: arg1, end_x: arg2, end_y: arg3}
        } else {
            EdgeKey{start_x: arg2, start_y: arg3, end_x: arg0, end_y: arg1}
        }
    }

    fun opposite_signs(arg0: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed, arg1: &0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::Signed) : bool {
        if (!is_zero(arg0)) {
            if (!is_zero(arg1)) {
                0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::is_negative(arg0) != 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::is_negative(arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun part(arg0: vector<u64>, arg1: vector<u64>, arg2: 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::aabb::AABB) : Part {
        Part{
            xs   : arg0,
            ys   : arg1,
            aabb : arg2,
        }
    }

    fun part_area_and_perimeter(arg0: &Part) : (u128, u128) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = *0x1::vector::borrow<u64>(&arg0.xs, 0);
        let v4 = *0x1::vector::borrow<u64>(&arg0.ys, 0);
        let v5 = 1;
        while (v5 < 0x1::vector::length<u64>(&arg0.xs)) {
            let v6 = *0x1::vector::borrow<u64>(&arg0.xs, v5);
            let v7 = *0x1::vector::borrow<u64>(&arg0.ys, v5);
            let v8 = (v3 as u128) * (v7 as u128);
            let v9 = (v6 as u128) * (v4 as u128);
            if (v8 >= v9) {
                v0 = v0 + v8 - v9;
            } else {
                v1 = v1 + v9 - v8;
            };
            let v10 = if (v6 >= v3) {
                ((v6 - v3) as u128)
            } else {
                ((v3 - v6) as u128)
            };
            let v11 = if (v7 >= v4) {
                ((v7 - v4) as u128)
            } else {
                ((v4 - v7) as u128)
            };
            let v12 = v2 + v10;
            v2 = v12 + v11;
            v3 = v6;
            v4 = v7;
            v5 = v5 + 1;
        };
        let v13 = (v3 as u128) * (v4 as u128);
        let v14 = (v3 as u128) * (v4 as u128);
        if (v13 >= v14) {
            v0 = v0 + v13 - v14;
        } else {
            v1 = v1 + v14 - v13;
        };
        let v15 = if (v3 >= v3) {
            ((v3 - v3) as u128)
        } else {
            ((v3 - v3) as u128)
        };
        let v16 = if (v4 >= v4) {
            ((v4 - v4) as u128)
        } else {
            ((v4 - v4) as u128)
        };
        let v17 = if (v0 >= v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        (v17, v2 + v15 + v16)
    }

    fun part_topology_relation(arg0: &Part, arg1: &Part) : (u8, u64) {
        if (!aabbs_may_contact(&arg0.aabb, &arg1.aabb)) {
            return (0, 0)
        };
        if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::sat::overlaps(&arg0.xs, &arg0.ys, &arg1.xs, &arg1.ys)) {
            return (0, 2006)
        };
        if (has_exact_shared_edge(arg0, arg1)) {
            return (1, 0)
        };
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = 0x1::vector::length<u64>(&arg1.xs);
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = if (v4 + 1 < v0) {
                v4 + 1
            } else {
                0
            };
            let v6 = *0x1::vector::borrow<u64>(&arg0.xs, v4);
            let v7 = *0x1::vector::borrow<u64>(&arg0.ys, v4);
            let v8 = *0x1::vector::borrow<u64>(&arg0.xs, v5);
            let v9 = *0x1::vector::borrow<u64>(&arg0.ys, v5);
            let v10 = 0;
            while (v10 < v1) {
                let v11 = if (v10 + 1 < v1) {
                    v10 + 1
                } else {
                    0
                };
                let v12 = *0x1::vector::borrow<u64>(&arg1.xs, v10);
                let v13 = *0x1::vector::borrow<u64>(&arg1.ys, v10);
                let v14 = *0x1::vector::borrow<u64>(&arg1.xs, v11);
                let v15 = *0x1::vector::borrow<u64>(&arg1.ys, v11);
                if (edges_match_exactly(v6, v7, v8, v9, v12, v13, v14, v15)) {
                    v2 = true;
                } else if (segments_contact(v6, v7, v8, v9, v12, v13, v14, v15)) {
                    v3 = true;
                };
                v10 = v10 + 1;
            };
            v4 = v4 + 1;
        };
        if (v2) {
            (1, 0)
        } else if (v3) {
            (2, 0)
        } else {
            (0, 0)
        }
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

    fun point_on_segment(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::cross_sign(arg0, arg1, arg2, arg3, arg4, arg5);
        if (is_zero(&v0)) {
            if (within(arg0, arg2, arg4)) {
                within(arg1, arg3, arg5)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun point_precedes(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 < arg2 || arg0 == arg2 && arg1 <= arg3
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

    fun relation_at(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u64) : u8 {
        *0x1::vector::borrow<u8>(arg0, arg2 * arg1 + arg3)
    }

    fun segments_contact(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::cross_sign(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::cross_sign(arg0, arg1, arg2, arg3, arg6, arg7);
        let v2 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::cross_sign(arg4, arg5, arg6, arg7, arg0, arg1);
        let v3 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::signed::cross_sign(arg4, arg5, arg6, arg7, arg2, arg3);
        if (is_zero(&v0) && point_on_segment(arg0, arg1, arg2, arg3, arg4, arg5)) {
            return true
        };
        if (is_zero(&v1) && point_on_segment(arg0, arg1, arg2, arg3, arg6, arg7)) {
            return true
        };
        if (is_zero(&v2) && point_on_segment(arg4, arg5, arg6, arg7, arg0, arg1)) {
            return true
        };
        if (is_zero(&v3) && point_on_segment(arg4, arg5, arg6, arg7, arg2, arg3)) {
            return true
        };
        opposite_signs(&v0, &v1) && opposite_signs(&v2, &v3)
    }

    fun set_relation(arg0: &mut vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u8) {
        *0x1::vector::borrow_mut<u8>(arg0, arg2 * arg1 + arg3) = arg4;
    }

    public(friend) fun shared_edge_relation(arg0: &Part, arg1: &Part) : (bool, u64) {
        if (!aabbs_may_contact(&arg0.aabb, &arg1.aabb)) {
            return (false, 0)
        };
        if (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::sat::overlaps(&arg0.xs, &arg0.ys, &arg1.xs, &arg1.ys)) {
            return (false, 2006)
        };
        if (has_exact_shared_edge(arg0, arg1)) {
            return (true, 0)
        };
        let v0 = 0x1::vector::length<u64>(&arg0.xs);
        let v1 = 0x1::vector::length<u64>(&arg1.xs);
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = if (v4 + 1 < v0) {
                v4 + 1
            } else {
                0
            };
            let v6 = *0x1::vector::borrow<u64>(&arg0.xs, v4);
            let v7 = *0x1::vector::borrow<u64>(&arg0.ys, v4);
            let v8 = *0x1::vector::borrow<u64>(&arg0.xs, v5);
            let v9 = *0x1::vector::borrow<u64>(&arg0.ys, v5);
            let v10 = 0;
            while (v10 < v1) {
                let v11 = if (v10 + 1 < v1) {
                    v10 + 1
                } else {
                    0
                };
                let v12 = *0x1::vector::borrow<u64>(&arg1.xs, v10);
                let v13 = *0x1::vector::borrow<u64>(&arg1.ys, v10);
                let v14 = *0x1::vector::borrow<u64>(&arg1.xs, v11);
                let v15 = *0x1::vector::borrow<u64>(&arg1.ys, v11);
                if (edges_match_exactly(v6, v7, v8, v9, v12, v13, v14, v15)) {
                    v2 = true;
                } else if (segments_contact(v6, v7, v8, v9, v12, v13, v14, v15)) {
                    v3 = true;
                };
                v10 = v10 + 1;
            };
            v4 = v4 + 1;
        };
        if (v3 && !v2) {
            return (false, 2007)
        };
        (v2, 0)
    }

    fun validate_boundary_graph(arg0: &vector<EdgeCount>) : (u128, u64) {
        let v0 = 0x1::vector::empty<VertexKey>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<EdgeCount>(arg0)) {
            let v6 = 0x1::vector::borrow<EdgeCount>(arg0, v5);
            if (v6.count != 1 && v6.count != 2) {
                return (0, 2009)
            };
            if (v6.count == 1) {
                let v7 = &mut v0;
                let v8 = &mut v1;
                let v9 = find_or_push_vertex(v7, v8, v6.key.start_x, v6.key.start_y);
                let v10 = &mut v0;
                let v11 = &mut v1;
                let v12 = find_or_push_vertex(v10, v11, v6.key.end_x, v6.key.end_y);
                let v13 = 0x1::vector::borrow_mut<u64>(&mut v1, v9);
                *v13 = *v13 + 1;
                let v14 = 0x1::vector::borrow_mut<u64>(&mut v1, v12);
                *v14 = *v14 + 1;
                0x1::vector::push_back<u64>(&mut v2, v9);
                0x1::vector::push_back<u64>(&mut v3, v12);
                v4 = v4 + edge_l1_length(&v6.key);
            };
            v5 = v5 + 1;
        };
        let v15 = 0x1::vector::length<u64>(&v2);
        let v16 = 0x1::vector::length<VertexKey>(&v0);
        if (v15 == 0) {
            return (0, 2009)
        };
        if (v15 != v16) {
            return (0, 2009)
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v1)) {
            if (*0x1::vector::borrow<u64>(&v1, v5) != 2) {
                return (0, 2009)
            };
            v5 = v5 + 1;
        };
        if (!boundary_graph_connected(&v2, &v3, v16)) {
            return (0, 2009)
        };
        (v4, 0)
    }

    fun validate_compactness(arg0: u128, arg1: u128) : u64 {
        let v0 = 0x1::u128::checked_mul(arg1, arg1);
        if (!0x1::option::is_some<u128>(&v0)) {
            return 2011
        };
        let v1 = 0x1::u128::checked_mul(150000, 0x1::option::destroy_some<u128>(v0));
        if (!0x1::option::is_some<u128>(&v1)) {
            return 2011
        };
        let v2 = 0x1::u128::checked_mul(8000000, arg0);
        if (0x1::option::is_some<u128>(&v2)) {
            if (0x1::option::destroy_some<u128>(v2) < 0x1::option::destroy_some<u128>(v1)) {
                return 2011
            };
        };
        0
    }

    public(friend) fun validate_multipart_topology(arg0: &vector<Part>) : u64 {
        let v0 = 0x1::vector::length<Part>(arg0);
        if (v0 == 1) {
            let (v1, v2) = part_area_and_perimeter(0x1::vector::borrow<Part>(arg0, 0));
            return validate_compactness(v1, v2)
        };
        let v3 = empty_relation_matrix(v0);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<Part>(arg0, v4);
            let v6 = v4 + 1;
            while (v6 < v0) {
                let (v7, v8) = part_topology_relation(v5, 0x1::vector::borrow<Part>(arg0, v6));
                if (v8 != 0) {
                    return v8
                };
                if (v7 != 0) {
                    let v9 = &mut v3;
                    set_relation(v9, v0, v4, v6, v7);
                    let v10 = &mut v3;
                    set_relation(v10, v0, v6, v4, v7);
                };
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        let v11 = compute_shared_edge_components(&v3, v0);
        v4 = 0;
        while (v4 < v0) {
            let v12 = v4 + 1;
            while (v12 < v0) {
                if (relation_at(&v3, v0, v4, v12) == 2) {
                    if (*0x1::vector::borrow<u64>(&v11, v4) != *0x1::vector::borrow<u64>(&v11, v12)) {
                        return 2007
                    };
                };
                v12 = v12 + 1;
            };
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < v0) {
            if (*0x1::vector::borrow<u64>(&v11, v4) != 0) {
                return 2008
            };
            v4 = v4 + 1;
        };
        let (v13, v14) = collect_edge_counts(arg0);
        let v15 = v13;
        if (v14 != 0) {
            return v14
        };
        let (v16, v17) = validate_boundary_graph(&v15);
        if (v17 != 0) {
            return v17
        };
        validate_compactness(polygon_twice_area_fp2(arg0), v16)
    }

    fun within(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        arg2 >= v0 && arg2 <= v1
    }

    // decompiled from Move bytecode v7
}

