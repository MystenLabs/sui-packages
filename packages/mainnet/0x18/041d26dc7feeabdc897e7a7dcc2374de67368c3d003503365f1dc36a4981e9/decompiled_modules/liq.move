module 0x18041d26dc7feeabdc897e7a7dcc2374de67368c3d003503365f1dc36a4981e9::liq {
    struct NativeFlashDiag has copy, drop {
        flash_amount: u64,
        flash_fee: u64,
        leftover_debt: u64,
        coll_seized: u64,
        debt_from_coll: u64,
        repay_exact: u64,
        profit: u64,
        variant: u8,
    }

    struct NativeFlash2HopDiag has copy, drop {
        flash_amount: u64,
        flash_fee: u64,
        leftover_debt: u64,
        coll_seized: u64,
        mid_received: u64,
        debt_from_coll: u64,
        repay_exact: u64,
        profit: u64,
        variant: u8,
    }

    fun finish_native_2hop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 >= arg10, 1);
        assert!(v0 >= arg10 + arg11, 0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, arg10), arg13), arg2, arg13);
        let v1 = 0x2::balance::value<T0>(&arg3);
        let v2 = NativeFlash2HopDiag{
            flash_amount   : arg4,
            flash_fee      : arg5,
            leftover_debt  : arg6,
            coll_seized    : arg7,
            mid_received   : arg8,
            debt_from_coll : arg9,
            repay_exact    : arg10,
            profit         : v1,
            variant        : arg12,
        };
        0x2::event::emit<NativeFlash2HopDiag>(v2);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg13), 0x2::tx_context::sender(arg13));
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    fun finish_native_flash<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 >= arg9, 1);
        assert!(v0 >= arg9 + arg10, 0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, arg9), arg12), arg2, arg12);
        let v1 = 0x2::balance::value<T0>(&arg3);
        let v2 = NativeFlashDiag{
            flash_amount   : arg4,
            flash_fee      : arg5,
            leftover_debt  : arg6,
            coll_seized    : arg7,
            debt_from_coll : arg8,
            repay_exact    : arg9,
            profit         : v1,
            variant        : arg11,
        };
        0x2::event::emit<NativeFlashDiag>(v2);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public fun flash_liq_native_2hop_cA_mA_keeper_ride<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg8, arg13);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg5, arg1, v0, arg6, arg7, arg12, arg13);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        assert!(v8 > 0, 1);
        let v9 = swap_all_a_for_b<T1, T2>(arg2, arg3, 0x2::coin::into_balance<T1>(v6), arg9, arg12);
        let v10 = swap_all_a_for_b<T2, T0>(arg2, arg4, v9, arg10, arg12);
        0x2::balance::join<T0>(&mut v7, v10);
        finish_native_2hop<T0>(arg0, arg1, v2, v7, arg8, v3, 0x2::balance::value<T0>(&v7), v8, 0x2::balance::value<T2>(&v9), 0x2::balance::value<T0>(&v10), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg11, 0, arg13);
    }

    public fun flash_liq_native_2hop_cA_mB_keeper_ride<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg8, arg13);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg5, arg1, v0, arg6, arg7, arg12, arg13);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        assert!(v8 > 0, 1);
        let v9 = swap_all_a_for_b<T1, T2>(arg2, arg3, 0x2::coin::into_balance<T1>(v6), arg9, arg12);
        let v10 = swap_all_b_for_a<T0, T2>(arg2, arg4, v9, arg10, arg12);
        0x2::balance::join<T0>(&mut v7, v10);
        finish_native_2hop<T0>(arg0, arg1, v2, v7, arg8, v3, 0x2::balance::value<T0>(&v7), v8, 0x2::balance::value<T2>(&v9), 0x2::balance::value<T0>(&v10), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg11, 1, arg13);
    }

    public fun flash_liq_native_2hop_cB_mA_keeper_ride<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg8, arg13);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg5, arg1, v0, arg6, arg7, arg12, arg13);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        assert!(v8 > 0, 1);
        let v9 = swap_all_b_for_a<T2, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v6), arg9, arg12);
        let v10 = swap_all_a_for_b<T2, T0>(arg2, arg4, v9, arg10, arg12);
        0x2::balance::join<T0>(&mut v7, v10);
        finish_native_2hop<T0>(arg0, arg1, v2, v7, arg8, v3, 0x2::balance::value<T0>(&v7), v8, 0x2::balance::value<T2>(&v9), 0x2::balance::value<T0>(&v10), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg11, 2, arg13);
    }

    public fun flash_liq_native_2hop_cB_mB_keeper_ride<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg8, arg13);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg5, arg1, v0, arg6, arg7, arg12, arg13);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        assert!(v8 > 0, 1);
        let v9 = swap_all_b_for_a<T2, T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v6), arg9, arg12);
        let v10 = swap_all_b_for_a<T0, T2>(arg2, arg4, v9, arg10, arg12);
        0x2::balance::join<T0>(&mut v7, v10);
        finish_native_2hop<T0>(arg0, arg1, v2, v7, arg8, v3, 0x2::balance::value<T0>(&v7), v8, 0x2::balance::value<T2>(&v9), 0x2::balance::value<T0>(&v10), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg11, 3, arg13);
    }

    public fun flash_liq_native_a_full_consolidated_r2<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::pyth_registry::PythRegistry, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg12: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg0, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg17), arg16), arg3, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg17), arg16));
        let v1 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg5);
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T0>(&mut v1, arg0, arg2, arg6, arg16);
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg5, v1, arg16);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T1>(arg5);
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T1>(&mut v2, arg0, arg3, arg6, arg16);
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T1>(arg5, v2, arg16);
        native_liquidate_swap_a<T0, T1>(arg7, arg8, arg9, arg10, arg11, arg12, arg5, arg13, arg14, arg15, arg16, arg17);
    }

    public fun flash_liq_native_a_keeper_ride<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        native_liquidate_swap_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun flash_liq_native_a_with_pyth_push<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg0, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg16), arg15), arg3, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg16), arg15));
        native_liquidate_swap_a<T0, T1>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun flash_liq_native_b_full_consolidated_r2<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::pyth_registry::PythRegistry, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg12: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg0, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg17), arg16), arg3, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg17), arg16));
        let v1 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg5);
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T0>(&mut v1, arg0, arg2, arg6, arg16);
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg5, v1, arg16);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T1>(arg5);
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T1>(&mut v2, arg0, arg3, arg6, arg16);
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T1>(arg5, v2, arg16);
        native_liquidate_swap_b<T0, T1>(arg7, arg8, arg9, arg10, arg11, arg12, arg5, arg13, arg14, arg15, arg16, arg17);
    }

    public fun flash_liq_native_b_keeper_ride<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        native_liquidate_swap_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun flash_liq_native_b_with_pyth_push<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg0, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg0, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg16), arg15), arg3, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg16), arg15));
        native_liquidate_swap_b<T0, T1>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun flash_liq_scallop_suihub_bf<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, false, false, arg9, 79226673515401279992447579055, arg11);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg6, arg1, 0x2::coin::from_balance<T0>(v0, arg12), arg7, arg8, arg11, arg12);
        let v7 = v5;
        if (0x2::coin::value<T0>(&v7) == 0) {
            0x2::coin::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg12));
        };
        let v8 = 0x2::coin::into_balance<T1>(v6);
        let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, 0x2::sui::SUI>(arg11, arg4, arg5, v8, 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::balance::value<T1>(&v8), 0, 4295048017);
        let v11 = v9;
        if (0x2::balance::value<T1>(&v11) == 0) {
            0x2::balance::destroy_zero<T1>(v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), 0x2::tx_context::sender(arg12));
        };
        let v12 = v10;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v12) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v12, v4), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun flash_liq_scallop_suihub_mm<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, false, false, arg9, 79226673515401279992447579055, arg11);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg6, arg1, 0x2::coin::from_balance<T0>(v0, arg12), arg7, arg8, arg11, arg12);
        let v7 = v5;
        if (0x2::coin::value<T0>(&v7) == 0) {
            0x2::coin::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg12));
        };
        let v8 = 0x2::coin::into_balance<T1>(v6);
        let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, 0x2::sui::SUI>(arg4, true, true, 0x2::balance::value<T1>(&v8), 4295048016, arg11, arg5, arg12);
        let v12 = v11;
        0x2::balance::destroy_zero<T1>(v9);
        let (v13, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, 0x2::sui::SUI>(arg4, v12, 0x2::balance::split<T1>(&mut v8, v13), 0x2::balance::zero<0x2::sui::SUI>(), arg5, arg12);
        if (0x2::balance::value<T1>(&v8) == 0) {
            0x2::balance::destroy_zero<T1>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg12), 0x2::tx_context::sender(arg12));
        };
        let v15 = v10;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v15) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v15, v4), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg12), 0x2::tx_context::sender(arg12));
    }

    fun native_liquidate_swap_a<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg7, arg11);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg4, arg1, v0, arg5, arg6, arg10, arg11);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        let v9 = 0x2::coin::into_balance<T1>(v6);
        let v10 = 0;
        if (v8 > 0) {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, v8, arg8, arg10);
            let v14 = v13;
            let v15 = v11;
            0x2::balance::destroy_zero<T1>(v12);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14)), v14);
            v10 = 0x2::balance::value<T0>(&v15);
            0x2::balance::join<T0>(&mut v7, v15);
        };
        if (0x2::balance::value<T1>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T1>(v9);
        };
        finish_native_flash<T0>(arg0, arg1, v2, v7, arg7, v3, 0x2::balance::value<T0>(&v7), v8, v10, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg9, 0, arg11);
    }

    fun native_liquidate_swap_b<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg1, arg7, arg11);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg4, arg1, v0, arg5, arg6, arg10, arg11);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(v4);
        let v8 = 0x2::coin::value<T1>(&v6);
        let v9 = 0x2::coin::into_balance<T1>(v6);
        let v10 = 0;
        if (v8 > 0) {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, true, v8, arg8, arg10);
            let v14 = v13;
            let v15 = v12;
            0x2::balance::destroy_zero<T1>(v11);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(&mut v9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v14)), 0x2::balance::zero<T0>(), v14);
            v10 = 0x2::balance::value<T0>(&v15);
            0x2::balance::join<T0>(&mut v7, v15);
        };
        if (0x2::balance::value<T1>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T1>(v9);
        };
        finish_native_flash<T0>(arg0, arg1, v2, v7, arg7, v3, 0x2::balance::value<T0>(&v7), v8, v10, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v2) + v3, arg9, 1, arg11);
    }

    fun swap_all_a_for_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(arg2);
        v1
    }

    fun swap_all_b_for_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::destroy_zero<T1>(arg2);
        v0
    }

    // decompiled from Move bytecode v7
}

