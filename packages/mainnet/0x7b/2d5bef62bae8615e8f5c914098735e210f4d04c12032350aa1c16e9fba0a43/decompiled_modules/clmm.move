module 0x7b2d5bef62bae8615e8f5c914098735e210f4d04c12032350aa1c16e9fba0a43::clmm {
    public fun swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::route_swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::coin::zero<T1>(arg4), true, true, true, 0x2::coin::value<T0>(&arg2), 0, 4295048016 + 1, arg4);
        let v2 = v0;
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::coin::send_funds<T0>(v2, 0x2::tx_context::sender(arg4));
        };
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::route_swap<T0, T1>(arg3, arg0, arg1, 0x2::coin::zero<T0>(arg4), arg2, false, true, true, 0x2::coin::value<T1>(&arg2), 0, 79226673515401279992447579055 - 1, arg4);
        let v2 = v1;
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::coin::send_funds<T1>(v2, 0x2::tx_context::sender(arg4));
        };
        v0
    }

    // decompiled from Move bytecode v7
}

