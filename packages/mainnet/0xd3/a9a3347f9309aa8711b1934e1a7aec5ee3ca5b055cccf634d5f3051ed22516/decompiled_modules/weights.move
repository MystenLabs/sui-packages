module 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::weights {
    struct LegPlan has copy, drop {
        due: bool,
        leg: u64,
        margin_in: u64,
        margin_out: u64,
        grow_notional: u64,
        shrink_notional: u64,
    }

    public fun check(arg0: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 >= 1 && v0 <= 4, 1000);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            assert!(v3 >= 1000, 1001);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 1001);
    }

    public fun check_weight_band(arg0: u64) {
        assert!(arg0 > 0 && arg0 < 1000, 1004);
    }

    public fun cut_of(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg2) {
            return arg0
        };
        let v0 = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div_up(arg0, arg1, arg2);
        if (v0 > arg0) {
            arg0
        } else {
            v0
        }
    }

    public fun default_weight_band_bps() : u64 {
        500
    }

    public fun leg_plan_parts(arg0: &LegPlan) : (bool, u64, u64, u64, u64, u64) {
        (arg0.due, arg0.leg, arg0.margin_in, arg0.margin_out, arg0.grow_notional, arg0.shrink_notional)
    }

    public fun live_weight(arg0: &vector<u64>, arg1: &vector<bool>) : u64 {
        assert!(0x1::vector::length<u64>(arg0) == 0x1::vector::length<bool>(arg1), 1003);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<bool>(arg1, v1)) {
                v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun max_legs() : u64 {
        4
    }

    public fun min_weight_bps() : u64 {
        1000
    }

    public fun next_leg(arg0: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::band::Params, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<bool>, arg9: bool) : LegPlan {
        let v0 = 0x1::vector::length<u64>(arg6);
        let v1 = if (0x1::vector::length<u64>(arg4) == v0) {
            if (0x1::vector::length<u64>(arg5) == v0) {
                0x1::vector::length<u64>(arg7) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1003);
        let v2 = LegPlan{
            due             : false,
            leg             : 0,
            margin_in       : 0,
            margin_out      : 0,
            grow_notional   : 0,
            shrink_notional : 0,
        };
        if (arg2 == 0) {
            return v2
        };
        let v3 = targets(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::band::target_margin(arg0, arg2), arg6, arg8);
        let v4 = live_weight(arg6, arg8);
        let v5 = sum_live(arg4, arg8);
        let v6 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        let v7 = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(v6, 10000, arg2);
        let (v8, v9) = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::band::bounds(arg0);
        let v10 = v7 < v8 || v7 > v9;
        let v11 = pick(arg0, arg1, arg3, v10, v5, v4, &v3, arg4, arg5, arg6, arg7, arg8, arg9, true);
        let v12 = v11;
        if (v11 == v0) {
            v12 = pick(arg0, arg1, arg3, v10, v5, v4, &v3, arg4, arg5, arg6, arg7, arg8, arg9, false);
        };
        if (v12 == v0) {
            return v2
        };
        plan_for(v12, *0x1::vector::borrow<u64>(&v3, v12), *0x1::vector::borrow<u64>(arg4, v12), *0x1::vector::borrow<u64>(arg5, v12), *0x1::vector::borrow<u64>(arg7, v12))
    }

    fun pick(arg0: &0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::band::Params, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<bool>, arg12: bool, arg13: bool) : u64 {
        let v0 = 0x1::vector::length<u64>(arg9);
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<bool>(arg11, v1)) {
                let v2 = *0x1::vector::borrow<u64>(arg7, v1);
                let v3 = *0x1::vector::borrow<u64>(arg6, v1);
                let v4 = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(v3, *0x1::vector::borrow<u64>(arg10, v1), 10000);
                let v5 = arg4 == 0 && false || 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::diff(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(v2, 10000, arg4), 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(*0x1::vector::borrow<u64>(arg9, v1), 10000, arg5)) > arg1;
                let v6 = v4 == 0 && *0x1::vector::borrow<u64>(arg8, v1) != 0 || 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::diff(*0x1::vector::borrow<u64>(arg8, v1), v4), 10000, v4) > 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::band::drift_bps(arg0);
                let v7 = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::diff(v2, v3) + 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::diff(*0x1::vector::borrow<u64>(arg8, v1), v4);
                let v8 = v2 > v3 || *0x1::vector::borrow<u64>(arg8, v1) > v4;
                let v9 = if (v3 > v2) {
                    v3 - v2
                } else {
                    0
                };
                let v10 = (!arg12 || v8) && (!arg13 || v9 <= arg2);
                let v11 = if (arg3) {
                    true
                } else if (v5) {
                    true
                } else {
                    v6
                };
                let v12 = if (v11) {
                    if (v7 > 0) {
                        v10
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v12) {
                    if (v0 == v0) {
                    };
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun plan_for(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : LegPlan {
        let v0 = 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(arg1, arg4, 10000);
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        };
        let v2 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            0
        };
        let v3 = if (v0 > arg3) {
            v0 - arg3
        } else {
            0
        };
        let v4 = if (arg3 > v0) {
            arg3 - v0
        } else {
            0
        };
        LegPlan{
            due             : true,
            leg             : arg0,
            margin_in       : v1,
            margin_out      : v2,
            grow_notional   : v3,
            shrink_notional : v4,
        }
    }

    public fun shrink(arg0: &vector<u64>, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, cut_of(*0x1::vector::borrow<u64>(arg0, v1), arg1, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    fun sum_live(arg0: &vector<u64>, arg1: &vector<bool>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<bool>(arg1, v1)) {
                v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun target_of(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(arg0, arg1, arg2)
    }

    public fun targets(arg0: u64, arg1: &vector<u64>, arg2: &vector<bool>) : vector<u64> {
        let v0 = live_weight(arg1, arg2);
        assert!(v0 > 0, 1002);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            let v3 = if (*0x1::vector::borrow<bool>(arg2, v2)) {
                target_of(arg0, *0x1::vector::borrow<u64>(arg1, v2), v0)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v3);
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

