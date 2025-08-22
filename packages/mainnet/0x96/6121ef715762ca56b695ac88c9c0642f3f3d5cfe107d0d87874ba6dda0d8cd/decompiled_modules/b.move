module 0x966121ef715762ca56b695ac88c9c0642f3f3d5cfe107d0d87874ba6dda0d8cd::b {
    public fun sxy<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg2), 0, arg3);
        0x966121ef715762ca56b695ac88c9c0642f3f3d5cfe107d0d87874ba6dda0d8cd::u::tod<T0>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun syx<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), false, true, 0x2::coin::value<T1>(&arg2), 0, arg3);
        0x966121ef715762ca56b695ac88c9c0642f3f3d5cfe107d0d87874ba6dda0d8cd::u::tod<T1>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

