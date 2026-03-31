module 0xad18edd6b47000bda0258e1ec538e88ab4baea8c1b723ea09820561e69c3a1b4::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T0>(arg0, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, true, true, v1, 4295048017, arg3, arg4, arg7);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, v0, 0x2::balance::zero<T1>(), v4);
        if (arg6 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T0>(v2, 0x2::tx_context::sender(arg8), arg8);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, v2);
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T1>(arg0, arg6);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, false, true, v1, 79226673515401279992447579054, arg3, arg4, arg7);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, 0x2::balance::zero<T0>(), v0, v4);
        if (arg6 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T1>(v3, 0x2::tx_context::sender(arg8), arg8);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v3);
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v6
}

