module 0xc5ceb205d6645c79b40398a5fc652e505a8d9c11ca1c8f13f0dfd8faa8a1c139::executor {
    public entry fun create_pool_with_liquidity_only<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg4, arg9, arg4, arg5, arg6, arg7, arg8, 0x1::vector::empty<u8>(), arg10, arg11, arg12, 0x2::coin::into_balance<0x2::sui::SUI>(arg13), 2146983648, 2147983648, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg14, true, arg15);
        let v6 = 0x2::tx_context::sender(arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg15), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg15), v6);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v1, v6);
    }

    // decompiled from Move bytecode v6
}

