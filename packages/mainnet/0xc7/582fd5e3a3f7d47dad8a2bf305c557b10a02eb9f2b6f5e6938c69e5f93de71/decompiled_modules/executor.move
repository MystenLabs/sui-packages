module 0xc7582fd5e3a3f7d47dad8a2bf305c557b10a02eb9f2b6f5e6938c69e5f93de71::executor {
    public entry fun create_pool_with_liquidity_only<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::coin::Coin<T2>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_tick_range(arg1);
        let (_, v3, _, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<T0, T1, T2>(arg0, arg1, arg4, arg9, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<u8>(), arg10, arg11, arg12, 0x2::coin::into_balance<T2>(arg13), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v1), 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg14, true, arg15);
        let v8 = 0x2::tx_context::sender(arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg15), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg15), v8);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v3, v8);
    }

    // decompiled from Move bytecode v6
}

