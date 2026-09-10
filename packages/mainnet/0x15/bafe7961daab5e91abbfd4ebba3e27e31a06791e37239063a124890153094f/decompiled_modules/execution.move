module 0x15bafe7961daab5e91abbfd4ebba3e27e31a06791e37239063a124890153094f::execution {
    public fun maybe_a2b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x2::coin::Coin<T0>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg6);
        let v1 = 0x2::coin::value<T0>(&v0);
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::min_sqrt_price(), arg3, arg4, arg5);
        let v5 = v4;
        assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v5) == v1, 2);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(v0), 0x2::balance::zero<T1>(), v5);
        0x2::balance::destroy_zero<T0>(v2);
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7))
    }

    public fun maybe_b2a<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::max_sqrt_price(), arg3, arg4, arg5);
        let v5 = v4;
        assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v5) == v1, 2);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v0), v5);
        0x2::balance::destroy_zero<T1>(v3);
        0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7))
    }

    // decompiled from Move bytecode v7
}

