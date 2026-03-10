module 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::search {
    fun effective_price(arg0: u64, arg1: u64, arg2: bool) : u128 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        if (arg2) {
            (arg0 as u128) * 1000000000000 / (arg1 as u128) + 1
        } else {
            (arg1 as u128) * 1000000000000 / (arg0 as u128)
        }
    }

    public fun find_optimal_bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8) : u64 {
        if (arg3 == 0 || arg3 > arg4) {
            return 0
        };
        let v0 = if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = arg3;
        let v4 = 0;
        while (v4 < arg5) {
            v4 = v4 + 1;
            if (v3 > arg4) {
                v3 = arg4;
            };
            let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, v3, v0);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v5)) {
                break
            };
            let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v5);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v5);
            let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v5) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v5);
            if (v6 == 0 || v7 == 0) {
                break
            };
            if (!price_ok(effective_price(v7, v6, arg1), arg2, arg1)) {
                break
            };
            v1 = v7;
            if (v3 >= arg4) {
                return v7
            };
            v2 = v3;
            v3 = v3 * 2;
        };
        if (v1 == 0) {
            return 0
        };
        v4 = 0;
        while (v4 < arg6) {
            v4 = v4 + 1;
            if (v3 <= v2 + 1) {
                break
            };
            let v8 = (v2 + v3) / 2;
            let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, v8, v0);
            let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v9);
            let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v9) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v9);
            let v12 = if (v10 > 0) {
                if (v11 > 0) {
                    !0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v9)
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                if (price_ok(effective_price(v11, v10, arg1), arg2, arg1)) {
                    v1 = v11;
                    v2 = v8;
                    continue
                };
                v3 = v8;
                continue
            };
            v3 = v8;
        };
        v1
    }

    public fun find_optimal_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8) : u64 {
        if (arg3 == 0 || arg3 > arg4) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = arg3;
        let v3 = 0;
        while (v3 < arg5) {
            v3 = v3 + 1;
            if (v2 > arg4) {
                v2 = arg4;
            };
            let v4 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::simulate_swap<T0, T1>(arg0, arg1, v2);
            if (0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_exceeded(&v4)) {
                break
            };
            let v5 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_total_cost(&v4);
            let v6 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_amount_out(&v4);
            if (v6 == 0 || v5 == 0) {
                break
            };
            if (!price_ok(effective_price(v5, v6, arg1), arg2, arg1)) {
                break
            };
            v0 = v5;
            if (v2 >= arg4) {
                return v5
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 <= v1 + 1) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let v8 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::simulate_swap<T0, T1>(arg0, arg1, v7);
            let v9 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_total_cost(&v8);
            let v10 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_amount_out(&v8);
            let v11 = if (v10 > 0) {
                if (v9 > 0) {
                    !0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus::sim_exceeded(&v8)
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                if (price_ok(effective_price(v9, v10, arg1), arg2, arg1)) {
                    v0 = v9;
                    v1 = v7;
                    continue
                };
                v2 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    public fun find_optimal_momentum<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u8, arg6: u8) : u64 {
        if (arg3 == 0 || arg3 > arg4) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = arg3;
        let v3 = 0;
        while (v3 < arg5) {
            v3 = v3 + 1;
            if (v2 > arg4) {
                v2 = arg4;
            };
            let v4 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::simulate_swap<T0, T1>(arg0, arg1, v2);
            if (0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_exceeded(&v4)) {
                break
            };
            let v5 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_total_cost(&v4);
            let v6 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_amount_out(&v4);
            if (v6 == 0 || v5 == 0) {
                break
            };
            if (!price_ok(effective_price(v5, v6, arg1), arg2, arg1)) {
                break
            };
            v0 = v5;
            if (v2 >= arg4) {
                return v5
            };
            v1 = v2;
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return 0
        };
        v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 <= v1 + 1) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let v8 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::simulate_swap<T0, T1>(arg0, arg1, v7);
            let v9 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_total_cost(&v8);
            let v10 = 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_amount_out(&v8);
            let v11 = if (v10 > 0) {
                if (v9 > 0) {
                    !0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_momentum::sim_exceeded(&v8)
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                if (price_ok(effective_price(v9, v10, arg1), arg2, arg1)) {
                    v0 = v9;
                    v1 = v7;
                    continue
                };
                v2 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    fun price_ok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    public fun sqrt_price_to_price(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    // decompiled from Move bytecode v6
}

