module 0x718a38527e9afe9a13f55c1e954d2bd9391a3c3b6d922425c91ef5b31c5730d6::bluefin {
    public fun swap_delta<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (v0 > 10000000000 + arg4) {
            let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg0, arg1, 0x2::balance::zero<T0>(), arg3, false, true, v0 - arg4, 0, 79226673515401279992447579055 - 1);
            0x2::balance::join<T0>(&mut arg2, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
        } else if (v1 > 10000000 + arg5) {
            let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, v1 - arg5, 0, 4295048016 + 1);
            0x2::balance::join<T1>(&mut arg3, v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg3, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg3, arg7), @0x198cc0384e148ff9194c80434de643f136b7be45acf9ac29337d484a1983abde);
        };
    }

    // decompiled from Move bytecode v6
}

