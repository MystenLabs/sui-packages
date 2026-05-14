module 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::router {
    public fun borrow<T0, T1>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::config::GlobalConfig, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg6: u64, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::versioned::Versioned, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::borrow<T0, T1>(arg3, arg4, arg5, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun cleanup_orphan<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::GlobalConfig, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg2: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg4: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg1);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::assert_keeper(arg0, arg4);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg2, &arg3);
        let (v0, v1) = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::cleanup_orphan<T0, T1, T2>(arg2, arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::store_orphan<T0, T1, T2>(arg2, v1, v0);
    }

    public fun share_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        validate_order_invariants(&arg2, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(&arg2));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::share_order<T0, T1, T2>(arg1, arg2);
    }

    public fun add_sl_level<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: u128, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status(arg1) == 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status_active(), 13906836764209053703);
        validate_slippage_bps(arg4);
        validate_close_ratio_range(arg5);
        validate_levels_monotonic(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg1), !0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_tpsl_level_added(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_tpsl_level(arg1, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_sl(), arg3, arg4, arg5, arg6), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_sl(), arg3, arg4, arg5, arg6);
    }

    public fun add_tp_level<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: u128, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status(arg1) == 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status_active(), 13906836605295263751);
        validate_slippage_bps(arg4);
        validate_close_ratio_range(arg5);
        validate_levels_monotonic(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg1), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_tpsl_level_added(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_tpsl_level(arg1, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_tp(), arg3, arg4, arg5, arg6), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_tp(), arg3, arg4, arg5, arg6);
    }

    public fun begin_execute_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::GlobalConfig, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg3: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg4: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::ExecuteReceipt) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::assert_not_paused(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg1);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::assert_keeper(arg0, arg9);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_initialized<T0, T1, T2>(arg2);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_active<T0, T1, T2>(arg2), 13906839031951785991);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg2, arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_market_matches(arg3, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::market_id(arg4));
        let v0 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::price_feed::extract_pair_price(arg6, arg7, arg8, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::max_price_age_seconds<T0, T1, T2>(arg2));
        let v1 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg3);
        let v2 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_position_id(arg3);
        validate_order_invariants(arg3, v1);
        let (v3, v4) = collect_triggered_levels(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg3), v0, !v1);
        let v5 = v3;
        let (v6, v7, v8) = if (!0x1::vector::is_empty<u64>(&v5)) {
            (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_sl(), v5, v4)
        } else {
            let (v9, v10) = collect_triggered_levels(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg3), v0, v1);
            let v11 = v9;
            assert!(!0x1::vector::is_empty<u64>(&v11), 13906839199455641609);
            (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_tp(), v11, v10)
        };
        let v12 = v7;
        let v13 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator() - 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::executed_ratio_sum(arg3, v6);
        let v14 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg5, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::position_obligation_id<T0>(arg4, v2));
        let (v15, v16, v17) = if (v1) {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T2>(v14)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(v14), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg5))
        } else {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T1>(v14)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T2>(v14), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T2>(arg5))
        };
        let v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v16), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v17))), v8, v13);
        let v19 = v18 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v18, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::close_fee_rate(arg4), 1000000);
        let v20 = if (v6 == 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_tp()) {
            0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg3)
        } else {
            0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg3)
        };
        let v21 = 0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(v20, 0);
        let (v22, v23) = if (v1) {
            (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::price_feed::extract_single_usd_price_1e18(arg6, arg8, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::max_price_age_seconds<T0, T1, T2>(arg2)), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::base_decimals<T0, T1, T2>(arg2))
        } else {
            (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::price_feed::extract_single_usd_price_1e18(arg7, arg8, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::max_price_age_seconds<T0, T1, T2>(arg2)), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::quote_decimals<T0, T1, T2>(arg2))
        };
        (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::take_position_cap(arg3), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::new_receipt(0x2::object::id<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order>(arg3), v2, v6, *0x1::vector::borrow<u64>(&v12, 0), v8, v8 == v13, v0, derive_execution_price(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(v21), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::level_slippage_bps(v21), v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v15, v8, v13), v19, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::target_is_base(v21), compute_flat_fee(v19, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::fee_rate_bps<T0, T1, T2>(arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::fee_cap_usd_1e6<T0, T1, T2>(arg2), v22, v23)))
    }

    public fun cancel_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(&arg2, &arg3);
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::cancel<T0, T1, T2>(arg1, arg2, arg3), 0x2::tx_context::sender(arg4));
    }

    public fun cancel_order_and_return_cap<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(&arg2, &arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::cancel<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun claim_orphan_position<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_orphan_claimed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(&arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::position_id(&arg2), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::claim_orphan<T0, T1, T2>(arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun claim_orphan_position_and_return_cap<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x2::tx_context::TxContext) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_orphan_claimed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(&arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::position_id(&arg2), 0x2::tx_context::sender(arg3));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::claim_orphan<T0, T1, T2>(arg1, arg2)
    }

    public fun claim_rewards<T0, T1>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::config::GlobalConfig, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::versioned::Versioned, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::claim_rewards<T0, T1>(arg3, arg4, arg5, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun claim_settlement<T0>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        let v0 = 0x2::coin::from_balance<T0>(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::remove_settlement<T0>(arg1), arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_settlement_claimed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(arg2), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::position_id(arg2), 0x2::tx_context::sender(arg3), 0x2::coin::value<T0>(&v0), 0x1::type_name::with_defining_ids<T0>());
        v0
    }

    public fun cleanup_orphan_by_user<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(&arg2, &arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_orphan_claimed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(&arg3), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::position_id(&arg3), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::cleanup_and_claim_orphan<T0, T1, T2>(arg1, arg2, arg3), 0x2::tx_context::sender(arg4));
    }

    public fun cleanup_orphan_by_user_and_return_cap<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg4: &0x2::tx_context::TxContext) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(&arg2, &arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_orphan_claimed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(&arg3), 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::position_id(&arg3), 0x2::tx_context::sender(arg4));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::cleanup_and_claim_orphan<T0, T1, T2>(arg1, arg2, arg3)
    }

    public fun close_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(&arg2, &arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::close<T0, T1, T2>(arg1, arg2, arg3);
    }

    fun collect_triggered_levels(arg0: &vector<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>, arg1: u128, arg2: bool) : (vector<u64>, u64) {
        if (0x1::vector::is_empty<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0)) {
            return (vector[], 0)
        };
        let v0 = 0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, 0);
        let v1 = arg2 && arg1 >= 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(v0) || arg1 <= 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(v0);
        if (!v1) {
            return (vector[], 0)
        };
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::level_id(v0));
        (v2, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::close_ratio_bps(v0))
    }

    public fun compound_debt<T0>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg5: u64, arg6: u64) : u64 {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::compound_debt<T0>(arg3, arg4, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg5, arg6)
    }

    fun compute_flat_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u8) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg0, arg1, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator());
        if (arg2 == 0) {
            return v0
        };
        if (arg3 == 0) {
            return v0
        };
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg2 as u128), pow10((arg4 as u64) + 12), arg3);
        let v2 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        if (v0 > v2) {
            v2
        } else {
            v0
        }
    }

    public fun create_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg2: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_initialized<T0, T1, T2>(arg1);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_active<T0, T1, T2>(arg1), 13906836334712324103);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::new_order<T0, T1, T2>(arg1, arg2, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::market_id<T0, T1, T2>(arg1), arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public fun deposit<T0, T1>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::config::GlobalConfig, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::deposit<T0, T1>(arg3, arg4, arg5, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg6, arg7, arg8, arg9, arg10);
    }

    fun derive_execution_price(arg0: u128, arg1: u64, arg2: bool) : u128 {
        let v0 = (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator() as u128);
        if (arg2) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, v0 - (arg1 as u128), v0)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, v0 + (arg1 as u128), v0)
        }
    }

    public fun finalize_full_execute<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::ExecuteReceipt, arg3: 0x2::coin::Coin<T3>, arg4: 0x2::coin::Coin<T4>, arg5: 0x2::coin::Coin<T5>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg0, arg1);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_receipt_matches_order(arg1, &arg2);
        let (v0, v1, v2, v3, _, v5, v6, v7, v8, v9, _, v11) = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::destroy_receipt(arg2);
        assert!(v5, 13906840230247923723);
        let v12 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1);
        let v13 = if (v12) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T2>()
        };
        let v14 = if (v12) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v13, 13906840294672826385);
        assert!(0x1::type_name::with_defining_ids<T4>() == v13, 13906840303262892051);
        assert!(0x1::type_name::with_defining_ids<T5>() == v14, 13906840307557728273);
        assert!(0x2::coin::value<T4>(&arg4) == v11, 13906840311852957717);
        validate_settlement<T0, T1, T2>(arg0, 0x2::coin::value<T3>(&arg3), 0x2::coin::value<T5>(&arg5), v9, v11, v7, v8, v12);
        let v15 = 0x2::clock::timestamp_ms(arg6);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::complete(arg1, v15);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::accumulate_fee<T0, T1, T2, T4>(arg0, 0x2::coin::into_balance<T4>(arg4));
        let v16 = 0x2::coin::value<T3>(&arg3);
        let v17 = 0x1::type_name::with_defining_ids<T3>();
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_settlement<T3>(arg1, 0x2::coin::into_balance<T3>(arg3));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_settlement<T5>(arg1, 0x2::coin::into_balance<T5>(arg5));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::clear_all_levels(arg1);
        let v18 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v18, v3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::push_execution(arg1, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::new_execution_record(v2, v18, v6, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator(), v16, v17, 0x2::tx_context::sender(arg7), v15));
        let v19 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v19, v3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_full_executed(v0, v1, 0x2::tx_context::sender(arg7), v2, v19, v6, v11, v16, v17);
    }

    public fun finalize_partial_execute<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::ExecuteReceipt, arg3: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg4: 0x2::coin::Coin<T3>, arg5: 0x2::coin::Coin<T4>, arg6: 0x2::coin::Coin<T5>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_book_matches<T0, T1, T2>(arg0, arg1);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_receipt_matches_order(arg1, &arg2);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, _, v11) = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::destroy_receipt(arg2);
        assert!(!v5, 13906839856585768971);
        let v12 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1);
        let v13 = if (v12) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T2>()
        };
        let v14 = if (v12) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        assert!(0x1::type_name::with_defining_ids<T3>() == v13, 13906839925305638929);
        assert!(0x1::type_name::with_defining_ids<T4>() == v13, 13906839933895704595);
        assert!(0x1::type_name::with_defining_ids<T5>() == v14, 13906839938190540817);
        assert!(0x2::coin::value<T4>(&arg5) == v11, 13906839942485770261);
        validate_settlement<T0, T1, T2>(arg0, 0x2::coin::value<T3>(&arg4), 0x2::coin::value<T5>(&arg6), v9, v11, v7, v8, v12);
        let v15 = 0x2::clock::timestamp_ms(arg7);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::return_position_cap(arg1, arg3, v15);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::accumulate_fee<T0, T1, T2, T4>(arg0, 0x2::coin::into_balance<T4>(arg5));
        let v16 = 0x2::coin::value<T3>(&arg4);
        let v17 = 0x1::type_name::with_defining_ids<T3>();
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_settlement<T3>(arg1, 0x2::coin::into_balance<T3>(arg4));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::add_settlement<T5>(arg1, 0x2::coin::into_balance<T5>(arg6));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::remove_triggered_level(arg1, v2, v3);
        let v18 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v18, v3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::push_execution(arg1, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::new_execution_record(v2, v18, v6, v4, v16, v17, 0x2::tx_context::sender(arg8), v15));
        let v19 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v19, v3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_partial_executed(v0, v1, 0x2::tx_context::sender(arg8), v2, v19, v4, v6, v11, v16, v17);
    }

    public fun park_cap_post_full_close<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::GlobalConfig, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg2: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg3: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg4: &0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg1);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::global_config::assert_keeper(arg0, arg4);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::park_cap_post_completion(arg2, arg3);
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun reclaim_cap_from_completed_order<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_cap_reclaimed(arg1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::take_parked_cap(arg1), 0x2::tx_context::sender(arg3));
    }

    public fun reclaim_cap_from_completed_order_and_return_cap<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x2::tx_context::TxContext) : 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_cap_reclaimed(arg1, 0x2::tx_context::sender(arg3));
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::take_parked_cap(arg1)
    }

    public fun remove_tpsl_level<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status(arg1) == 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status_active(), 13906837137871208455);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::remove_tpsl_level_by_id(arg1, arg3);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_tpsl_level_removed(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(arg2), arg3);
    }

    public fun repay<T0, T1>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::config::GlobalConfig, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg6: &mut 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::repay<T0, T1>(arg3, arg4, arg5, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg6, arg7, arg8, arg9, arg10);
    }

    public fun update_tpsl_level<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &mut 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status(arg1) == 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::status_active(), 13906836931712778247);
        validate_slippage_bps(arg5);
        validate_close_ratio_range(arg6);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::update_tpsl_level_by_id(arg1, arg3, arg4, arg5, arg6, arg7);
        let v0 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg1);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(v0)) {
            if (0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::level_id(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(v0, v1)) == arg3) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (v2) {
            validate_levels_monotonic(v0, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1));
        } else {
            validate_levels_monotonic(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg1), !0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::is_long(arg1));
        };
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::emit_tpsl_level_updated(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::order_id(arg2), arg3, arg4, arg5, arg6, arg7);
    }

    fun validate_close_ratio_range(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator(), 13906834908783706127);
    }

    fun validate_close_ratios(arg0: &vector<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>, arg1: u64) {
        let v0 = 0x1::vector::length<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0);
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::close_ratio_bps(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, v2));
            assert!(v3 >= 1 && v3 <= 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator(), 13906835011862921231);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(v1 == arg1, 13906835029042135045);
    }

    fun validate_levels_monotonic(arg0: &vector<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>, arg1: bool) {
        let v0 = 0x1::vector::length<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            if (arg1) {
                assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, v1)) > 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, v1 - 1)), 13906835183660826627);
            } else {
                assert!(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, v1)) < 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_price(0x1::vector::borrow<0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::TpslLevel>(arg0, v1 - 1)), 13906835205135663107);
            };
            v1 = v1 + 1;
        };
    }

    fun validate_order_invariants(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg1: bool) {
        validate_levels_monotonic(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg0), arg1);
        validate_levels_monotonic(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg0), !arg1);
        let v0 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator();
        validate_close_ratios(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::tp_levels(arg0), v0 - 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::executed_ratio_sum(arg0, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_tp()));
        validate_close_ratios(0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::sl_levels(arg0), v0 - 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::executed_ratio_sum(arg0, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::trigger_sl()));
    }

    fun validate_settlement<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: bool) {
        assert!(arg3 >= arg4, 13906835789251084289);
        let v0 = whole_to_native_price<T0, T1, T2>(arg0, arg5);
        let (v1, v2) = if (arg7) {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(((arg3 - arg4) as u128), v0, 1000000000000000000), (arg6 as u128))
        } else {
            (((arg3 - arg4) as u128), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg6 as u128), v0, 1000000000000000000))
        };
        let v3 = if (v1 >= v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = if (arg7) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(v3, 1000000000000000000, v0)
        } else {
            v3
        };
        let v5 = if (arg7) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg2 as u128), 1000000000000000000, v0)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg2 as u128), v0, 1000000000000000000)
        };
        assert!((arg1 as u128) + v5 >= v4, 13906836064128991233);
    }

    fun validate_slippage_bps(arg0: u64) {
        assert!(arg0 < 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::bps_denominator(), 13906834767049654285);
    }

    fun whole_to_native_price<T0, T1, T2>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderBook<T0, T1, T2>, arg1: u128) : u128 {
        let v0 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::base_decimals<T0, T1, T2>(arg0);
        let v1 = 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::quote_decimals<T0, T1, T2>(arg0);
        if (v1 >= v0) {
            arg1 * pow10(((v1 - v0) as u64))
        } else {
            arg1 / pow10(((v0 - v1) as u64))
        }
    }

    public fun withdraw<T0, T1>(arg0: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::Versioned, arg1: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::Order, arg2: &0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::OrderCap, arg3: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::config::GlobalConfig, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg6: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::versioned::Versioned, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::versioned::check_version(arg0);
        0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::assert_order_cap_matches(arg1, arg2);
        0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::router::withdraw<T0, T1>(arg3, arg4, arg5, 0x4c29c419f59adb7193ac87c7934c5fe396bf0b3c4b2f182cb9a1636551e29936::order::borrow_position_cap(arg1), arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    // decompiled from Move bytecode v7
}

