module 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::bluefin_agg {
    public fun swap<T0, T1, T2>(arg0: &mut 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = if (arg3) {
            swap_a2b<T1, T2>(arg1, arg2, 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T1>(arg0, arg4), arg5)
        } else {
            swap_b2a<T1, T2>(arg1, arg2, 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T2>(arg0, arg4), arg5)
        };
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T1>(arg0, v3);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
        if (0x2::balance::value<T2>(&v2) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T2>(arg0, v2);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
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

