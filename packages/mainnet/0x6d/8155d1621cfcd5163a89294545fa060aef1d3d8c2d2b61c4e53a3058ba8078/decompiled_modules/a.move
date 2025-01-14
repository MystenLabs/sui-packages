module 0x6d8155d1621cfcd5163a89294545fa060aef1d3d8c2d2b61c4e53a3058ba8078::a {
    public fun xk<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), true, true, v0, 1, arg3);
        let v3 = v1;
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v3, arg5), arg5);
        };
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun yk<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), false, true, v0, 1, arg3);
        let v3 = v2;
        if (0x2::balance::value<T1>(&v3) == 0) {
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v3, arg5), arg5);
        };
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

