module 0x377fcdb8080b8c040a8b5e3d19032fbe3200667d5de67541c2627e01c5a63b5::bet_manager {
    struct BetManager has drop, store {
        house_edge: vector<u64>,
        combo_edge: vector<u64>,
    }

    struct BetSetting has drop, store {
        odd_weights: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct BetOption has copy, drop, store {
        target: u64,
        range: vector<u64>,
    }

    public fun get_bet_option_data(arg0: &BetOption) : (u64, vector<u64>) {
        (arg0.target, arg0.range)
    }

    public(friend) fun get_bet_payout(arg0: &BetManager, arg1: &BetSetting, arg2: u64, arg3: u8, arg4: u8, arg5: vector<BetOption>, arg6: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<BetOption>(&arg5);
        assert!(v0 <= (arg4 as u64), 3);
        let v1 = 0x1::vector::length<u64>(&arg6);
        let v2 = 0;
        let v3 = 0x2::vec_set::empty<u64>();
        let v4 = 0;
        let v5 = 0;
        while (v2 < v0) {
            let (v6, v7) = get_bet_option_data(0x1::vector::borrow<BetOption>(&arg5, v2));
            let v8 = v7;
            let v9 = v6;
            if (arg3 == 4) {
                let v10 = 0;
                assert!(v9 < v1, 2);
                while (v10 < 0x1::vector::length<u64>(&v8)) {
                    assert!(0x1::vector::contains<u64>(&arg6, 0x1::vector::borrow<u64>(&v8, v10)), 1);
                    v10 = v10 + 1;
                };
            } else {
                assert!(0x1::vector::contains<u64>(&arg6, &v9), 1);
                if (arg3 == 0) {
                    assert!(0x1::vector::length<u64>(&v8) == 1, 2);
                    assert!(*0x1::vector::borrow<u64>(&v8, 0) < v1, 2);
                    assert!(!0x2::vec_set::contains<u64>(&v3, 0x1::vector::borrow<u64>(&v8, 0)), 7);
                    0x2::vec_set::insert<u64>(&mut v3, *0x1::vector::borrow<u64>(&v8, 0));
                } else if (arg3 == 1) {
                    assert!((*0x1::vector::borrow<u64>(&v8, 0) as u64) < 2, 2);
                } else if (arg3 == 2) {
                    assert!(0x1::vector::length<u64>(&v8) == 1, 2);
                    assert!(0x1::vector::contains<u64>(&arg6, 0x1::vector::borrow<u64>(&v8, 0)), 1);
                } else {
                    let v11 = 0;
                    while (v11 < 0x1::vector::length<u64>(&v8)) {
                        assert!(*0x1::vector::borrow<u64>(&v8, v11) < v1, 2);
                        v11 = v11 + 1;
                    };
                };
            };
            if (v2 == 0) {
                if (arg3 == 1 || arg3 == 2) {
                    v4 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(5, 100000, v1);
                } else {
                    v4 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(0x1::vector::length<u64>(&v8), 100000, v1);
                };
            } else {
                let v12 = if (arg3 == 1 || arg3 == 2) {
                    0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(5, 100000, v1)
                } else {
                    0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(0x1::vector::length<u64>(&v8), 100000, v1)
                };
                v4 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(v12, v4, 100000);
            };
            let v13 = if (v2 == 0) {
                0
            } else {
                get_edge(arg0, arg3, *0x1::vector::borrow<BetOption>(&arg5, v2), 1)
            };
            let v14 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::precision() - get_edge(arg0, arg3, *0x1::vector::borrow<BetOption>(&arg5, 0), 0) - v2 * v13, 10000, v4);
            v5 = v14;
            if (arg3 != 4) {
                v5 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(v14, *0x2::vec_map::get<u64, u64>(&arg1.odd_weights, &v9), 1);
            };
            v2 = v2 + 1;
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(arg2, v5, 100000)
    }

    public fun get_combo_edge(arg0: &BetManager) : vector<u64> {
        arg0.combo_edge
    }

    fun get_edge(arg0: &BetManager, arg1: u8, arg2: BetOption, arg3: u8) : u64 {
        if (arg3 == 0) {
            if (arg1 == 1 || arg1 == 2) {
                *0x1::vector::borrow<u64>(&arg0.house_edge, 1)
            } else if (arg1 == 3 || arg1 == 4) {
                let (_, v2) = get_bet_option_data(&arg2);
                let v3 = v2;
                assert!(0x1::vector::length<u64>(&v3) <= 8 && 0x1::vector::length<u64>(&v3) >= 2, 2);
                if (0x1::vector::length<u64>(&v3) == 2) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 2)
                } else if (0x1::vector::length<u64>(&v3) == 3) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 3)
                } else if (0x1::vector::length<u64>(&v3) == 4) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 4)
                } else if (0x1::vector::length<u64>(&v3) == 5) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 5)
                } else if (0x1::vector::length<u64>(&v3) == 6) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 6)
                } else if (0x1::vector::length<u64>(&v3) == 7) {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 7)
                } else {
                    *0x1::vector::borrow<u64>(&arg0.house_edge, 8)
                }
            } else {
                *0x1::vector::borrow<u64>(&arg0.house_edge, 0)
            }
        } else if (arg1 == 1 || arg1 == 2) {
            *0x1::vector::borrow<u64>(&arg0.combo_edge, 1)
        } else if (arg1 == 3 || arg1 == 4) {
            let (_, v5) = get_bet_option_data(&arg2);
            let v6 = v5;
            assert!(0x1::vector::length<u64>(&v6) <= 8 && 0x1::vector::length<u64>(&v6) >= 2, 2);
            if (0x1::vector::length<u64>(&v6) == 2) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 2)
            } else if (0x1::vector::length<u64>(&v6) == 3) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 3)
            } else if (0x1::vector::length<u64>(&v6) == 4) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 4)
            } else if (0x1::vector::length<u64>(&v6) == 5) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 5)
            } else if (0x1::vector::length<u64>(&v6) == 6) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 6)
            } else if (0x1::vector::length<u64>(&v6) == 7) {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 7)
            } else {
                *0x1::vector::borrow<u64>(&arg0.combo_edge, 8)
            }
        } else {
            *0x1::vector::borrow<u64>(&arg0.combo_edge, 0)
        }
    }

    public fun get_house_edge(arg0: &BetManager) : vector<u64> {
        arg0.house_edge
    }

    public(friend) fun new_bet_manager() : BetManager {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 5, 10));
        0x1::vector::push_back<u64>(v1, 100000);
        0x1::vector::push_back<u64>(v1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 8, 10));
        0x1::vector::push_back<u64>(v1, 100000);
        0x1::vector::push_back<u64>(v1, 100000);
        0x1::vector::push_back<u64>(v1, 100000);
        0x1::vector::push_back<u64>(v1, 100000);
        0x1::vector::push_back<u64>(v1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 9, 10));
        0x1::vector::push_back<u64>(v1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 8, 10));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 5, 10));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 75, 100));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 4, 10));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 45, 100));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 5, 10));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 75, 100));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 45, 100));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 28, 100));
        0x1::vector::push_back<u64>(v3, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(100000, 4, 10));
        BetManager{
            house_edge : v0,
            combo_edge : v2,
        }
    }

    public(friend) fun new_bet_option(arg0: u64, arg1: vector<u64>) : BetOption {
        BetOption{
            target : arg0,
            range  : arg1,
        }
    }

    public(friend) fun new_bet_setting(arg0: vector<u64>) : BetSetting {
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x2::vec_map::insert<u64, u64>(&mut v0, *0x1::vector::borrow<u64>(&arg0, v1), 1);
            v1 = v1 + 1;
        };
        BetSetting{odd_weights: v0}
    }

    public(friend) fun set_combo_edges(arg0: &mut BetManager, arg1: vector<u64>) {
        arg0.combo_edge = arg1;
    }

    public(friend) fun set_house_edges(arg0: &mut BetManager, arg1: vector<u64>) {
        arg0.house_edge = arg1;
    }

    public(friend) fun set_single_combo_edge(arg0: &mut BetManager, arg1: u64, arg2: u8) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.combo_edge, (arg2 as u64)) = arg1;
    }

    public(friend) fun set_single_house_edge(arg0: &mut BetManager, arg1: u64, arg2: u8) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.house_edge, (arg2 as u64)) = arg1;
    }

    public(friend) fun won_bet(arg0: vector<BetOption>, arg1: u8, arg2: vector<u64>) : bool {
        let v0 = false;
        let v1 = 0;
        if (arg1 == 0) {
            while (v1 < 0x1::vector::length<BetOption>(&arg0)) {
                v0 = false;
                let v2 = *0x1::vector::borrow<BetOption>(&arg0, v1);
                if ((*0x1::vector::borrow<u64>(&v2.range, 0) as u64) >= 0x1::vector::length<u64>(&arg2)) {
                    break
                };
                if (v2.target == *0x1::vector::borrow<u64>(&arg2, (*0x1::vector::borrow<u64>(&v2.range, 0) as u64))) {
                    v0 = true;
                    v1 = v1 + 1;
                } else {
                    break
                };
            };
        } else if (arg1 == 1) {
            while (v1 < 0x1::vector::length<BetOption>(&arg0)) {
                v0 = false;
                let v3 = *0x1::vector::borrow<BetOption>(&arg0, v1);
                if ((*0x1::vector::borrow<u64>(&v3.range, 0) as u64) >= 2) {
                    break
                };
                let (v4, v5) = 0x1::vector::index_of<u64>(&arg2, &v3.target);
                if (!v4) {
                    break
                };
                if ((*0x1::vector::borrow<u64>(&v3.range, 0) as u64) == 0) {
                    if ((v5 + 1) % 2 == 0) {
                        v0 = true;
                    } else {
                        break
                    };
                } else if ((v5 + 1) % 2 == 1) {
                    v0 = true;
                } else {
                    break
                };
                v1 = v1 + 1;
            };
        } else if (arg1 == 2) {
            while (v1 < 0x1::vector::length<BetOption>(&arg0)) {
                v0 = false;
                let v6 = *0x1::vector::borrow<BetOption>(&arg0, v1);
                if (0x1::vector::length<u64>(&v6.range) > 1) {
                    break
                };
                let (v7, v8) = 0x1::vector::index_of<u64>(&arg2, &v6.target);
                let (v9, v10) = 0x1::vector::index_of<u64>(&arg2, 0x1::vector::borrow<u64>(&v6.range, 0));
                if (!v7) {
                    break
                };
                if (!v9 || v8 < v10) {
                    v0 = true;
                    v1 = v1 + 1;
                } else {
                    break
                };
            };
        } else if (arg1 == 3) {
            while (v1 < 0x1::vector::length<BetOption>(&arg0)) {
                v0 = false;
                let v11 = *0x1::vector::borrow<BetOption>(&arg0, v1);
                if (0x1::vector::length<u64>(&v11.range) < 2 || 0x1::vector::length<u64>(&v11.range) > 8) {
                    break
                };
                let (v12, v13) = 0x1::vector::index_of<u64>(&arg2, &v11.target);
                if (!v12) {
                    break
                };
                let v14 = v13 + 1;
                if (0x1::vector::contains<u64>(&v11.range, &v14)) {
                    v0 = true;
                    v1 = v1 + 1;
                } else {
                    break
                };
            };
        } else if (arg1 == 4) {
            while (v1 < 0x1::vector::length<BetOption>(&arg0)) {
                v0 = false;
                let v15 = *0x1::vector::borrow<BetOption>(&arg0, v1);
                if (0x1::vector::length<u64>(&v15.range) < 2 || 0x1::vector::length<u64>(&v15.range) > 8) {
                    break
                };
                let v16 = *0x1::vector::borrow<u64>(&arg2, v15.target);
                if (0x1::vector::contains<u64>(&v15.range, &v16)) {
                    v0 = true;
                    v1 = v1 + 1;
                } else {
                    break
                };
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

