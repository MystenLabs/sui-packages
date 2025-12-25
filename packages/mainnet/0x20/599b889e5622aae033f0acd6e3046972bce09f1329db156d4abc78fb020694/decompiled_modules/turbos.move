module 0x20599b889e5622aae033f0acd6e3046972bce09f1329db156d4abc78fb020694::turbos {
    struct TurbosSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg6), true, (v0 as u128), true, arg3, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0x2::coin::value<T0>(&v6) == 0, 3);
        0x2::coin::destroy_zero<T0>(v6);
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(v0 >= v9, 1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::split<T0>(&mut arg1, v9, arg6), 0x2::coin::zero<T1>(arg6), v4, arg5);
        let v10 = TurbosSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v5),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::with_defining_ids<T0>(),
            coin_b       : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<TurbosSwapEvent>(v10);
        assert!(0x2::coin::value<T1>(&v5) >= arg2, 2);
        (v5, arg1)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg6), false, (v0 as u128), true, arg3, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0x2::coin::value<T1>(&v5) == 0, 3);
        0x2::coin::destroy_zero<T1>(v5);
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(v0 >= v9, 1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg6), 0x2::coin::split<T1>(&mut arg1, v9, arg6), v4, arg5);
        let v10 = TurbosSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v6),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::with_defining_ids<T0>(),
            coin_b       : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<TurbosSwapEvent>(v10);
        assert!(0x2::coin::value<T0>(&v6) >= arg2, 2);
        (v6, arg1)
    }

    // decompiled from Move bytecode v6
}

