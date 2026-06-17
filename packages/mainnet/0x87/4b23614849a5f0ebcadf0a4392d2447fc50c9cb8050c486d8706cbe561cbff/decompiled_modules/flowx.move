module 0x6c6e51e5780ff7a8435b755c6346414b4439afc760f0199c64ee252f9e84900c::flowx {
    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun flowx_flash_borrow_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::FlashReceipt, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::flash<T0, T1>(arg0, 0, arg1, arg2, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        (v2, v1)
    }

    public fun flowx_flash_borrow_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::FlashReceipt, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::flash<T0, T1>(arg0, arg1, 0, arg2, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        (v2, v0)
    }

    public fun flowx_flash_repay_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::FlashReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::flash_receipt_debts(&arg1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::repay<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v0), 0x2::balance::zero<T1>(), arg3, arg4);
        arg2
    }

    public fun flowx_flash_repay_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::FlashReceipt, arg2: 0x2::balance::Balance<T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::flash_receipt_debts(&arg1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::repay<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), arg3, arg4);
        arg2
    }

    public fun flowx_swap_a2b_bal<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg1), 4295048016, arg3, arg2, arg4);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let (v5, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        0x2::balance::destroy_zero<T0>(arg1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v3, 0x2::balance::split<T0>(&mut arg1, v5), 0x2::balance::zero<T1>(), arg3, arg4);
        let v7 = HopRecord{out_amount: 0x2::balance::value<T1>(&v4)};
        0x2::event::emit<HopRecord>(v7);
        v4
    }

    public fun flowx_swap_b2a_bal<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg1), 79226673515401279992447579055, arg3, arg2, arg4);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        0x2::balance::destroy_zero<T1>(arg1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1, v6), arg3, arg4);
        let v7 = HopRecord{out_amount: 0x2::balance::value<T0>(&v4)};
        0x2::event::emit<HopRecord>(v7);
        v4
    }

    // decompiled from Move bytecode v7
}

