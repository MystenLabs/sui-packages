module 0x15ffae43fa4e03b919adf6311b31054cab5f408dfddf4f50b5344285dac07c62::closer {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: bool, arg9: u8, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = v0;
        if (arg9 >= 1) {
            v1 = v0 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 0);
        };
        if (arg9 >= 2) {
            v1 = v1 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 1);
        };
        if (arg9 >= 3) {
            v1 = v1 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 2);
        };
        if (arg9 >= 4) {
            v1 = v1 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 3);
        };
        if (arg9 >= 5) {
            v1 = v1 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 4);
        };
        let v2 = if (v1 == 0) {
            if (0x2::clock::timestamp_ms(arg0) - arg4 <= arg5) {
                is_in_range<T0, T1>(arg2, &arg3)
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            if (arg8) {
                let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg6), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg6), 0, 4295048016 + 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg11), arg10);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg11), arg10);
                0x2::coin::destroy_zero<T1>(arg7);
            } else {
                let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg7), false, true, 0x2::coin::value<T1>(&arg7), 0, 79226673515401279992447579055 - 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg11), arg10);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg11), arg10);
                0x2::coin::destroy_zero<T0>(arg6);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, arg10);
        };
        if (arg9 >= 1 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 0) > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg11);
        };
        if (arg9 >= 2 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 1) > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg11);
        };
        if (arg9 >= 3 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 2) > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T4>(arg0, arg1, arg2, &mut arg3, arg11);
        };
        if (arg9 >= 4 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 3) > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T5>(arg0, arg1, arg2, &mut arg3, arg11);
        };
        if (arg9 >= 5 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, 4) > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T6>(arg0, arg1, arg2, &mut arg3, arg11);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg10, arg11);
    }

    fun is_in_range<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : bool {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))
    }

    // decompiled from Move bytecode v6
}

