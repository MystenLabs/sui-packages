module 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds {
    struct FloorLine has copy, drop {
        whole: u128,
        slope: u128,
        remainder: u128,
        modulus: u128,
    }

    struct FloorSearchFrame has drop {
        inverse: FloorLine,
        fallback: 0x1::option::Option<u64>,
        max_offset: u64,
    }

    fun count_residues(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        floor_sum(arg0, arg1, arg2, arg1 - arg3) - floor_sum(arg0, arg1, arg2, arg1 - 1 - arg4)
    }

    public(friend) fun floor_line(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : FloorLine {
        assert!(arg3 > 0 && arg2 < arg3, 2);
        FloorLine{
            whole     : arg0,
            slope     : arg1,
            remainder : arg2,
            modulus   : arg3,
        }
    }

    fun floor_sum(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0;
        while (arg0 > 0) {
            if (arg2 >= arg1) {
                v0 = v0 + arg0 * (arg0 - 1) / 2 * arg2 / arg1;
                arg2 = arg2 % arg1;
            };
            if (arg3 >= arg1) {
                v0 = v0 + arg0 * arg3 / arg1;
                arg3 = arg3 % arg1;
            };
            let v1 = arg2 * arg0 + arg3;
            if (v1 < arg1) {
                break
            };
            arg0 = v1 / arg1;
            arg3 = v1 % arg1;
            let v2 = arg1;
            arg1 = arg2;
            arg2 = v2;
        };
        v0
    }

    fun gap_at_least(arg0: FloorLine, arg1: FloorLine, arg2: u64, arg3: u256) : bool {
        let (v0, v1) = line_parts(arg0, arg2);
        let (v2, v3) = line_parts(arg1, arg2);
        if (v0 != v2 + arg3) {
            return v0 > v2 + arg3
        };
        v1 * (arg1.modulus as u256) >= v3 * (arg0.modulus as u256)
    }

    public(friend) fun last_canonical_mint(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : 0x1::option::Option<u64> {
        assert!(arg2 > 0, 1);
        last_residue_in_range(0x1::u64::max(arg0, 1), arg1, arg2, 18446744073709551616, arg3, 0x1::u128::min(arg4, arg2 - 1))
    }

    public(friend) fun last_floor_leq(arg0: u64, arg1: u64, arg2: FloorLine, arg3: FloorLine) : 0x1::option::Option<u64> {
        last_floor_leq_with_work_limit(arg0, arg1, arg2, arg3, 32)
    }

    fun last_floor_leq_counted(arg0: u64, arg1: u64, arg2: FloorLine, arg3: FloorLine) : 0x1::option::Option<u64> {
        if (arg0 > arg1) {
            return 0x1::option::none<u64>()
        };
        if (line_floor(arg2, arg1 - arg0) <= line_floor(arg3, arg1 - arg0)) {
            return 0x1::option::some<u64>(arg1)
        };
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 0x1::option::none<u64>();
        if ((arg2.slope as u256) * (arg3.modulus as u256) > (arg3.slope as u256) * (arg2.modulus as u256)) {
            if (gap_at_least(arg2, arg3, 0, 1)) {
                return 0x1::option::none<u64>()
            };
            if (gap_at_least(arg2, arg3, arg1 - arg0, 1)) {
                let v3 = arg0;
                while (v3 < arg1) {
                    let v4 = arg1 - v3;
                    let v5 = v3 + v4 / 2 + v4 % 2;
                    if (gap_at_least(arg2, arg3, v5 - arg0, 1)) {
                        arg1 = v5 - 1;
                        continue
                    };
                    v3 = v5;
                };
                v1 = v3;
            };
            if (line_floor(arg2, v1 - arg0) <= line_floor(arg3, v1 - arg0)) {
                return 0x1::option::some<u64>(v1)
            };
            if (!gap_at_least(arg2, arg3, 0, 0)) {
                let v6 = arg0;
                let v7 = v1;
                while (v6 < v7) {
                    v7 = v6 + (v7 - v6) / 2;
                    if (gap_at_least(arg2, arg3, v7 - arg0, 0)) {
                        continue
                    };
                    v6 = v7 + 1;
                };
                v0 = v6;
                v2 = 0x1::option::some<u64>(v6 - 1);
            };
        } else {
            if (gap_at_least(arg2, arg3, arg1 - arg0, 1)) {
                return 0x1::option::none<u64>()
            };
            if (gap_at_least(arg2, arg3, 0, 1)) {
                let v8 = arg0;
                let v9 = arg1;
                while (v8 < v9) {
                    v9 = v8 + (v9 - v8) / 2;
                    if (gap_at_least(arg2, arg3, v9 - arg0, 1)) {
                        v8 = v9 + 1;
                        continue
                    };
                };
                v0 = v8;
            };
        };
        let v10 = line_matches(arg2, arg3, v0 - arg0, ((v1 - v0) as u256) + 1);
        if (v10 == 0) {
            return v2
        };
        while (v0 < v1) {
            let v11 = v1 - v0;
            let v12 = v0 + v11 / 2 + v11 % 2;
            if (v10 > line_matches(arg2, arg3, v0 - arg0, ((v12 - v0) as u256))) {
                v0 = v12;
                continue
            };
            v1 = v12 - 1;
        };
        0x1::option::some<u64>(v0)
    }

    fun last_floor_leq_with_work_limit(arg0: u64, arg1: u64, arg2: FloorLine, arg3: FloorLine, arg4: u64) : 0x1::option::Option<u64> {
        if (arg0 > arg1) {
            return 0x1::option::none<u64>()
        };
        let (v0, v1) = try_last_floor_euclidean(arg1 - arg0, arg2, arg3, arg4);
        let v2 = v1;
        if (!v0) {
            return last_floor_leq_counted(arg0, arg1, arg2, arg3)
        };
        if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::some<u64>(arg0 + 0x1::option::destroy_some<u64>(v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun last_residue_in_range(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : 0x1::option::Option<u64> {
        assert!(arg3 > 0, 0);
        let v0 = if (arg0 > arg1) {
            true
        } else if (arg4 > arg5) {
            true
        } else {
            arg4 >= arg3
        };
        if (v0) {
            return 0x1::option::none<u64>()
        };
        let v1 = ((arg2 % arg3) as u256);
        let v2 = (arg3 as u256);
        let v3 = (arg4 as u256);
        let v4 = (0x1::u128::min(arg5, arg3 - 1) as u256);
        let v5 = (arg1 as u256) * v1 % v2;
        if (v3 <= v5 && v5 <= v4) {
            return 0x1::option::some<u64>(arg1)
        };
        if (v1 == 0 || arg0 == arg1) {
            return 0x1::option::none<u64>()
        };
        let v6 = count_residues((arg1 as u256) + 1, v2, v1, v3, v4);
        if (v6 == count_residues((arg0 as u256), v2, v1, v3, v4)) {
            return 0x1::option::none<u64>()
        };
        let v7 = arg0;
        while (v7 < arg1) {
            let v8 = arg1 - v7;
            let v9 = v7 + v8 / 2 + v8 % 2;
            if (v6 > count_residues((v9 as u256), v2, v1, v3, v4)) {
                v7 = v9;
                continue
            };
            arg1 = v9 - 1;
        };
        0x1::option::some<u64>(v7)
    }

    fun line_floor(arg0: FloorLine, arg1: u64) : u256 {
        let (v0, _) = line_parts(arg0, arg1);
        v0
    }

    fun line_matches(arg0: FloorLine, arg1: FloorLine, arg2: u64, arg3: u256) : u256 {
        arg3 - line_sum(arg0, arg2, arg3) - line_sum(arg1, arg2, arg3)
    }

    fun line_parts(arg0: FloorLine, arg1: u64) : (u256, u256) {
        let v0 = (arg0.slope as u256) * (arg1 as u256) + (arg0.remainder as u256);
        ((arg0.whole as u256) + v0 / (arg0.modulus as u256), v0 % (arg0.modulus as u256))
    }

    fun line_sum(arg0: FloorLine, arg1: u64, arg2: u256) : u256 {
        let (v0, v1) = line_parts(arg0, arg1);
        v0 * arg2 + floor_sum(arg2, (arg0.modulus as u256), (arg0.slope as u256), v1)
    }

    fun try_last_floor_euclidean(arg0: u64, arg1: FloorLine, arg2: FloorLine, arg3: u64) : (bool, 0x1::option::Option<u64>) {
        let v0 = 0x1::vector::empty<FloorSearchFrame>();
        let v1 = 0x1::option::none<u64>();
        let v2 = 0;
        loop {
            if (v2 >= arg3) {
                return (false, 0x1::option::none<u64>())
            };
            v2 = v2 + 1;
            let v3 = line_floor(arg1, arg0);
            let v4 = line_floor(arg2, arg0);
            if (v3 <= v4) {
                v1 = 0x1::option::some<u64>(arg0);
                break
            };
            if (arg0 == 0) {
                break
            };
            let v5 = arg1.slope / arg1.modulus;
            let v6 = arg2.slope / arg2.modulus;
            if (v5 < v6) {
                break
            };
            if (v5 > v6) {
                if (arg1.whole > arg2.whole) {
                    break
                } else {
                    let v7 = 0;
                    let v8 = arg0 - 1;
                    while (v7 < v8) {
                        let v9 = v8 - v7;
                        let v10 = v7 + v9 / 2 + v9 % 2;
                        if (line_floor(arg1, v10) <= line_floor(arg2, v10)) {
                            v7 = v10;
                            continue
                        };
                        v8 = v10 - 1;
                    };
                    v1 = 0x1::option::some<u64>(v7);
                    break
                };
            };
            arg1.slope = arg1.slope % arg1.modulus;
            arg2.slope = arg2.slope % arg2.modulus;
            if (arg1.slope == 0) {
                break
            };
            let v11 = (v5 as u256) * (arg0 as u256);
            let v12 = v3 - v11;
            let v13 = 0x1::option::none<u64>();
            if (arg1.whole <= arg2.whole) {
                let v14 = ((0x1::u256::min(v12 - 1, (arg2.whole as u256)) + 1 - (arg1.whole as u256)) * (arg1.modulus as u256) - (arg1.remainder as u256) - 1) / (arg1.slope as u256);
                if (v14 >= (arg0 as u256)) {
                    return (false, 0x1::option::none<u64>())
                };
                v13 = 0x1::option::some<u64>((v14 as u64));
            };
            let v15 = 0x1::u256::max((arg1.whole as u256), (arg2.whole as u256) + 1);
            let v16 = 0x1::u256::min(v12 - 1, v4 - v11);
            if (v15 > v16) {
                v1 = v13;
                break
            };
            if (arg2.slope == 0) {
                return (false, 0x1::option::none<u64>())
            };
            let v17 = v15 - (arg2.whole as u256);
            let v18 = v15 + 1 - (arg1.whole as u256);
            if (v17 > (arg0 as u256) || v18 > (arg0 as u256)) {
                return (false, 0x1::option::none<u64>())
            };
            let v19 = v17 * (arg2.modulus as u256) - (arg2.remainder as u256) + (arg2.slope as u256) - 1;
            let v20 = v18 * (arg1.modulus as u256) - (arg1.remainder as u256) - 1;
            let v21 = v19 / (arg2.slope as u256);
            let v22 = v20 / (arg1.slope as u256);
            let v23 = if (v21 > (arg0 as u256)) {
                true
            } else if (v22 >= (arg0 as u256)) {
                true
            } else {
                v16 - v15 >= (arg0 as u256)
            };
            if (v23) {
                return (false, 0x1::option::none<u64>())
            };
            arg1 = FloorLine{whole: (v21 as u128), slope: arg2.modulus, remainder: ((v19 % (arg2.slope as u256)) as u128), modulus: arg2.slope};
            arg2 = FloorLine{whole: (v22 as u128), slope: arg1.modulus, remainder: ((v20 % (arg1.slope as u256)) as u128), modulus: arg1.slope};
            let v24 = FloorSearchFrame{
                inverse    : arg2,
                fallback   : v13,
                max_offset : arg0,
            };
            0x1::vector::push_back<FloorSearchFrame>(&mut v0, v24);
            arg0 = ((v16 - v15) as u64);
        };
        while (!0x1::vector::is_empty<FloorSearchFrame>(&v0)) {
            let FloorSearchFrame {
                inverse    : v25,
                fallback   : v26,
                max_offset : v27,
            } = 0x1::vector::pop_back<FloorSearchFrame>(&mut v0);
            let v28 = if (0x1::option::is_some<u64>(&v1)) {
                let v29 = line_floor(v25, 0x1::option::destroy_some<u64>(v1));
                if (v29 >= (v27 as u256)) {
                    return (false, 0x1::option::none<u64>())
                };
                0x1::option::some<u64>((v29 as u64))
            } else {
                v26
            };
            v1 = v28;
        };
        (true, v1)
    }

    // decompiled from Move bytecode v7
}

