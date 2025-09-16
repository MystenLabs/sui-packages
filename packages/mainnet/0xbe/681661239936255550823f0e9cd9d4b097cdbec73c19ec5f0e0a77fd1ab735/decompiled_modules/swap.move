module 0xbe681661239936255550823f0e9cd9d4b097cdbec73c19ec5f0e0a77fd1ab735::swap {
    public fun swap_send<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7, arg8, v0);
        if (arg5) {
            transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v1, arg10), 0x2::tx_context::sender(arg10), arg10);
            transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v2, arg10), arg9, arg10);
        } else {
            transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v1, arg10), arg9, arg10);
            transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v2, arg10), 0x2::tx_context::sender(arg10), arg10);
        };
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

