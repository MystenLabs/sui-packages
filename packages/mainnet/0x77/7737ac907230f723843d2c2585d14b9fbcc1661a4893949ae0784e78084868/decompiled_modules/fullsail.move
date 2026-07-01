module 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::fullsail {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, true, 0x2::coin::value<T0>(&arg0), 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::min_sqrt_price(), arg4, arg5, arg6);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg7), arg7);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, false, true, 0x2::coin::value<T1>(&arg0), 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::max_sqrt_price(), arg4, arg5, arg6);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg7), arg7);
        0x2::coin::from_balance<T0>(v0, arg7)
    }

    // decompiled from Move bytecode v7
}

