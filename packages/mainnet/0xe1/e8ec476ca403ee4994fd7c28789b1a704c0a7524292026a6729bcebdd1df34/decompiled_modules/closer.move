module 0xe1e8ec476ca403ee4994fd7c28789b1a704c0a7524292026a6729bcebdd1df34::closer {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: vector<u8>, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x7c88663e7928a8fcd1a8c16f110580270cde571987ff1ccfa7c72d772370604d);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            if (*0x1::vector::borrow<address>(&v0, v2) == 0x2::tx_context::sender(arg10)) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3);
        let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), v3, arg7);
        let (_, _, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v3, arg0);
        let v10 = 0x2::coin::from_balance<T0>(v8, arg10);
        let v11 = 0x2::coin::from_balance<T1>(v9, arg10);
        let v12 = true;
        if (is_in_range<T0, T1>(arg2, &arg3) && arg6) {
            if (arg4 < v4 && arg5 > v5) {
                let v13 = v4 - arg4;
                let (v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, v13, arg10)), 0x2::balance::zero<T1>(), true, v12, v13, 0, 4295048017);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg10), arg9);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v15, arg10), arg9);
            };
            if (arg4 > v4 && arg5 < v5) {
                let v16 = v5 - arg5;
                let (v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v16, arg10)), false, v12, v16, 0, 79226673515401279992447579054);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg10), arg9);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg10), arg9);
            };
        };
        let v19 = 0;
        while (v19 < 0x1::vector::length<u8>(&arg8)) {
            let v20 = (*0x1::vector::borrow<u8>(&arg8, v19) as u64);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(&arg3, v20) > 0) {
                if (v20 == 0) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg10);
                };
                if (v20 == 1) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg10);
                };
                if (v20 == 2) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T4>(arg0, arg1, arg2, &mut arg3, arg10);
                };
                if (v20 == 3) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T5>(arg0, arg1, arg2, &mut arg3, arg10);
                };
                if (v20 == 4) {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T6>(arg0, arg1, arg2, &mut arg3, arg10);
                };
            };
            v19 = v19 + 1;
        };
        if (0x2::coin::value<T0>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v10);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, arg9);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg9, arg10);
    }

    fun is_in_range<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : bool {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))
    }

    // decompiled from Move bytecode v6
}

