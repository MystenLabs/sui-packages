module 0x25ca923cb187edcfd1de8e4eef779fa9d90b8b3280c5b84e3dab71d53b8e0f86::swap {
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

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T0, T1>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg9), true, (arg3 as u128), true, stop(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64), true), arg8, arg2, arg9);
        let v6 = v5;
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v9), arg9), 0x2::coin::zero<T1>(arg9), v6, arg2);
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v3));
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T0, T1>(arg0, v1, v2, 0x2::coin::into_balance<T1>(v4));
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T1, T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg9), false, (arg3 as u128), true, stop(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64), false), arg8, arg2, arg9);
        let v6 = v5;
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v9), arg9), v6, arg2);
        0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(v4));
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T1, T0>(arg0, v1, v2, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v7
}

