module 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uc_rebalance_adapter {
    struct CETUS_HANDLER has drop {
        dummy_field: bool,
    }

    struct KRIYA_HANDLER has drop {
        dummy_field: bool,
    }

    public fun cetus_handler<T0, T1>(arg0: 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::RebalanceAdapterReceipt, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::RebalanceAdapterReceipt {
        let v0 = CETUS_HANDLER{dummy_field: false};
        assert!(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_target_handler(&arg0) == 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::generate_auth_token<CETUS_HANDLER>(&v0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::invalid_target_adapter());
        assert!(!0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::is_processed(&arg0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::receipt_already_processed());
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let (v3, v4) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_slippage(&arg0);
        let (v5, v6) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_position_tick_index(&arg0);
        let v7 = CETUS_HANDLER{dummy_field: false};
        let (v8, v9) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::take_assets<T0, T1, CETUS_HANDLER>(&mut arg0, &v7);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::value<T0>(&v11);
        0x2::balance::value<T1>(&v10);
        let (v12, v13) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_sqrt_price(&arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_pool_liquidity(&arg0), false);
        let (v14, v15) = if (0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_is_target_reverse(&arg0)) {
            (v13, v12)
        } else {
            (v12, v13)
        };
        if (v14 == 0) {
            let (v16, v17) = swap_optimal_on_cetus<T0, T1>(arg2, arg1, v11, v10, v14, v15, v3, v4, true, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v16);
            0x2::balance::join<T1>(&mut v2, v17);
        } else if (v15 == 0) {
            let (v18, v19) = swap_optimal_on_cetus<T0, T1>(arg2, arg1, v11, v10, v14, v15, v3, v4, false, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v18);
            0x2::balance::join<T1>(&mut v2, v19);
        } else if (0x2::balance::value<T0>(&v11) == 0) {
            let (v20, v21) = swap_optimal_on_cetus<T0, T1>(arg2, arg1, v11, v10, v14, v15, v3, v4, false, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v20);
            0x2::balance::join<T1>(&mut v2, v21);
        } else if (0x2::balance::value<T1>(&v10) == 0) {
            let (v22, v23) = swap_optimal_on_cetus<T0, T1>(arg2, arg1, v11, v10, v14, v15, v3, v4, true, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v22);
            0x2::balance::join<T1>(&mut v2, v23);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
            0x2::balance::destroy_zero<T0>(v11);
            abort 69420
        };
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::fill_assets<T0, T1>(&mut arg0, v1, v2);
        let v24 = CETUS_HANDLER{dummy_field: false};
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::mark_processed<CETUS_HANDLER>(&mut arg0, &v24);
        arg0
    }

    public fun kriya_handler<T0, T1>(arg0: 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::RebalanceAdapterReceipt, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::RebalanceAdapterReceipt {
        let v0 = KRIYA_HANDLER{dummy_field: false};
        assert!(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_target_handler(&arg0) == 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::generate_auth_token<KRIYA_HANDLER>(&v0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::invalid_target_adapter());
        assert!(!0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::is_processed(&arg0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::receipt_already_processed());
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let (v3, v4) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_slippage(&arg0);
        let (v5, v6) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_position_tick_index(&arg0);
        let v7 = KRIYA_HANDLER{dummy_field: false};
        let (v8, v9) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::take_assets<T0, T1, KRIYA_HANDLER>(&mut arg0, &v7);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::value<T0>(&v11);
        0x2::balance::value<T1>(&v10);
        let (v12, v13) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_sqrt_price(&arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::receipt_pool_liquidity(&arg0), false);
        if (v12 == 0) {
            let (v14, v15) = swap_optimal_on_kriya<T0, T1>(arg1, arg2, v11, v10, v12, v13, v3, v4, true, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v14);
            0x2::balance::join<T1>(&mut v2, v15);
        } else if (v13 == 0) {
            let (v16, v17) = swap_optimal_on_kriya<T0, T1>(arg1, arg2, v11, v10, v12, v13, v3, v4, false, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v16);
            0x2::balance::join<T1>(&mut v2, v17);
        } else if (0x2::balance::value<T0>(&v11) == 0) {
            let (v18, v19) = swap_optimal_on_kriya<T0, T1>(arg1, arg2, v11, v10, v12, v13, v3, v4, false, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v18);
            0x2::balance::join<T1>(&mut v2, v19);
        } else if (0x2::balance::value<T1>(&v10) == 0) {
            let (v20, v21) = swap_optimal_on_kriya<T0, T1>(arg1, arg2, v11, v10, v12, v13, v3, v4, true, 16, arg3, arg4);
            0x2::balance::join<T0>(&mut v1, v20);
            0x2::balance::join<T1>(&mut v2, v21);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
            0x2::balance::destroy_zero<T0>(v11);
            abort 69420
        };
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::fill_assets<T0, T1>(&mut arg0, v1, v2);
        let v22 = KRIYA_HANDLER{dummy_field: false};
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::uncorrelated::mark_processed<KRIYA_HANDLER>(&mut arg0, &v22);
        arg0
    }

    fun swap_optimal_on_cetus<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg8) {
            0x2::balance::value<T0>(&arg2)
        } else {
            0x2::balance::value<T1>(&arg3)
        };
        let (v1, v2) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::get_optimal_swap_amount_cetus<T0, T1>(arg0, arg4, arg5, v0, arg8, arg9);
        let v3 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::slippage_adjusted_sqrt_price(arg8, arg6, arg7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0));
        let (v4, v5) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::swap_on_cetus<T0, T1>(arg1, arg0, 0x2::coin::from_balance<T0>(arg2, arg11), 0x2::coin::from_balance<T1>(arg3, arg11), arg8, v2, v1, v3, arg10, arg11);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::assert_slippage(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), v3, arg8);
        (0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v5))
    }

    fun swap_optimal_on_kriya<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::slippage_adjusted_sqrt_price(arg8, arg6, arg7, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0));
        let v1 = if (arg8) {
            0x2::balance::value<T0>(&arg2)
        } else {
            0x2::balance::value<T1>(&arg3)
        };
        let (v2, v3) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::get_optimal_swap_amount_kriya<T0, T1>(arg0, arg4, arg5, v1, v0, arg8, arg9);
        let (v4, v5) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::swap<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg2, arg11), 0x2::coin::from_balance<T1>(arg3, arg11), arg8, v3, v2, v0, arg10, arg1, arg11);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::assert_slippage(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0), v0, arg8);
        (0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v5))
    }

    // decompiled from Move bytecode v6
}

