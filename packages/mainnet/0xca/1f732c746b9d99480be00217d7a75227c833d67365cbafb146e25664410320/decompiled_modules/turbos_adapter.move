module 0x2370fb098c171f346ac60e5f980393efd2c3b6ee63ed680bd593cf0102d73c2::turbos_adapter {
    public fun quote<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = if (arg3) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg0, arg3, (arg4 as u128), true, v0, arg2, arg1, arg5);
        let v2 = 0x2::bcs::new(0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v1));
        0x2::bcs::peel_u128(&mut v2);
        0x2::bcs::peel_u128(&mut v2);
        let v3 = 0x2::bcs::peel_u128(&mut v2);
        if (0x2::bcs::peel_u128(&mut v2) != 0 || v3 > 18446744073709551615) {
            0
        } else {
            (v3 as u64)
        }
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (v0 as u128), true, 4295048016 + 1, arg2, arg1, arg4);
        let v4 = v3;
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x2::coin::destroy_zero<T0>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, v7), arg4), 0x2::coin::zero<T1>(arg4), v4, arg1);
        (0x2::coin::into_balance<T1>(v2), arg3)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (v0 as u128), true, 79226673515401279992447579055 - 1, arg2, arg1, arg4);
        let v4 = v3;
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x2::coin::destroy_zero<T1>(v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, v7), arg4), v4, arg1);
        (0x2::coin::into_balance<T0>(v1), arg3)
    }

    // decompiled from Move bytecode v7
}

