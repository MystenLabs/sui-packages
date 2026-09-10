module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge {
    struct ForgeResult has copy, drop {
        outcome: u8,
        new_stats: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics,
        new_puits: u64,
        applied_value: u64,
        lost_amounts: vector<u64>,
    }

    public fun add_counts(arg0: &mut vector<u64>, arg1: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            *0x1::vector::borrow_mut<u64>(arg0, v0) = *0x1::vector::borrow<u64>(arg0, v0) + *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
        };
    }

    public fun applied_value(arg0: &ForgeResult) : u64 {
        arg0.applied_value
    }

    public fun apply_rune(arg0: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg1: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg2: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg3: u8, arg4: u8, arg5: u64, arg6: &mut u64) : ForgeResult {
        assert!(can_apply_rune(&arg0, &arg2, arg3, arg4), 1);
        let (v0, v1) = outcome_chances(&arg0, &arg1, &arg2, arg3, arg4);
        let v2 = vector[];
        let v3 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&arg0);
        0x1::vector::reverse<u16>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u16>(&v3)) {
            0x1::vector::push_back<u64>(&mut v2, (0x1::vector::pop_back<u16>(&mut v3) as u64));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(v3);
        let v5 = vector[];
        let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&arg1);
        0x1::vector::reverse<u16>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u16>(&v6)) {
            0x1::vector::push_back<u64>(&mut v5, (0x1::vector::pop_back<u16>(&mut v6) as u64));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u16>(v6);
        let v8 = vector[];
        let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&arg2);
        0x1::vector::reverse<u16>(&mut v9);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u16>(&v9)) {
            0x1::vector::push_back<u64>(&mut v8, (0x1::vector::pop_back<u16>(&mut v9) as u64));
            v10 = v10 + 1;
        };
        0x1::vector::destroy_empty<u16>(v9);
        let v11 = vector[];
        let v12 = 0;
        while (v12 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            0x1::vector::push_back<u64>(&mut v11, min_u64(*0x1::vector::borrow<u64>(&v2, v12), min_u64(*0x1::vector::borrow<u64>(&v5, v12), (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::shift() as u64))));
            v12 = v12 + 1;
        };
        let v13 = vector[];
        let v14 = 0;
        while (v14 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            0x1::vector::push_back<u64>(&mut v13, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_unit_weight((v14 as u8)));
            v14 = v14 + 1;
        };
        let v15 = 0;
        let v16 = &v13;
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(v16)) {
            v15 = max_u64(v15, *0x1::vector::borrow<u64>(v16, v17));
            v17 = v17 + 1;
        };
        assert!(arg5 <= 18446744073709551615 - v15, 3);
        let v18 = (arg3 as u64);
        let v19 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg6) % 1000000;
        let v20 = ((flag(v19 >= v0) + flag(v19 >= v1)) as u8);
        *0x1::vector::borrow_mut<u64>(&mut v2, v18) = *0x1::vector::borrow<u64>(&v2, v18) + choose(v20 != 2, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(arg3, arg4), 0);
        let v21 = choose(v20 != 0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_weight(arg3, arg4), 0);
        let v22 = arg5;
        let v23 = shuffled_stats(arg6);
        let v24 = 0;
        while (v24 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            let v25 = *0x1::vector::borrow<u64>(&v23, v24);
            let v26 = &mut v2;
            let v27 = &mut v21;
            let v28 = &mut v22;
            pay_stat(v26, v25, *0x1::vector::borrow<u64>(&v8, v25), *0x1::vector::borrow<u64>(&v13, v25), v25 != v18, v27, v28);
            v24 = v24 + 1;
        };
        let v29 = min_u64(v22, v21);
        let v30 = v22;
        v22 = v30 - v29;
        let v31 = v21;
        v21 = v31 - v29;
        let v32 = &mut v2;
        let v33 = &mut v21;
        let v34 = &mut v22;
        pay_stat(v32, v18, *0x1::vector::borrow<u64>(&v8, v18), *0x1::vector::borrow<u64>(&v13, v18), true, v33, v34);
        v24 = 0;
        while (v24 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            let v35 = *0x1::vector::borrow<u64>(&v23, v24);
            let v36 = &mut v2;
            let v37 = &mut v21;
            let v38 = &mut v22;
            pay_stat(v36, v35, *0x1::vector::borrow<u64>(&v11, v35), *0x1::vector::borrow<u64>(&v13, v35), v35 != v18, v37, v38);
            v24 = v24 + 1;
        };
        let v39 = &mut v2;
        let v40 = &mut v21;
        let v41 = &mut v22;
        pay_stat(v39, v18, *0x1::vector::borrow<u64>(&v11, v18), *0x1::vector::borrow<u64>(&v13, v18), true, v40, v41);
        let v42 = vector[];
        let v43 = 0;
        while (v43 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            0x1::vector::push_back<u64>(&mut v42, sat_sub(*0x1::vector::borrow<u64>(&v2, v43), *0x1::vector::borrow<u64>(&v2, v43)));
            v43 = v43 + 1;
        };
        let v44 = vector[];
        0x1::vector::reverse<u64>(&mut v2);
        let v45 = 0;
        while (v45 < 0x1::vector::length<u64>(&v2)) {
            0x1::vector::push_back<u16>(&mut v44, (0x1::vector::pop_back<u64>(&mut v2) as u16));
            v45 = v45 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        ForgeResult{
            outcome       : v20,
            new_stats     : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::from_vector(v44),
            new_puits     : v22,
            applied_value : sat_sub(*0x1::vector::borrow<u64>(&v2, v18), *0x1::vector::borrow<u64>(&v2, v18)),
            lost_amounts  : v42,
        }
    }

    public fun can_apply_rune(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg2: u8, arg3: u8) : bool {
        if (!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::has_rune(arg2, arg3)) {
            return false
        };
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(arg0);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(arg1);
        let v2 = (arg2 as u64);
        let v3 = (*0x1::vector::borrow<u16>(&v0, v2) as u64);
        let v4 = (*0x1::vector::borrow<u16>(&v1, v2) as u64);
        let v5 = v3 + 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(arg2, arg3);
        let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_unit_weight(arg2);
        let v7 = 101 * 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::weight_scale();
        if (v5 > max_u64(v4, (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::shift() as u64) + v7 / v6)) {
            return false
        };
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            v8 = v8 + sat_sub((*0x1::vector::borrow<u16>(&v0, v9) as u64), (*0x1::vector::borrow<u16>(&v1, v9) as u64)) * 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_unit_weight((v9 as u8));
            v9 = v9 + 1;
        };
        let v10 = v8 - sat_sub(v3, v4) * v6 + sat_sub(v5, v4) * v6;
        v10 <= v7 || v10 <= v8
    }

    fun choose(arg0: bool, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg1);
        *0x1::vector::borrow<u64>(&v0, flag(arg0))
    }

    public fun crush_lines(arg0: &vector<u64>, arg1: &mut u64) : vector<u64> {
        let v0 = zero_counts();
        let v1 = 0;
        while (v1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            let v3 = (v1 as u8);
            if (v2 > 0) {
                let v4 = stochastic_round(v2 * 1, 4, arg1);
                while (v4 > 0) {
                    let v5 = roll_tier(v3, v2, arg1);
                    let v6 = v5;
                    let v7 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(v3, v5);
                    while (v7 > v4 && v6 > 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::tier_ba()) {
                        let v8 = v6 - 1;
                        v6 = v8;
                        v7 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(v3, v8);
                    };
                    if (v7 > v4) {
                        break
                    };
                    let v9 = v1 * 3 + (v6 as u64) - 1;
                    *0x1::vector::borrow_mut<u64>(&mut v0, v9) = *0x1::vector::borrow<u64>(&v0, v9) + 1;
                    v4 = v4 - v7;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun flag(arg0: bool) : u64 {
        let v0 = 0x1::bcs::to_bytes<bool>(&arg0);
        (*0x1::vector::borrow<u8>(&v0, 0) as u64)
    }

    public fun lost_amounts(arg0: &ForgeResult) : vector<u64> {
        arg0.lost_amounts
    }

    fun max_u64(arg0: u64, arg1: u64) : u64 {
        choose(arg0 > arg1, arg0, arg1)
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        choose(arg0 < arg1, arg0, arg1)
    }

    public fun new_puits(arg0: &ForgeResult) : u64 {
        arg0.new_puits
    }

    public fun new_stats(arg0: &ForgeResult) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        arg0.new_stats
    }

    public fun outcome(arg0: &ForgeResult) : u8 {
        arg0.outcome
    }

    public fun outcome_cf() : u8 {
        2
    }

    public fun outcome_chances(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg2: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg3: u8, arg4: u8) : (u64, u64) {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(arg0);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(arg1);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(arg2);
        let v3 = (arg3 as u64);
        let v4 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::shift() as u64);
        let v5 = (*0x1::vector::borrow<u16>(&v0, v3) as u64);
        let v6 = (*0x1::vector::borrow<u16>(&v1, v3) as u64);
        let v7 = (*0x1::vector::borrow<u16>(&v2, v3) as u64);
        let v8 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(arg3, arg4);
        let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_weight(arg3, arg4);
        let v10 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::weight_scale();
        let v11 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_unit_weight(arg3);
        let v12 = v6 == v4 && v7 == v4;
        if (v12 && v9 > 50 * v10) {
            return (10000, 10000)
        };
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        while (v16 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            let v17 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_unit_weight((v16 as u8));
            v13 = v13 + (*0x1::vector::borrow<u16>(&v0, v16) as u64) * v17;
            v14 = v14 + (*0x1::vector::borrow<u16>(&v1, v16) as u64) * v17;
            v15 = v15 + (*0x1::vector::borrow<u16>(&v2, v16) as u64) * v17;
            v16 = v16 + 1;
        };
        let v18 = max_u64(60 * 10000, quality(v5 + v8, v6, v7));
        let v19 = max_u64(15 * 10000, quality(v13, v14, v15));
        let v20 = if (v12) {
            sat_sub(v5, v4) * 1000000
        } else if (v7 > v4) {
            sat_sub(v5, v4) * 1000000 / (v7 - v4)
        } else {
            quality(v5, v6, v7)
        };
        let v21 = v5 + v8 > v7;
        if (v12 || v21) {
            v18 = 1000000;
        };
        let v22 = if (v9 <= 3 * v10) {
            if (v11 == v10) {
                v20 > 65 * 10000
            } else {
                false
            }
        } else {
            false
        };
        if (v22) {
            v18 = 150 * 10000;
        };
        let v23 = if (!v12) {
            if (v9 <= 3 * v10) {
                if (v11 == v10) {
                    v20 > 80 * 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v23) {
            v18 = 300 * 10000;
        };
        let v24 = if (!v12) {
            if (v9 <= 3 * v10) {
                if (v11 == 3 * v10) {
                    v20 > 85 * 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v24) {
            v18 = 200 * 10000;
        };
        let v25 = if (v12) {
            40
        } else if (v21) {
            60
        } else {
            47
        };
        let v26 = if (v12 || v21) {
            54
        } else {
            50
        };
        if (v12) {
            v19 = 15 * 10000 + sat_sub(v5, v4) * v11 * 10000 / v10 + v9 * 3 * 10000 / v10;
        };
        let v27 = if (!v12 && v19 < 50 * 10000) {
            v19
        } else {
            v19 * v26 / 100
        };
        let v28 = (sat_sub(1000000, v18 * v25 / 100 + v27 + 5 * 10000) + 10000 - 1) / 10000 * 10000;
        let v29 = v28;
        let v30 = if (v28 > 50 * 10000) {
            1000000 - v28
        } else if (v28 < 25 * 10000) {
            v28 + 10 * 10000
        } else {
            50 * 10000
        };
        let v31 = v30;
        if (v21 && !v12) {
            if (v28 <= 10000) {
                v29 = 10000;
                v31 = 22 * 10000;
            };
        } else if (!v12 && v28 < 15 * 10000) {
            v29 = 15 * 10000;
            v31 = 50 * 10000;
        };
        (v29, v29 + v31)
    }

    public fun outcome_cs() : u8 {
        0
    }

    public fun outcome_ns() : u8 {
        1
    }

    fun pay_stat(arg0: &mut vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &mut u64, arg6: &mut u64) {
        let v0 = min_u64(sat_sub(*0x1::vector::borrow<u64>(arg0, arg1), arg2), (*arg5 + arg3 - 1) / arg3) * flag(arg4);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = *0x1::vector::borrow<u64>(arg0, arg1) - v0;
        let v1 = v0 * arg3;
        *arg6 = *arg6 + sat_sub(v1, *arg5);
        *arg5 = sat_sub(*arg5, v1);
    }

    fun quality(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 <= arg1) {
            0
        } else {
            sat_sub(arg0, arg1) * 1000000 / (arg2 - arg1)
        }
    }

    public fun roll_tier(arg0: u8, arg1: u64, arg2: &mut u64) : u8 {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::max_tier(arg0);
        while (v0 > 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::tier_ba()) {
            if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::has_rune(arg0, v0)) {
                let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::rune_amount(arg0, v0);
                if (arg1 >= v1 * 3) {
                    let v2 = if (arg1 * 1000000 / v1 * 10 < 1000000) {
                        arg1 * 1000000 / v1 * 10
                    } else {
                        1000000
                    };
                    if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg2) % 1000000 < v2 / 2) {
                        return v0
                    };
                };
            };
            v0 = v0 - 1;
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::tier_ba()
    }

    fun sat_sub(arg0: u64, arg1: u64) : u64 {
        arg0 - min_u64(arg0, arg1)
    }

    fun shuffled_stats(arg0: &mut u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count()) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count();
        while (v2 > 1) {
            let v3 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg0) % v2;
            v2 = v2 - 1;
            *0x1::vector::borrow_mut<u64>(&mut v0, v2) = *0x1::vector::borrow<u64>(&v0, v3);
            *0x1::vector::borrow_mut<u64>(&mut v0, v3) = *0x1::vector::borrow<u64>(&v0, v2);
        };
        v0
    }

    public fun stochastic_round(arg0: u64, arg1: u64, arg2: &mut u64) : u64 {
        assert!(arg1 > 0, 2);
        let v0 = arg0 % arg1;
        if (v0 > 0 && 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg2) % arg1 < v0) {
            arg0 / arg1 + 1
        } else {
            arg0 / arg1
        }
    }

    public fun zero_counts() : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count() * 3) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

