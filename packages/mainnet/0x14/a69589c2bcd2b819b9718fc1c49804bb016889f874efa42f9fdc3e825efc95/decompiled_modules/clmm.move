module 0x14a69589c2bcd2b819b9718fc1c49804bb016889f874efa42f9fdc3e825efc95::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, true, v1, 0, 4295048017);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, v2);
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T0>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T0>(arg0), arg6);
        };
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg1, arg2, 0x2::balance::zero<T0>(), v0, false, true, v1, 0, 79226673515401279992447579054);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, v3);
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T1>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T1>(arg0), arg6);
        };
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

