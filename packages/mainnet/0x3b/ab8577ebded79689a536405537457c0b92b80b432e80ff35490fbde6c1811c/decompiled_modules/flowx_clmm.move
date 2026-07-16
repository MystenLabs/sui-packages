module 0x109a6beef3ac427eb06276404d6b3dee87c5fca28851756b535dc81f63b00d9a::flowx_clmm {
    struct DeferredReceipt<phantom T0, phantom T1> {
        repay_a: 0x2::balance::Balance<T0>,
        repay_b: 0x2::balance::Balance<T1>,
        receipt: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt,
        amount: u64,
        a_to_b: bool,
    }

    fun append_model<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula, arg3: bool) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1);
        0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::append_v3_edge(arg2, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(v0), 1000000, arg3);
    }

    public fun append_model_a_to_b<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1>(arg0, arg1, arg2, true);
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1>(arg0, arg1, arg2, false);
    }

    public fun flash_swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1), true, true, arg3, 281477621741597, arg2, arg4, arg5);
        let v3 = v2;
        let (v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        assert!(v4 == arg3, 1);
        assert!(v5 == 0, 2);
        let v6 = DeferredReceipt<T0, T1>{
            repay_a : v0,
            repay_b : 0x2::balance::zero<T1>(),
            receipt : v3,
            amount  : arg3,
            a_to_b  : true,
        };
        (v1, v6)
    }

    public fun flash_swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1), false, true, arg3, 1208914459399994097008639, arg2, arg4, arg5);
        let v3 = v2;
        let (v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        assert!(v4 == 0, 2);
        assert!(v5 == arg3, 1);
        let v6 = DeferredReceipt<T0, T1>{
            repay_a : 0x2::balance::zero<T0>(),
            repay_b : v1,
            receipt : v3,
            amount  : arg3,
            a_to_b  : false,
        };
        (v0, v6)
    }

    public fun repay_flash_swap_a_to_b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: DeferredReceipt<T0, T1>, arg5: &0x2::tx_context::TxContext) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg4;
        let v5 = v0;
        assert!(v4 && 0x2::balance::value<T0>(&arg3) == v3, 3);
        0x2::balance::join<T0>(&mut v5, arg3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1), v2, v5, v1, arg2, arg5);
    }

    public fun repay_flash_swap_b_to_a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: DeferredReceipt<T0, T1>, arg5: &0x2::tx_context::TxContext) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg4;
        let v5 = v1;
        assert!(!v4 && 0x2::balance::value<T1>(&arg3) == v3, 3);
        0x2::balance::join<T1>(&mut v5, arg3);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1), v2, v0, v5, arg2, arg5);
    }

    public fun repayment_amount<T0, T1>(arg0: &DeferredReceipt<T0, T1>) : u64 {
        arg0.amount
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg5), 1, 281477621741597, 18446744073709551615, arg3, arg4, arg5))
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T1, T0>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg5), 1, 1208914459399994097008639, 18446744073709551615, arg3, arg4, arg5))
    }

    // decompiled from Move bytecode v7
}

