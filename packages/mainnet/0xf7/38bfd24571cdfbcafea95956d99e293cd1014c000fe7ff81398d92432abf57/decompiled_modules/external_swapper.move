module 0xf738bfd24571cdfbcafea95956d99e293cd1014c000fe7ff81398d92432abf57::external_swapper {
    public entry fun swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8, arg9, arg10, arg11);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg12);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v4 = 0x2::tx_context::sender(arg12);
        0x2::coin::join<T0>(&mut v2, arg5);
        0x2::coin::join<T1>(&mut v3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v4);
    }

    // decompiled from Move bytecode v6
}

