module 0xe8edb86dac61e0d96407e64aa1bfb6277ff13174a28411861e09820ef5cd59d4::fullsail {
    public fun swap<T0, T1>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::take_balance<T0>(arg0, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, true, true, v1, 4295048017, arg3, arg4, arg7);
        let v5 = v3;
        let v6 = v2;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, v0, 0x2::balance::zero<T1>(), v4);
        let v7 = 0x2::balance::value<T0>(&v6);
        if (arg6 == 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::max_amount_in()) {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::transfer_balance<T0>(v6, 0x2::tx_context::sender(arg8), arg8);
        } else {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T0>(arg0, v6);
        };
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T1>(arg0, v5);
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::emit_swap_event<T0, T1>(arg0, b"FULLSAIL", 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg5), v1 - v7, 0x2::balance::value<T1>(&v5), v7, true);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::take_balance<T1>(arg0, arg6);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, false, true, v1, 79226673515401279992447579054, arg3, arg4, arg7);
        let v5 = v3;
        let v6 = v2;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, 0x2::balance::zero<T0>(), v0, v4);
        let v7 = 0x2::balance::value<T1>(&v5);
        if (arg6 == 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::max_amount_in()) {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::transfer_balance<T1>(v5, 0x2::tx_context::sender(arg8), arg8);
        } else {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T1>(arg0, v5);
        };
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T0>(arg0, v6);
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::emit_swap_event<T0, T1>(arg0, b"FULLSAIL", 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg5), v1 - v7, 0x2::balance::value<T0>(&v6), v7, false);
    }

    // decompiled from Move bytecode v6
}

