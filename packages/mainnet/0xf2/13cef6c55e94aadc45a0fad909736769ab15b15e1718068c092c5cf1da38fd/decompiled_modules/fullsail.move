module 0xf213cef6c55e94aadc45a0fad909736769ab15b15e1718068c092c5cf1da38fd::fullsail {
    public fun flash_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg2, arg3, arg1, true, true, v0, 4295048016, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg2, arg3, arg1, false, true, v0, 79226673515401279992447579055, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg3)), 0x2::balance::zero<T1>(), arg4);
        arg3
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: 0x2::balance::Balance<T1>, arg4: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg3)), arg4);
        arg3
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg7);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T1, T2>(arg2, arg3, arg1, true, true, v0, 4295048016, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::split<T1>(&mut arg7, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg7)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: &0x2::clock::Clock, arg7: 0x2::balance::Balance<T2>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg7);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T1, T2>(arg2, arg3, arg1, false, true, v0, 79226673515401279992447579055, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T1, T2>(arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg7, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T1, T2>(&v4)), v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg7)
    }

    // decompiled from Move bytecode v7
}

