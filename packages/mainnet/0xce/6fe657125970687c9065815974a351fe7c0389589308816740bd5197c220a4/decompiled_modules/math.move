module 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math {
    public(friend) fun abs_diff_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public(friend) fun adjust(arg0: u256, arg1: u8, arg2: u8) : u256 {
        mul3(arg0, arg0, arg0, arg1, arg2)
    }

    public fun check_imbalance_ratios(arg0: &0x2::vec_map::VecMap<u8, u256>, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>, arg3: u8, arg4: u8, arg5: u256, arg6: u256, arg7: u256, arg8: &0x2::vec_map::VecMap<u8, u256>, arg9: u256, arg10: &0x2::vec_map::VecMap<u8, u256>, arg11: u8, arg12: u8, arg13: u256, arg14: u256) : bool {
        let v0 = 0x2::vec_map::empty<u8, u256>();
        let v1 = 0x2::vec_map::empty<u8, u256>();
        let v2 = 0;
        while (v2 < (0x2::vec_map::size<u8, u256>(arg0) as u8)) {
            let v3 = *0x2::vec_map::get<u8, u256>(arg0, &v2);
            0x2::vec_map::insert<u8, u256>(&mut v0, v2, v3);
            0x2::vec_map::insert<u8, u256>(&mut v1, v2, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg3);
        *v4 = *v4 + arg5 - arg7;
        let v5 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg4);
        *v5 = *v5 - arg6;
        let v6 = imbalance_ratios(&v1, arg1, arg2, arg8, arg9, arg10, arg11, arg12);
        arg13 - arg14 <= *0x2::vec_map::get<u8, u256>(&v6, &arg4) && *0x2::vec_map::get<u8, u256>(&v6, &arg3) <= arg13 + arg14
    }

    public(friend) fun clamp(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            return arg1
        };
        arg0
    }

    public(friend) fun compute_B_and_L(arg0: &0x2::vec_map::VecMap<u8, u256>, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>, arg3: &0x2::vec_map::VecMap<u8, u256>, arg4: u256, arg5: &0x2::vec_map::VecMap<u8, u256>, arg6: u8, arg7: u8) : (u256, u256) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < (0x2::vec_map::size<u8, u256>(arg0) as u8)) {
            let v3 = *0x2::vec_map::get<u8, u256>(arg2, &v2) * *0x2::vec_map::get<u8, u256>(arg5, &v2);
            v0 = v0 + mul(v3, *0x2::vec_map::get<u8, u256>(arg0, &v2) * *0x2::vec_map::get<u8, u256>(arg3, &v2), arg6, arg7);
            v1 = v1 + mul(v3, *0x2::vec_map::get<u8, u256>(arg1, &v2) * arg4, arg6, arg7);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun compute_volatility_fee(arg0: u256, arg1: u64, arg2: u256, arg3: u64, arg4: u256, arg5: u64, arg6: u8, arg7: u8, arg8: u256, arg9: u256, arg10: u256, arg11: u64) : u256 {
        if (arg3 - arg1 > arg11) {
            0
        } else {
            if (arg0 == 0) {
                return 0
            };
            let v1 = if (arg2 >= arg0) {
                (arg2 - arg0) * arg8 / arg0
            } else {
                (arg0 - arg2) * arg8 / arg0
            };
            let v2 = if (v1 > mul3(2 * arg8, mul3(arg8 - arg9, arg8 - arg9, arg8 - arg9, arg6, arg7), arg10, arg6, arg7)) {
                v1
            } else {
                0
            };
            if (arg3 - arg5 > arg11) {
                v2
            } else if (v2 >= arg4) {
                v2
            } else {
                arg4
            }
        }
    }

    public(friend) fun div(arg0: u256, arg1: u256, arg2: u8, arg3: u8) : u256 {
        let v0 = pow(10, arg3);
        assert!(arg0 <= v0, 1);
        let v1 = arg0 * pow(10, arg2) / arg1;
        assert!(v1 <= v0, 2);
        v1
    }

    public fun imbalance_ratios(arg0: &0x2::vec_map::VecMap<u8, u256>, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>, arg3: &0x2::vec_map::VecMap<u8, u256>, arg4: u256, arg5: &0x2::vec_map::VecMap<u8, u256>, arg6: u8, arg7: u8) : 0x2::vec_map::VecMap<u8, u256> {
        let (v0, v1) = compute_B_and_L(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::vec_map::empty<u8, u256>();
        let v3 = 0;
        while (v3 < (0x2::vec_map::size<u8, u256>(arg0) as u8)) {
            if (*0x2::vec_map::get<u8, u256>(arg1, &v3) != 0) {
                0x2::vec_map::insert<u8, u256>(&mut v2, v3, div(mul(*0x2::vec_map::get<u8, u256>(arg0, &v3) * *0x2::vec_map::get<u8, u256>(arg3, &v3), v1, arg6, arg7), mul(v0, *0x2::vec_map::get<u8, u256>(arg1, &v3) * arg4, arg6, arg7), arg6, arg7));
            } else {
                0x2::vec_map::insert<u8, u256>(&mut v2, v3, 0);
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun mul(arg0: u256, arg1: u256, arg2: u8, arg3: u8) : u256 {
        let v0 = pow(10, arg3);
        assert!(arg0 <= v0 && arg1 <= v0, 0);
        let v1 = arg0 * arg1 / pow(10, arg2);
        assert!(v1 <= v0, 0);
        v1
    }

    public fun mul3(arg0: u256, arg1: u256, arg2: u256, arg3: u8, arg4: u8) : u256 {
        mul(arg0, mul(arg1, arg2, arg3, arg4), arg3, arg4)
    }

    public fun pow(arg0: u256, arg1: u8) : u256 {
        let v0 = 1;
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                arg0 = arg0 * arg0;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * arg0;
            arg1 = arg1 - 1;
        };
        v0
    }

    public(friend) fun pow_d(arg0: u256, arg1: u256, arg2: u256, arg3: u8, arg4: u8) : u256 {
        let v0 = pow(10, arg3 - 2);
        assert!(67 * v0 <= arg0 && arg0 <= 150 * v0, 5);
        assert!(arg1 < arg2, 6);
        let v1 = arg2;
        let v2 = 0;
        let v3 = arg2;
        let v4 = true;
        while (v2 < 30) {
            let v5 = if (arg1 >= v2 * arg2) {
                arg1 - v2 * arg2
            } else {
                v4 = !v4;
                v2 * arg2 - arg1
            };
            let v6 = if (arg0 >= arg2) {
                arg0 - arg2
            } else {
                v4 = !v4;
                arg2 - arg0
            };
            v3 = div(mul3(v3, v5, v6, arg3, arg4), v2 * arg2 + arg2, arg3, arg4);
            if (v3 == 0) {
                return v1
            };
            if (v4) {
                v1 = v1 + v3;
            } else {
                v1 = v1 - v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun pow_n(arg0: u256, arg1: u256, arg2: u256, arg3: u8, arg4: u8) : u256 {
        assert!(arg1 <= 127, 3);
        assert!(arg0 <= pow(10, arg4), 4);
        let v0 = arg2;
        while (arg1 != 0) {
            if (arg1 % 2 == 1) {
                v0 = mul(v0, arg0, arg3, arg4);
            };
            arg0 = mul(arg0, arg0, arg3, arg4);
            arg1 = arg1 / 2;
            if (arg1 == 0) {
                break
            };
        };
        v0
    }

    public(friend) fun power(arg0: u256, arg1: u256, arg2: u256, arg3: u8, arg4: u8) : u256 {
        let v0 = arg1 / pow(10, arg3);
        mul(pow_n(arg0, v0, arg2, arg3, arg4), pow_d(arg0, arg1 - v0 * arg2, arg2, arg3, arg4), arg3, arg4)
    }

    public fun scaled_fee_and_leverage(arg0: &0x2::vec_map::VecMap<u8, u256>, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>, arg3: u8, arg4: u8, arg5: &0x2::vec_map::VecMap<u8, u256>, arg6: u256, arg7: &0x2::vec_map::VecMap<u8, u256>, arg8: u256, arg9: u256, arg10: u8, arg11: u8) : (u256, u256) {
        let v0 = imbalance_ratios(arg0, arg1, arg2, arg5, arg6, arg7, arg10, arg11);
        let v1 = adjust(*0x2::vec_map::get<u8, u256>(&v0, &arg3), arg10, arg11);
        let v2 = adjust(*0x2::vec_map::get<u8, u256>(&v0, &arg4), arg10, arg11);
        (div(mul(v1, arg8, arg10, arg11), v2, arg10, arg11), div(mul(v2, arg9, arg10, arg11), v1, arg10, arg11))
    }

    public fun update_volatility_data(arg0: u256, arg1: u64, arg2: u256, arg3: u64, arg4: &mut u256, arg5: &mut u64, arg6: u256, arg7: u256, arg8: u64) {
        let v0 = if (arg0 == 0) {
            0
        } else if (arg2 >= arg0) {
            (arg2 - arg0) * arg7 / arg0
        } else {
            (arg0 - arg2) * arg7 / arg0
        };
        if (arg3 - arg1 <= arg8) {
            if (arg3 - *arg5 > arg8) {
                *arg4 = arg6;
                *arg5 = arg3;
            } else if (*arg4 <= v0) {
                *arg4 = arg6;
                *arg5 = arg3;
            };
        };
    }

    public fun weights(arg0: &0x2::vec_map::VecMap<u8, u256>, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>, arg3: &0x2::vec_map::VecMap<u8, u256>, arg4: u8, arg5: u8) : 0x2::vec_map::VecMap<u8, u256> {
        let v0 = 0x2::vec_map::empty<u8, u256>();
        let v1 = 0;
        let v2 = 0;
        let v3 = (0x2::vec_map::size<u8, u256>(arg0) as u8);
        while (v2 < v3) {
            0x2::vec_map::insert<u8, u256>(&mut v0, v2, 0);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x2::vec_map::get_mut<u8, u256>(&mut v0, &v4);
            *v5 = mul(*0x2::vec_map::get<u8, u256>(arg1, &v4) * *0x2::vec_map::get<u8, u256>(arg3, &v4), *0x2::vec_map::get<u8, u256>(arg0, &v4) * *0x2::vec_map::get<u8, u256>(arg2, &v4), arg4, arg5);
            v1 = v1 + *v5;
            v4 = v4 + 1;
        };
        let v6 = 0;
        while (v6 < v3) {
            let v7 = 0x2::vec_map::get_mut<u8, u256>(&mut v0, &v6);
            *v7 = div(*v7, v1, arg4, arg5);
            v6 = v6 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

