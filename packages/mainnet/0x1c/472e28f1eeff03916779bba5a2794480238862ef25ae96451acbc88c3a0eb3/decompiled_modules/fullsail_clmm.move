module 0x1c472e28f1eeff03916779bba5a2794480238862ef25ae96451acbc88c3a0eb3::fullsail_clmm {
    public fun fullsail_clmm_add_liquidity<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::tick_range(arg4);
        let v2 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::get_sqrt_price_at_tick(v0);
        let v3 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::get_sqrt_price_at_tick(v1);
        let v4 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0);
        let v5 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0);
        let v6 = 0;
        let v7 = 0;
        if (v5 < v3) {
            let (v8, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, v4, v5, 0x2::coin::value<T0>(&arg5), true);
            v6 = v8;
        };
        if (v5 > v2) {
            let (v11, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::clmm_math::get_liquidity_by_amount(v0, v1, v4, v5, 0x2::coin::value<T1>(&arg6), false);
            v7 = v11;
        };
        let v14 = if (v5 <= v2) {
            v6
        } else if (v5 >= v3) {
            v7
        } else if (v6 < v7) {
            v6
        } else {
            v7
        };
        if (v14 == 0) {
            return (arg5, arg6)
        };
        let v15 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity<T0, T1>(arg2, arg1, arg0, arg4, v14, arg3);
        let v16 = 0x2::coin::into_balance<T0>(arg5);
        let v17 = 0x2::coin::into_balance<T1>(arg6);
        let (v18, v19) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::add_liquidity_pay_amount<T0, T1>(&v15);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_add_liquidity<T0, T1>(arg2, arg0, 0x2::balance::split<T0>(&mut v16, v18), 0x2::balance::split<T1>(&mut v17, v19), v15);
        (0x2::coin::from_balance<T0>(v16, arg7), 0x2::coin::from_balance<T1>(v17, arg7))
    }

    public fun fullsail_clmm_close_position<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position) {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::close_position<T0, T1>(arg1, arg0, arg2);
    }

    public fun fullsail_clmm_collect_fee<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_fee<T0, T1>(arg2, arg0, arg4, true);
        let v2 = v1;
        let v3 = v0;
        if (arg5) {
            0x2::balance::join<T0>(&mut v3, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_reward<T0, T1, T0>(arg2, arg0, arg4, arg1, false, arg3));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut v2, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_reward<T0, T1, T1>(arg2, arg0, arg4, arg1, false, arg3));
        };
        (0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::from_balance<T1>(v2, arg7))
    }

    public fun fullsail_clmm_collect_reward<T0, T1, T2>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_reward<T0, T1, T2>(arg2, arg0, arg4, arg1, false, arg3), arg5)
    }

    public fun fullsail_clmm_flashswap_a2b<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg3, arg1, arg0, true, true, arg6, arg7, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg8), v2)
    }

    public fun fullsail_clmm_flashswap_b2a<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg3, arg1, arg0, false, true, arg6, arg7, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg8), v2)
    }

    public fun fullsail_clmm_open_position<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::open_position<T0, T1>(arg1, arg0, arg2, arg3, arg4)
    }

    public fun fullsail_clmm_remove_liquidity<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::Position, arg5: u128, arg6: bool, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg5 == 0) {
            arg5 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::position::liquidity(arg4);
        };
        let (v0, v1) = if (arg5 > 0) {
            0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::remove_liquidity<T0, T1>(arg2, arg1, arg0, arg4, arg5, arg3)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_fee<T0, T1>(arg2, arg0, arg4, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        if (arg6) {
            0x2::balance::join<T0>(&mut v3, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_reward<T0, T1, T0>(arg2, arg0, arg4, arg1, false, arg3));
        };
        if (arg7) {
            0x2::balance::join<T1>(&mut v2, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::collect_reward<T0, T1, T1>(arg2, arg0, arg4, arg1, false, arg3));
        };
        (0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<T1>(v2, arg8))
    }

    public fun fullsail_clmm_repay_flashswap_a2b<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3);
    }

    public fun fullsail_clmm_repay_flashswap_b2a<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3);
    }

    public fun fullsail_clmm_swap_a2b<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg3, arg1, arg0, true, true, 0x2::coin::value<T0>(&arg6), arg7, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg3, arg0, 0x2::coin::into_balance<T0>(arg6), 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg8)
    }

    public fun fullsail_clmm_swap_b2a<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg3, arg1, arg0, false, true, 0x2::coin::value<T1>(&arg6), arg7, arg2, arg4, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg3, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg6), v2);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

