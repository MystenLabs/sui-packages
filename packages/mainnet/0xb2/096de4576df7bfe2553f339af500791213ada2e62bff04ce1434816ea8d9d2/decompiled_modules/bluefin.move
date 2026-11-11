module 0xb2096de4576df7bfe2553f339af500791213ada2e62bff04ce1434816ea8d9d2::bluefin {
    public fun swap<T0, T1>(arg0: &mut 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, true, v1, 0, 4295048017);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        if (arg3 == 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::max_amount_in()) {
            0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::transfer_balance<T0>(v5, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::merge_balance<T0>(arg0, v5);
        };
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::merge_balance<T1>(arg0, v4);
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::emit_swap_event<T0, T1>(arg0, b"BLUEFIN", 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), v1 - v6, 0x2::balance::value<T1>(&v4), v6);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::balance::zero<T0>(), v0, false, true, v1, 0, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T1>(&v4);
        if (arg3 == 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::max_amount_in()) {
            0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::transfer_balance<T1>(v4, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::merge_balance<T1>(arg0, v4);
        };
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::merge_balance<T0>(arg0, v5);
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router::emit_swap_event<T1, T0>(arg0, b"BLUEFIN", 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), v1 - v6, 0x2::balance::value<T0>(&v5), v6);
    }

    // decompiled from Move bytecode v7
}

