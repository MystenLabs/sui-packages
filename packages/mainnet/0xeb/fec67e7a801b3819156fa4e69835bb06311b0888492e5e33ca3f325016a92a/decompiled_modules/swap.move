module 0xebfec67e7a801b3819156fa4e69835bb06311b0888492e5e33ca3f325016a92a::swap {
    public fun stop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::limit(arg0, arg1, arg2, arg3);
        if (arg3) {
            assert!(v0 < arg1, 1);
            0x1::u128::max(v0, 4295048016)
        } else {
            assert!(v0 > arg1, 1);
            0x1::u128::min(v0, 79226673515401279992447579055)
        }
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, true, true, arg3, stop(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2), true));
        let v6 = v5;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6)), 0x2::balance::zero<T1>(), v6);
        0x2::balance::join<T0>(&mut v2, v3);
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T0, T1>(arg0, v1, v2, v4);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T1, T0>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, false, true, arg3, stop(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2), false));
        let v6 = v5;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v6)), v6);
        0x2::balance::join<T1>(&mut v2, v4);
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T1, T0>(arg0, v1, v2, v3);
    }

    // decompiled from Move bytecode v7
}

