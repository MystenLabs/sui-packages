module 0xadd383fb481dd201251a0de9102347388a9258abb14ad61233cfa22427e887ef::closer {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: vector<u8>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg7);
        let v1 = false;
        if (v0 >= 1 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 0) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 2 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 1) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 3 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 2) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 4 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 3) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 5 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 4) as u64)) > 0) {
            v1 = true;
        };
        if (!v1 && is_in_range<T0, T1>(arg2, &arg3)) {
            if (arg6) {
                let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg4), 0, 4295048016 + 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg9), arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg9), arg8);
                0x2::coin::destroy_zero<T1>(arg5);
            } else {
                let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg5), false, true, 0x2::coin::value<T1>(&arg5), 0, 79226673515401279992447579055 - 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg9), arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg9), arg8);
                0x2::coin::destroy_zero<T0>(arg4);
            };
            if (v0 >= 1) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg9);
            };
            if (v0 >= 2) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg9);
            };
            if (v0 >= 3) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T4>(arg0, arg1, arg2, &mut arg3, arg9);
            };
            if (v0 >= 4) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T5>(arg0, arg1, arg2, &mut arg3, arg9);
            };
            if (v0 >= 5) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T6>(arg0, arg1, arg2, &mut arg3, arg9);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, arg8);
            if (v1) {
                if (v0 >= 1 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 0) as u64)) > 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg9);
                };
                if (v0 >= 2 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 1) as u64)) > 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg9);
                };
                if (v0 >= 3 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 2) as u64)) > 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T4>(arg0, arg1, arg2, &mut arg3, arg9);
                };
                if (v0 >= 4 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 3) as u64)) > 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T5>(arg0, arg1, arg2, &mut arg3, arg9);
                };
                if (v0 >= 5 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, (*0x1::vector::borrow<u8>(&arg7, 4) as u64)) > 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T6>(arg0, arg1, arg2, &mut arg3, arg9);
                };
            };
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg9);
    }

    fun is_in_range<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : bool {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))
    }

    // decompiled from Move bytecode v6
}

