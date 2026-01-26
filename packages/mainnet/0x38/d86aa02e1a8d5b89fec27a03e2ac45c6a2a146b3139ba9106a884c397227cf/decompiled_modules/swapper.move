module 0x38d86aa02e1a8d5b89fec27a03e2ac45c6a2a146b3139ba9106a884c397227cf::swapper {
    entry fun calculate_swap_results_entry<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8, arg9, arg10, arg11);
        let v2 = 0x2::tx_context::sender(arg12);
        transfer_to_coin<T0>(v0, arg5, v2, arg12);
        transfer_to_coin<T1>(v1, arg6, v2, arg12);
    }

    public fun transfer_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(arg0, arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

