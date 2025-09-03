module 0x38e277cd3de7f8bfb47f8fd2244a04a851fcf013839e7a9a1e2ea4f6bdcc56ed::swap {
    public fun swap_send<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        if (arg5) {
            transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg11), 0x2::tx_context::sender(arg11), arg11);
            transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg10, arg11);
        } else {
            transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg11), arg10, arg11);
            transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), 0x2::tx_context::sender(arg11), arg11);
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

