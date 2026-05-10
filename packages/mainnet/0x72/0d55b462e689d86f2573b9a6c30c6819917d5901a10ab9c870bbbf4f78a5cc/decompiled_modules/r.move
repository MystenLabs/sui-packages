module 0x720d55b462e689d86f2573b9a6c30c6819917d5901a10ab9c870bbbf4f78a5cc::r {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct SwapEvent has copy, drop {
        dex: u8,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        profit: u64,
        recipient: address,
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 6);
    }

    public fun deepbook_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        emit_swap(30, true, 0x2::balance::value<T0>(&arg1), 0x2::balance::value<T1>(&v3));
        v3
    }

    public fun deepbook_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v1);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        emit_swap(30, false, 0x2::balance::value<T1>(&arg1), 0x2::balance::value<T0>(&v3));
        v3
    }

    public fun deepbook_borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            r : v1,
            a : arg1,
        };
        (v2, 0x2::coin::into_balance<T0>(v0))
    }

    public fun deepbook_borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            r : v1,
            a : arg1,
        };
        (v2, 0x2::coin::into_balance<T1>(v0))
    }

    public fun deepbook_repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v1), arg3), v0);
        arg1
    }

    public fun deepbook_repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            r : v0,
            a : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v1), arg3), v0);
        arg1
    }

    fun emit_swap(arg0: u8, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = SwapEvent{
            dex        : arg0,
            a2b        : arg1,
            amount_in  : arg2,
            amount_out : arg3,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun ferra_v3_a2b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg2);
        emit_swap(22, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun ferra_v3_b2a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg2);
        emit_swap(22, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun ferra_v4_a2b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, 0x2::coin::from_balance<T0>(arg2, arg4), 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        emit_swap(23, true, 0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&v2));
        v2
    }

    public fun ferra_v4_b2a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg2, arg4), arg3, arg4);
        0x2::coin::destroy_zero<T1>(v1);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        emit_swap(23, false, 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T0>(&v2));
        v2
    }

    public fun flowx_v2_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2));
        emit_swap(24, true, 0x2::balance::value<T0>(&arg1), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun flowx_v2_b2a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), arg2));
        emit_swap(24, false, 0x2::balance::value<T1>(&arg1), 0x2::balance::value<T0>(&v0));
        v0
    }

    public fun flowx_v3_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, true, true, v0, 4295048016, arg1, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T0>(v1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v4, 0x2::balance::split<T0>(&mut arg2, v6), 0x2::balance::zero<T1>(), arg1, arg4);
        0x2::balance::destroy_zero<T0>(arg2);
        emit_swap(25, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun flowx_v3_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, false, true, v0, 79226673515401279992447579055, arg1, arg3, arg4);
        let v4 = v3;
        let v5 = v1;
        let (_, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T1>(v2);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v7), arg1, arg4);
        0x2::balance::destroy_zero<T1>(arg2);
        emit_swap(25, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun flowx_v3_flash_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, true, false, arg2, 4295048016, arg1, arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        let v6 = LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>{
            r : v3,
            a : v4,
        };
        (v6, v1)
    }

    public fun flowx_v3_flash_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, false, false, arg2, 79226673515401279992447579055, arg1, arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v3);
        let v6 = LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>{
            r : v3,
            a : v5,
        };
        (v6, v0)
    }

    public fun flowx_v3_repay_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v0, 0x2::balance::split<T0>(&mut arg2, v1), 0x2::balance::zero<T1>(), arg1, arg4);
        arg2
    }

    public fun flowx_v3_repay_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: LL<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), arg1, arg4);
        arg2
    }

    public fun fullsail_a2b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg5);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v0, 4295048017, arg3, arg4, arg6);
        let v4 = v2;
        let v5 = v1;
        0x2::balance::join<T0>(&mut v5, arg5);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, v5, 0x2::balance::zero<T1>(), v3);
        emit_swap(27, true, v0, 0x2::balance::value<T1>(&v4));
        v4
    }

    public fun fullsail_b2a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg5);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v0, 79226673515401279992447579054, arg3, arg4, arg6);
        let v4 = v2;
        let v5 = v1;
        0x2::balance::join<T1>(&mut v4, arg5);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v4, v3);
        emit_swap(27, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun fullsail_flash_a2b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, false, arg5, 4295048017, arg3, arg4, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v1)
    }

    public fun fullsail_flash_b2a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, false, arg5, 79226673515401279992447579054, arg3, arg4, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v0)
    }

    public fun fullsail_repay_a2b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v1), 0x2::balance::zero<T1>(), v0);
        arg2
    }

    public fun fullsail_repay_b2a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: LL<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), v0);
        arg2
    }

    public fun kriya_v2_a2b<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), v0, 0, arg2));
        emit_swap(26, true, v0, 0x2::balance::value<T1>(&v1));
        v1
    }

    public fun kriya_v2_b2a<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = 0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), v0, 0, arg2));
        emit_swap(26, false, v0, 0x2::balance::value<T0>(&v1));
        v1
    }

    public fun kriya_v3_a2b<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, true, true, v0, 4295048016, arg3, arg2, arg4);
        let v4 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, arg1, 0x2::balance::zero<T1>(), arg2, arg4);
        emit_swap(29, true, v0, 0x2::balance::value<T1>(&v4));
        v4
    }

    public fun kriya_v3_b2a<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, false, true, v0, 79226673515401279992447579055, arg3, arg2, arg4);
        let v4 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), arg1, arg2, arg4);
        emit_swap(29, false, v0, 0x2::balance::value<T0>(&v4));
        v4
    }

    public fun momentum_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, v0, 4295048016, arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T0>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, 0x2::balance::split<T0>(&mut arg2, v6), 0x2::balance::zero<T1>(), arg1, arg4);
        0x2::balance::destroy_zero<T0>(arg2);
        emit_swap(21, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun momentum_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, v0, 79226673515401279992447579055, arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v1;
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T1>(v2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v7), arg1, arg4);
        0x2::balance::destroy_zero<T1>(arg2);
        emit_swap(21, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun momentum_flash_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, false, arg2, 4295048016, arg3, arg1, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>{
            r : v3,
            a : v4,
        };
        (v6, v1)
    }

    public fun momentum_flash_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, false, arg2, 79226673515401279992447579055, arg3, arg1, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>{
            r : v3,
            a : v5,
        };
        (v6, v0)
    }

    public fun momentum_repay_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v0, 0x2::balance::split<T0>(&mut arg2, v1), 0x2::balance::zero<T1>(), arg1, arg4);
        arg2
    }

    public fun momentum_repay_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: LL<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), arg1, arg4);
        arg2
    }

    fun phantom_dep_anchor(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::PriceFeed, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<u8>) {
        abort 0
    }

    public fun steamm_cpmm_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::balance::value<T1>(&arg4);
        let v1 = 0x2::coin::from_balance<T1>(arg4, arg6);
        let v2 = 0x2::coin::zero<T2>(arg6);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut v1, v0, arg5, arg6);
        let v4 = 0x2::coin::zero<T4>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v3, &mut v4, true, 0x2::coin::value<T3>(&v3), 0, arg6);
        let v5 = 0x2::coin::value<T4>(&v4);
        if (v5 > 0) {
            0x2::coin::join<T2>(&mut v2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v4, v5, arg5, arg6));
        };
        0x2::coin::destroy_zero<T3>(v3);
        0x2::coin::destroy_zero<T4>(v4);
        0x2::coin::destroy_zero<T1>(v1);
        let v6 = 0x2::coin::into_balance<T2>(v2);
        emit_swap(28, true, v0, 0x2::balance::value<T2>(&v6));
        v6
    }

    public fun steamm_cpmm_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T2>(&arg4);
        let v1 = 0x2::coin::zero<T1>(arg6);
        let v2 = 0x2::coin::from_balance<T2>(arg4, arg6);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut v2, v0, arg5, arg6);
        let v4 = 0x2::coin::zero<T3>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, false, 0x2::coin::value<T4>(&v3), 0, arg6);
        let v5 = 0x2::coin::value<T3>(&v4);
        if (v5 > 0) {
            0x2::coin::join<T1>(&mut v1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v4, v5, arg5, arg6));
        };
        0x2::coin::destroy_zero<T4>(v3);
        0x2::coin::destroy_zero<T3>(v4);
        0x2::coin::destroy_zero<T2>(v2);
        let v6 = 0x2::coin::into_balance<T1>(v1);
        emit_swap(28, false, v0, 0x2::balance::value<T1>(&v6));
        v6
    }

    public fun xz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 2);
        let v1 = ProfitEvent<T0>{
            profit    : v0,
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfitEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

