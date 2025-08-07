module 0x684b54380e6a68a3414ad9ad696f866e57501947db1451748eb3117919592c2::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&v1), 0, arg3);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::utils::refund_if_necessary<T0>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v3, arg5));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T1, T0>(v0);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v1), false, true, 0x2::coin::value<T1>(&v1), 0, arg3);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::utils::refund_if_necessary<T1>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T1, T0>(v0, 0x2::coin::from_balance<T0>(v2, arg5));
    }

    // decompiled from Move bytecode v6
}

