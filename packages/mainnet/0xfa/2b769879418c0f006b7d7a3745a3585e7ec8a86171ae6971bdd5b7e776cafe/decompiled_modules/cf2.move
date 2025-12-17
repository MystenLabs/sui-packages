module 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::cf2 {
    fun cf2<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, arg8, 4295048016, arg7);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let (v5, v6) = sbf_b_a_bao<T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, v1, v4, arg7);
        let v7 = v6;
        assert!(0x2::balance::value<T0>(&v7) >= v4, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v4), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        tb<T0>(v7, arg9);
        tb<0x2::sui::SUI>(v5, arg9);
    }

    fun calc_cf2<T0>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg3: u64) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, true, true, arg3);
        let v1 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, arg2, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v1) as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg3 as u128)))
    }

    fun calc_cf2r<T0>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg3: u64) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, arg2, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, false, true, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0));
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg3 as u128)))
    }

    public fun cf2p<T0>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg7: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        cf2p_w_s<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 1000000000, arg11, arg12);
    }

    public fun cf2p_w_s<T0>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg7: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 <= arg10, 40);
        assert!(arg12 > 0, 41);
        let v0 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg9, arg10, arg11, arg12);
        let v1 = calc_cf2<T0>(arg3, arg2, arg5, arg9);
        if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v1, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v0, arg9, v1);
            let v2 = 0;
            while (v2 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v0)) {
                0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v0, calc_cf2<T0>(arg3, arg2, arg5, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v0);
            cf2<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v3, arg13);
            return
        };
        let v5 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg9, arg10, arg11, arg12);
        let v6 = calc_cf2r<T0>(arg3, arg2, arg5, arg9);
        assert!(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v6, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero()), 25);
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v5, arg9, v6);
        let v7 = 0;
        while (v7 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v5)) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v5, calc_cf2r<T0>(arg3, arg2, arg5, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v5);
        cf2r<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v8, arg13);
    }

    fun cf2r<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg6: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg8, 79226673515401279992447579055, arg7);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<T0>(&v4) == arg8, 15);
        let (v5, v6) = sbf_a_b<T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, v4, arg7);
        let v7 = v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 50);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v8, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), v3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        tb<T0>(v5, arg9);
        tb<0x2::sui::SUI>(v7, arg9);
    }

    fun sbf_a_b<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg5) == 0) {
            return (arg5, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&arg5), 4295048016, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&arg5) >= v4, 30);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg5, v4), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        (arg5, v1)
    }

    fun sbf_b_a_bao<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg5) == 0 || arg6 == 0) {
            return (arg5, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, false, arg6, 79226673515401279992447579055, arg3, arg4, arg7);
        let v3 = v2;
        let v4 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T1>(&arg5) >= v4, 33);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, v4), v3);
        0x2::balance::destroy_zero<T1>(v1);
        (arg5, v0)
    }

    fun tb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

