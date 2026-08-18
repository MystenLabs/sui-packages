module 0x5eab7eec780533f58892b637d8407b31bd04c31bc9e1cbdd796ca8644a082fb5::q0 {
    struct T has copy, drop {
        r: u8,
        s: u8,
        ai: u64,
        ao: u64,
        f: u64,
        fx: bool,
        l: u128,
        c: bool,
    }

    struct S has copy, drop {
        t: T,
        e: u64,
    }

    public fun bnd(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        (((v0 * (10000 - v1) / 10000) as u64), (((v0 * (10000 + v1) + 9999) / 10000) as u64))
    }

    public fun cc(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            true
        } else if (arg2 <= arg1) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            arg5 > 10000
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg0 >= arg2) {
            10000
        } else {
            (((arg5 as u128) + ((10000 - arg5) as u128) * ((arg0 - arg1) as u128) / ((arg2 - arg1) as u128)) as u64)
        };
        (((arg3 as u128) * (v1 as u128) / 10000) as u64) / arg4 * arg4
    }

    public fun df<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : u64 {
        fa(fr<T0, T1>(arg0), arg1)
    }

    public fun eco_in(arg0: &T) : u64 {
        if (arg0.fx) {
            arg0.ai + arg0.f
        } else {
            arg0.ai
        }
    }

    fun eco_out(arg0: &T) : (bool, u64) {
        if (arg0.fx) {
            if (arg0.ao <= arg0.f) {
                (false, 0)
            } else {
                (true, arg0.ao - arg0.f)
            }
        } else {
            (true, arg0.ao)
        }
    }

    public fun ed(arg0: &T, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        if (!arg0.c || arg0.r == 0) {
            return (false, 0)
        };
        if (arg0.s == 1) {
            let v2 = eco_in(arg0);
            if (arg2 == 0 || v2 >= arg2) {
                return (false, 0)
            };
            (true, arg2 - v2)
        } else if (arg0.s == 2) {
            let (v3, v4) = eco_out(arg0);
            let v5 = if (!v3) {
                true
            } else if (arg3 == 0) {
                true
            } else {
                arg1 == 0
            };
            if (v5) {
                return (false, 0)
            };
            let v6 = req(arg3, arg1, arg0.ai);
            if (v4 <= v6) {
                return (false, 0)
            };
            (true, v4 - v6)
        } else {
            (false, 0)
        }
    }

    public fun fa(arg0: u64, arg1: u64) : u64 {
        ((((arg1 as u128) * (arg0 as u128) + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128) - 1) / (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128)) as u64)
    }

    public fun fee2(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun fr<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        (((v0 as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier() as u128) / (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128)) as u64)
    }

    public fun fv(arg0: u64, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            ((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000
        } else {
            (arg0 as u128) * (arg1 as u128) / 1000000000
        };
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun iv(arg0: &T, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = if (arg0.s == 1) {
            arg1 + arg0.ao
        } else {
            if (arg1 < arg0.ai) {
                return false
            };
            arg1 - arg0.ai
        };
        let v1 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        v0 >= v1 && v0 <= arg2 + arg3
    }

    public fun mk_s(arg0: T, arg1: u64) : S {
        S{
            t : arg0,
            e : arg1,
        }
    }

    public fun none() : S {
        let v0 = T{
            r  : 0,
            s  : 0,
            ai : 0,
            ao : 0,
            f  : 0,
            fx : false,
            l  : 0,
            c  : false,
        };
        S{
            t : v0,
            e : 0,
        }
    }

    public fun none_t() : T {
        T{
            r  : 0,
            s  : 0,
            ai : 0,
            ao : 0,
            f  : 0,
            fx : false,
            l  : 0,
            c  : false,
        }
    }

    public fun qb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u8, arg2: u8, arg3: u64, arg4: u128) : T {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg2 == 2, arg2 == 2, arg3, arg4);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0 && !0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0);
        if (arg2 == 1) {
            T{r: arg1, s: arg2, ai: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), ao: arg3, f: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), fx: true, l: arg4, c: v1}
        } else {
            T{r: arg1, s: arg2, ai: arg3, ao: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), f: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), fx: false, l: arg4, c: v1}
        }
    }

    public fun qc<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: u8, arg2: u8, arg3: u64, arg4: u128) : T {
        if (arg2 == 1) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, true, false, arg3);
            let v2 = !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) == arg3;
            T{r: arg1, s: arg2, ai: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v1), ao: arg3, f: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1), fx: true, l: arg4, c: v2}
        } else {
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, false, true, arg3);
            let v4 = !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v3) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v3) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v3) == arg3;
            T{r: arg1, s: arg2, ai: arg3, ao: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3), f: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v3), fx: false, l: arg4, c: v4}
        }
    }

    public fun qd<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) : T {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg3);
        let v3 = v0 == 0 && v1 > 0;
        let v4 = arg2 - v0;
        let v5 = df<T0, T1>(arg0, v4);
        T{
            r  : arg1,
            s  : 2,
            ai : v4 + v5,
            ao : v1,
            f  : v5,
            fx : false,
            l  : 0,
            c  : v3,
        }
    }

    public fun qd_buy<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : T {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg4);
        if (v0 < arg3 || arg3 == 0) {
            return T{
                r  : arg1,
                s  : 1,
                ai : 0,
                ao : 0,
                f  : 0,
                fx : true,
                l  : 0,
                c  : false,
            }
        };
        let v3 = (((((arg2 - v1) as u128) * (arg3 as u128) + (v0 as u128) - 1) / (v0 as u128)) as u64);
        T{
            r  : arg1,
            s  : 1,
            ai : v3,
            ao : arg3,
            f  : df<T0, T1>(arg0, v3),
            fx : true,
            l  : 0,
            c  : true,
        }
    }

    public fun qm<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u8, arg2: u8, arg3: u64, arg4: u128) : T {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg2 == 2, arg2 == 2, arg4, arg3);
        if (arg2 == 1) {
            T{r: arg1, s: arg2, ai: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), ao: arg3, f: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), fx: true, l: arg4, c: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) == 0}
        } else {
            T{r: arg1, s: arg2, ai: arg3, ao: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), f: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), fx: false, l: arg4, c: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) == 0}
        }
    }

    fun req(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg2 as u128) + (arg1 as u128) - 1) / (arg1 as u128)) as u64)
    }

    public fun se(arg0: &S) : u64 {
        arg0.e
    }

    public fun sel(arg0: vector<T>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : S {
        let v0 = none();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T>(&arg0)) {
            let v2 = *0x1::vector::borrow<T>(&arg0, v1);
            if (v2.s & arg1 != 0 && iv(&v2, arg5, arg6, arg7)) {
                let (v3, v4) = ed(&v2, arg2, arg3, arg4);
                if (v3 && v4 > v0.e) {
                    v0 = S{t: v2, e: v4};
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun side_buy() : u8 {
        1
    }

    public fun side_sell() : u8 {
        2
    }

    public fun sr(arg0: &S) : u8 {
        arg0.t.r
    }

    public fun st(arg0: &S) : &T {
        &arg0.t
    }

    public fun tai(arg0: &T) : u64 {
        arg0.ai
    }

    public fun tao(arg0: &T) : u64 {
        arg0.ao
    }

    public fun tc_(arg0: &T) : bool {
        arg0.c
    }

    public fun tf(arg0: &T) : u64 {
        arg0.f
    }

    public fun tl(arg0: &T) : u128 {
        arg0.l
    }

    public fun ts_(arg0: &T) : u8 {
        arg0.s
    }

    // decompiled from Move bytecode v7
}

