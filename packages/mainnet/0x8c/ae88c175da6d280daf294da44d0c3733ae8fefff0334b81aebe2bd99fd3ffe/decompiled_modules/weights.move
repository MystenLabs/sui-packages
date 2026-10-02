module 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::weights {
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

    public fun next_leg(arg0: &0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::Params, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<bool>) : LegPlan {
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
        let v3 = targets(0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::target_margin(arg0, arg2), arg6, arg8);
        let v4 = sum_live(arg4, arg8);
        let v5 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        let v6 = 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(v5, 10000, arg2);
        let (v7, v8) = 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::bounds(arg0);
        let v9 = v6 < v7 || v6 > v8;
        let v10 = 0;
        while (v10 < v0) {
            if (*0x1::vector::borrow<bool>(arg8, v10)) {
                let v11 = *0x1::vector::borrow<u64>(arg4, v10);
                let v12 = *0x1::vector::borrow<u64>(&v3, v10);
                let v13 = 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(v12, *0x1::vector::borrow<u64>(arg7, v10), 10000);
                let v14 = v4 == 0 && false || 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::diff(0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(v11, 10000, v4), 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(*0x1::vector::borrow<u64>(arg6, v10), 10000, live_weight(arg6, arg8))) > arg1;
                let v15 = v13 == 0 && *0x1::vector::borrow<u64>(arg5, v10) != 0 || 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::diff(*0x1::vector::borrow<u64>(arg5, v10), v13), 10000, v13) > 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::drift_bps(arg0);
                let v16 = 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::diff(v11, v12) + 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::diff(*0x1::vector::borrow<u64>(arg5, v10), v13);
                let v17 = if (v9) {
                    true
                } else if (v14) {
                    true
                } else {
                    v15
                };
                if (v17 && v16 > 0) {
                    if (v0 == v0) {
                    };
                };
            };
            v10 = v10 + 1;
        };
        if (v0 == v0) {
            return v2
        };
        let v18 = *0x1::vector::borrow<u64>(arg4, v0);
        let v19 = *0x1::vector::borrow<u64>(&v3, v0);
        let v20 = 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(v19, *0x1::vector::borrow<u64>(arg7, v0), 10000);
        let v21 = *0x1::vector::borrow<u64>(arg5, v0);
        let v22 = if (v19 > v18) {
            v19 - v18
        } else {
            0
        };
        let v23 = if (v18 > v19) {
            v18 - v19
        } else {
            0
        };
        let v24 = if (v20 > v21) {
            v20 - v21
        } else {
            0
        };
        let v25 = if (v21 > v20) {
            v21 - v20
        } else {
            0
        };
        LegPlan{
            due             : true,
            leg             : v0,
            margin_in       : v22,
            margin_out      : v23,
            grow_notional   : v24,
            shrink_notional : v25,
        }
    }

    public fun shrink(arg0: &vector<u64>, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            let v3 = if (arg1 >= arg2) {
                v2
            } else if (arg2 == 0) {
                0
            } else {
                0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div_up(v2, arg1, arg2)
            };
            let v4 = if (v3 > v2) {
                v2
            } else {
                v3
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
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

    public fun targets(arg0: u64, arg1: &vector<u64>, arg2: &vector<bool>) : vector<u64> {
        let v0 = live_weight(arg1, arg2);
        assert!(v0 > 0, 1002);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            let v3 = if (*0x1::vector::borrow<bool>(arg2, v2)) {
                0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(arg0, *0x1::vector::borrow<u64>(arg1, v2), v0)
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

