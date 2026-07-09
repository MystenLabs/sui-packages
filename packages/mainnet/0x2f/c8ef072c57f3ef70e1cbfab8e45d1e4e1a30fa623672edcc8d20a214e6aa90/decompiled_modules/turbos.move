module 0x2fc8ef072c57f3ef70e1cbfab8e45d1e4e1a30fa623672edcc8d20a214e6aa90::turbos {
    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun turbos_swap_a2b_bal<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (0x2::balance::value<T0>(&arg1) as u128), true, 4295048016, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(arg1, arg4), 0x2::coin::zero<T1>(arg4), v2, arg3);
        let v4 = HopRecord{out_amount: 0x2::balance::value<T1>(&v3)};
        0x2::event::emit<HopRecord>(v4);
        v3
    }

    public fun turbos_swap_b2a_bal<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (0x2::balance::value<T1>(&arg1) as u128), true, 79226673515401279992447579055, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg1, arg4), v2, arg3);
        let v4 = HopRecord{out_amount: 0x2::balance::value<T0>(&v3)};
        0x2::event::emit<HopRecord>(v4);
        v3
    }

    // decompiled from Move bytecode v7
}

