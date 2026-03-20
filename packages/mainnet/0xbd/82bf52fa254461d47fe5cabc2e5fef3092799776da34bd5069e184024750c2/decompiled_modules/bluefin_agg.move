module 0xbd82bf52fa254461d47fe5cabc2e5fef3092799776da34bd5069e184024750c2::bluefin_agg {
    struct BluefinAgg has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::router::Router, arg1: &mut 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::SwapContext, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) {
        let (v0, v1) = if (arg4) {
            let v2 = BluefinAgg{dummy_field: false};
            swap_a2b<T0, T1>(arg2, arg3, 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::take_balance<BluefinAgg, T0>(arg1, arg0, v2, arg5), arg6)
        } else {
            let v3 = BluefinAgg{dummy_field: false};
            swap_b2a<T0, T1>(arg2, arg3, 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::take_balance<BluefinAgg, T1>(arg1, arg0, v3, arg5), arg6)
        };
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::put_balance<T0>(arg1, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::put_balance<T1>(arg1, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, v0, 0, 4295048017)
    }

    fun swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, v0, 0, 79226673515401279992447579054)
    }

    // decompiled from Move bytecode v6
}

