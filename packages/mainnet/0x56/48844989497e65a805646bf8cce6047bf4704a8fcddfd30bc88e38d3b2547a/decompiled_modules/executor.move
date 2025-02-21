module 0x5648844989497e65a805646bf8cce6047bf4704a8fcddfd30bc88e38d3b2547a::executor {
    public entry fun create_pool_with_liquidity_only<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg15));
        let (_, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_tick_range(arg1);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg10);
        let (_, v4, _, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg4, arg9, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<u8>(), arg10, arg11, arg12, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg15)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(100), v2), v2), v2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(200), v2), v2), v2)), 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg14, true, arg15);
        let v9 = 0x2::tx_context::sender(arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg15), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg15), v9);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v4, v9);
    }

    // decompiled from Move bytecode v6
}

