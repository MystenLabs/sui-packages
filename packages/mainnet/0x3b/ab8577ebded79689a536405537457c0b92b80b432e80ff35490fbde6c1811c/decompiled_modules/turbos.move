module 0x109a6beef3ac427eb06276404d6b3dee87c5fca28851756b535dc81f63b00d9a::turbos {
    struct DeferredReceipt<phantom T0, phantom T1> {
        repay_a: 0x2::coin::Coin<T0>,
        repay_b: 0x2::coin::Coin<T1>,
        receipt: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>,
        amount: u64,
        a_to_b: bool,
    }

    fun append_model<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula, arg2: bool) {
        0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::append_v3_edge(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64), 1000000, arg2);
    }

    public fun append_model_a_to_b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1, T2>(arg0, arg1, true);
    }

    public fun append_model_b_to_a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1, T2>(arg0, arg1, false);
    }

    fun default_sqrt_price_limit_a_to_b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : u128 {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0)))
    }

    fun default_sqrt_price_limit_b_to_a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : u128 {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0)))
    }

    public fun flash_swap_exact_in_a_to_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (arg2 as u128), true, default_sqrt_price_limit_a_to_b<T0, T1, T2>(arg0), arg3, arg1, arg4);
        let v3 = v2;
        let (_, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v3);
        assert!(v5, 2);
        assert!(v6 == arg2, 1);
        let v7 = DeferredReceipt<T0, T1>{
            repay_a : v0,
            repay_b : 0x2::coin::zero<T1>(arg4),
            receipt : v3,
            amount  : arg2,
            a_to_b  : true,
        };
        (0x2::coin::into_balance<T1>(v1), v7)
    }

    public fun flash_swap_exact_in_b_to_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (arg2 as u128), true, default_sqrt_price_limit_b_to_a<T0, T1, T2>(arg0), arg3, arg1, arg4);
        let v3 = v2;
        let (_, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v3);
        assert!(!v5, 2);
        assert!(v6 == arg2, 1);
        let v7 = DeferredReceipt<T0, T1>{
            repay_a : 0x2::coin::zero<T0>(arg4),
            repay_b : v1,
            receipt : v3,
            amount  : arg2,
            a_to_b  : false,
        };
        (0x2::coin::into_balance<T0>(v0), v7)
    }

    public fun repay_flash_swap_a_to_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: DeferredReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg3;
        let v5 = v0;
        assert!(v4 && 0x2::balance::value<T0>(&arg2) == v3, 2);
        0x2::coin::join<T0>(&mut v5, 0x2::coin::from_balance<T0>(arg2, arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v5, v1, v2, arg1);
    }

    public fun repay_flash_swap_b_to_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: DeferredReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg3;
        let v5 = v1;
        assert!(!v4 && 0x2::balance::value<T1>(&arg2) == v3, 2);
        0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(arg2, arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v0, v5, v2, arg1);
    }

    public fun repayment_amount<T0, T1>(arg0: &DeferredReceipt<T0, T1>) : u64 {
        arg0.amount
    }

    public fun swap_exact_in<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        swap_exact_in_a_to_b<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun swap_exact_in_a_to_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (v0 as u128), true, default_sqrt_price_limit_a_to_b<T0, T1, T2>(arg0), arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v1;
        let (_, v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(v7, 2);
        assert!(v8 == v0, 1);
        0x2::coin::join<T0>(&mut v5, 0x2::coin::from_balance<T0>(arg2, arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v5, 0x2::coin::zero<T1>(arg4), v4, arg1);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun swap_exact_in_b_to_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (v0 as u128), true, default_sqrt_price_limit_b_to_a<T0, T1, T2>(arg0), arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v2;
        let (_, v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        assert!(!v7, 2);
        assert!(v8 == v0, 1);
        0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(arg2, arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), v5, v4, arg1);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

