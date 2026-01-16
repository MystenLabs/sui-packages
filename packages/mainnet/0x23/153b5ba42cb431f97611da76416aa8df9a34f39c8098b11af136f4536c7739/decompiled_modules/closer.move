module 0x23153b5ba42cb431f97611da76416aa8df9a34f39c8098b11af136f4536c7739::closer {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: bool, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: bool, arg10: u8, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = is_in_range<T0, T1>(arg2, &arg3);
        if (0x2::clock::timestamp_ms(arg0) - arg4 <= arg5 && v0) {
            if (arg9) {
                let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg7), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg7), 0, 4295048016 + 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg12), arg11);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg12), arg11);
                0x2::coin::destroy_zero<T1>(arg8);
            } else {
                let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg8), false, true, 0x2::coin::value<T1>(&arg8), 0, 79226673515401279992447579055 - 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg12), arg11);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg12), arg11);
                0x2::coin::destroy_zero<T0>(arg7);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, arg11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg8, arg11);
        };
        let v5 = !v0 && !arg6;
        if (!v5) {
            if (arg10 >= 1) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg12);
            };
            if (arg10 >= 2) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg12);
            };
            if (arg10 >= 3) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T4>(arg0, arg1, arg2, &mut arg3, arg12);
            };
            if (arg10 >= 4) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T5>(arg0, arg1, arg2, &mut arg3, arg12);
            };
            if (arg10 >= 5) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T6>(arg0, arg1, arg2, &mut arg3, arg12);
            };
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg11, arg12);
    }

    fun is_in_range<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : bool {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))
    }

    // decompiled from Move bytecode v6
}

