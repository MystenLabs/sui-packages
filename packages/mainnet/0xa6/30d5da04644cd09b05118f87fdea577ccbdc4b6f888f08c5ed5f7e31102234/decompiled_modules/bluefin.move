module 0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::bluefin {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg2), 0, 0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::utils::min_sqrt_price() + 1);
        let v2 = v1;
        0x2::balance::value<T1>(&v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v2, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), false, true, 0x2::coin::value<T1>(&arg2), 0, 0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::utils::max_sqrt_price() - 1);
        let v2 = v0;
        0x2::balance::value<T0>(&v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v2, arg4)
    }

    // decompiled from Move bytecode v6
}

