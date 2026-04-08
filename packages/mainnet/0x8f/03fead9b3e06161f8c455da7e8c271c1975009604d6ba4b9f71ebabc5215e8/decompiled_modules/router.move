module 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::router {
    public fun cleanup_orphan<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::global_config::GlobalConfig, arg1: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg2: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg3: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg4: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg1);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::global_config::assert_keeper(arg0, arg4);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg2, &arg3);
        let (v0, v1) = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::cleanup_orphan<T0, T1, T2>(arg2, arg3);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::store_orphan<T0, T1, T2>(arg2, v1, v0);
    }

    public fun set_sl_targets<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906836201568862223);
        validate_trigger_levels(&arg3, &arg4, &arg5, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1), false);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::num_tp_targets(arg1) > 0 || !0x1::vector::is_empty<u128>(&arg3), 13906836218748600333);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::set_sl_targets(arg1, 0x1::vector::empty<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>());
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg3)) {
            0x1::vector::push_back<u64>(&mut v0, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_target(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_sl(), *0x1::vector::borrow<u128>(&arg3, v1), *0x1::vector::borrow<u128>(&arg4, v1), *0x1::vector::borrow<u64>(&arg5, v1)));
            v1 = v1 + 1;
        };
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_targets_set(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_sl(), v0, arg3, arg4, arg5);
    }

    public fun set_tp_targets<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906836046950039567);
        validate_trigger_levels(&arg3, &arg4, &arg5, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1), true);
        assert!(!0x1::vector::is_empty<u128>(&arg3) || 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::num_sl_targets(arg1) > 0, 13906836064129777677);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::set_tp_targets(arg1, 0x1::vector::empty<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>());
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg3)) {
            0x1::vector::push_back<u64>(&mut v0, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_target(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp(), *0x1::vector::borrow<u128>(&arg3, v1), *0x1::vector::borrow<u128>(&arg4, v1), *0x1::vector::borrow<u64>(&arg5, v1)));
            v1 = v1 + 1;
        };
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_targets_set(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp(), v0, arg3, arg4, arg5);
    }

    public fun add_sl_target<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906835583093571599);
        let v0 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1);
        validate_single_execution_price(arg3, arg4, v0, false);
        validate_targets_monotonic(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::sl_targets(arg1), !v0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_target_added(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_target(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_sl(), arg3, arg4, arg5), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_sl(), arg3, arg4, arg5);
    }

    public fun add_tp_target<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906835449949585423);
        let v0 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1);
        validate_single_execution_price(arg3, arg4, v0, true);
        validate_targets_monotonic(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::tp_targets(arg1), v0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_target_added(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_target(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp(), arg3, arg4, arg5), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp(), arg3, arg4, arg5);
    }

    public fun begin_execute_order<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::global_config::GlobalConfig, arg1: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg3: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg4: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::ExecuteReceipt) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::global_config::assert_not_paused(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg1);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::global_config::assert_keeper(arg0, arg10);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_active<T0, T1, T2>(arg2), 13906836841518989327);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg2, arg3);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_market_matches(arg3, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::market_id(arg4));
        let v0 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::price_feed::extract_pair_price(arg7, arg8, arg9, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::max_price_age_seconds<T0, T1, T2>(arg2));
        let v1 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg3);
        let (v2, v3) = collect_triggered_targets(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::sl_targets(arg3), v0, !v1);
        let v4 = v2;
        let (v5, v6, v7) = if (!0x1::vector::is_empty<u64>(&v4)) {
            (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_sl(), v4, v3)
        } else {
            let (v8, v9) = collect_triggered_targets(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::tp_targets(arg3), v0, v1);
            let v10 = v8;
            assert!(!0x1::vector::is_empty<u64>(&v10), 13906836966073171985);
            (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp(), v10, v9)
        };
        let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg5, arg6);
        let (v12, v13, v14) = if (v1) {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T2>(v11)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(v11), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg5))
        } else {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T1>(v11)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T2>(v11), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T2>(arg5))
        };
        let v15 = (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator() as u128);
        let v16 = if (v5 == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_tp()) {
            0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::tp_targets(arg3)
        } else {
            0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::sl_targets(arg3)
        };
        (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::take_position_cap(arg3), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::new_receipt(0x2::object::id<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order>(arg3), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_position_id(arg3), v5, v6, v7, v7 == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator(), v0, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::target_execution_price(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(v16, 0)), (((v12 as u128) * (v7 as u128) / v15) as u64), (((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v13), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v14))) as u128) * (v7 as u128) / v15) as u64)))
    }

    public fun cancel_order<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg3: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(&arg2, &arg3);
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::cancel<T0, T1, T2>(arg1, arg2, arg3), 0x2::tx_context::sender(arg4));
    }

    public fun claim_orphan_position<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_orphan_claimed(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(&arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::position_id(&arg2), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::claim_orphan<T0, T1, T2>(arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun claim_settlement<T0>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        let v0 = 0x2::coin::from_balance<T0>(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::remove_settlement<T0>(arg1), arg3);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_settlement_claimed(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::position_id(arg2), 0x2::tx_context::sender(arg3), 0x2::coin::value<T0>(&v0), 0x1::type_name::with_defining_ids<T0>());
        v0
    }

    public fun cleanup_orphan_by_user<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg3: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(&arg2, &arg3);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_orphan_claimed(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(&arg3), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::position_id(&arg3), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap>(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::cleanup_and_claim_orphan<T0, T1, T2>(arg1, arg2, arg3), 0x2::tx_context::sender(arg4));
    }

    public fun close_order<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg3: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg1, &arg2);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(&arg2, &arg3);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::close<T0, T1, T2>(arg1, arg2, arg3);
    }

    fun collect_triggered_targets(arg0: &vector<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>, arg1: u128, arg2: bool) : (vector<u64>, u64) {
        let v0 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator();
        let v1 = v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0)) {
            let v4 = 0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0, v3);
            let v5 = arg2 && arg1 >= 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(v4) || arg1 <= 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(v4);
            if (!v5) {
                break
            };
            0x1::vector::push_back<u64>(&mut v2, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::target_id(v4));
            let v6 = v1 * (v0 - 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::close_ratio_bps(v4)) / v0;
            v1 = v6;
            if (v6 == 0) {
                break
            };
            v3 = v3 + 1;
        };
        (v2, v0 - v1)
    }

    fun compute_flat_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = (((arg0 as u128) * (arg1 as u128) / (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator() as u128)) as u64);
        if (arg2 > 0 && v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun create_order<T0, T1, T2, T3>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg2: &0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::Market, arg3: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg4: 0x2::object::ID, arg5: vector<u128>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: vector<u128>, arg10: vector<u64>, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_active<T0, T1, T2>(arg1), 13906835166481743887);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::market_id<T0, T1, T2>(arg1) == 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::market_id(arg2), 13906835170777104405);
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        let v1 = if (v0 == 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::base_token(arg2)) {
            true
        } else {
            assert!(v0 == 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::quote_token(arg2), 13906835205135663107);
            false
        };
        validate_trigger_levels(&arg5, &arg6, &arg7, v1, true);
        validate_trigger_levels(&arg8, &arg9, &arg10, v1, false);
        assert!(!0x1::vector::is_empty<u128>(&arg5) || !0x1::vector::is_empty<u128>(&arg8), 13906835226611154957);
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg5)) {
            0x1::vector::push_back<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(&mut v3, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::make_target(v2, *0x1::vector::borrow<u128>(&arg5, v4), *0x1::vector::borrow<u128>(&arg6, v4), *0x1::vector::borrow<u64>(&arg7, v4)));
            v2 = v2 + 1;
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>();
        v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg8)) {
            0x1::vector::push_back<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(&mut v5, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::make_target(v2, *0x1::vector::borrow<u128>(&arg8, v4), *0x1::vector::borrow<u128>(&arg9, v4), *0x1::vector::borrow<u64>(&arg10, v4)));
            v2 = v2 + 1;
            v4 = v4 + 1;
        };
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::store_order<T0, T1, T2>(arg1, arg3, arg4, 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::market::market_id(arg2), v1, arg11, v3, v5, v2, 0x2::clock::timestamp_ms(arg12), arg13)
    }

    public fun finalize_full_execute<T0, T1, T2, T3>(arg0: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::ExecuteReceipt, arg3: 0x2::coin::Coin<T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg0, arg1);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_receipt_matches_order(arg1, &arg2);
        let (v0, v1, v2, v3, _, v5, v6, v7, v8, v9) = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::destroy_receipt(arg2);
        let v10 = v3;
        assert!(v5, 13906837700512710675);
        validate_settlement(0x2::coin::value<T3>(&arg3), v9, v7, v8, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1));
        let v11 = 0x2::clock::timestamp_ms(arg4);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::complete(arg1, v11);
        let v12 = compute_flat_fee(0x2::coin::value<T3>(&arg3), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::fee_rate_bps<T0, T1, T2>(arg0), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::fee_cap<T0, T1, T2>(arg0));
        if (v12 > 0 && 0x2::coin::value<T3>(&arg3) >= v12) {
            0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::accumulate_fee<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut arg3, v12, arg5)));
        };
        let v13 = 0x2::coin::value<T3>(&arg3);
        let v14 = 0x1::type_name::with_defining_ids<T3>();
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_settlement<T3>(arg1, 0x2::coin::into_balance<T3>(arg3));
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::remove_triggered_targets(arg1, v2, &v10);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::push_execution(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::new_execution_record(v2, v10, v6, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator(), v13, v14, 0x2::tx_context::sender(arg5), v11));
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_full_executed(v0, v1, 0x2::tx_context::sender(arg5), v2, v10, v6, v12, v13, v14);
    }

    public fun finalize_partial_execute<T0, T1, T2, T3>(arg0: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderBook<T0, T1, T2>, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::ExecuteReceipt, arg3: 0x51bfedf86b5e18076f844bf0e1f82b14667bce59e2c38a8b5c8752ba3314bbd3::position::PositionCap, arg4: 0x2::coin::Coin<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_book_matches<T0, T1, T2>(arg0, arg1);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_receipt_matches_order(arg1, &arg2);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::destroy_receipt(arg2);
        let v10 = v3;
        assert!(!v5, 13906837442814672915);
        validate_settlement(0x2::coin::value<T3>(&arg4), v9, v7, v8, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1));
        let v11 = 0x2::clock::timestamp_ms(arg5);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::return_position_cap(arg1, arg3, v11);
        let v12 = compute_flat_fee(0x2::coin::value<T3>(&arg4), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::fee_rate_bps<T0, T1, T2>(arg0), 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::fee_cap<T0, T1, T2>(arg0));
        if (v12 > 0 && 0x2::coin::value<T3>(&arg4) >= v12) {
            0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::accumulate_fee<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut arg4, v12, arg6)));
        };
        let v13 = 0x2::coin::value<T3>(&arg4);
        let v14 = 0x1::type_name::with_defining_ids<T3>();
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::add_settlement<T3>(arg1, 0x2::coin::into_balance<T3>(arg4));
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::remove_triggered_targets(arg1, v2, &v10);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::push_execution(arg1, 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::new_execution_record(v2, v10, v6, v4, v13, v14, 0x2::tx_context::sender(arg6), v11));
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_partial_executed(v0, v1, 0x2::tx_context::sender(arg6), v2, v10, v4, v6, v12, v13, v14);
    }

    public fun remove_target<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906835930985922575);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::remove_target_by_id(arg1, arg3);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::num_tp_targets(arg1) > 0 || 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::num_sl_targets(arg1) > 0, 13906835961050562573);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_target_removed(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), arg3);
    }

    public fun update_target<T0, T1, T2>(arg0: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::Versioned, arg1: &mut 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Order, arg2: &0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::OrderCap, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::versioned::check_version(arg0);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::assert_order_cap_matches(arg1, arg2);
        assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status(arg1) == 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::status_active(), 13906835720532525071);
        let v0 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::is_long(arg1);
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::update_target_by_id(arg1, arg3, arg4, arg5, arg6);
        let v1 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::tp_targets(arg1);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(v1)) {
            if (0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::target_id(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(v1, v2)) == arg3) {
                validate_single_execution_price(arg4, arg5, v0, true);
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (v3) {
            validate_targets_monotonic(v1, v0);
        } else {
            validate_single_execution_price(arg4, arg5, v0, false);
            validate_targets_monotonic(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::sl_targets(arg1), !v0);
        };
        0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::emit_target_updated(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::order_id(arg2), arg3, arg4, arg5, arg6);
    }

    fun validate_settlement(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: bool) {
        let v0 = if (arg4) {
            let v1 = (arg1 as u128) * arg2 / 1000000000000000000;
            assert!(v1 >= (arg3 as u128), 13906837275309768705);
            ((v1 - (arg3 as u128)) as u64)
        } else {
            let v2 = (arg3 as u128) * arg2 / 1000000000000000000;
            assert!((arg1 as u128) >= v2, 13906837296784605185);
            (((arg1 as u128) - v2) as u64)
        };
        assert!(arg0 >= v0, 13906837309669507073);
    }

    fun validate_single_execution_price(arg0: u128, arg1: u128, arg2: bool, arg3: bool) {
        if (arg2 == arg3) {
            assert!(arg1 > arg0, 13906834814294949911);
        } else {
            assert!(arg1 < arg0, 13906834822884884503);
        };
    }

    fun validate_targets_monotonic(arg0: &vector<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>, arg1: bool) {
        let v0 = 0x1::vector::length<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            if (arg1) {
                assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0, v1)) > 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0, v1 - 1)), 13906834891603312647);
            } else {
                assert!(0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0, v1)) < 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::trigger_price(0x1::vector::borrow<0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::Target>(arg0, v1 - 1)), 13906834913078149127);
            };
            v1 = v1 + 1;
        };
    }

    fun validate_trigger_levels(arg0: &vector<u128>, arg1: &vector<u128>, arg2: &vector<u64>, arg3: bool, arg4: bool) {
        let v0 = 0x1::vector::length<u128>(arg0);
        if (v0 == 0) {
            return
        };
        assert!(v0 == 0x1::vector::length<u128>(arg1) && v0 == 0x1::vector::length<u64>(arg2), 13906834599545405445);
        let v1 = 0x8f03fead9b3e06161f8c455da7e8c271c1975009604d6ba4b9f71ebabc5215e8::order::bps_denominator();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg2, v2);
            assert!(v3 >= 1 && v3 <= v1, 13906834625315209221);
            if (v2 == v0 - 1) {
                assert!(v3 == v1, 13906834633905405961);
            } else {
                assert!(v3 < v1, 13906834642495471627);
            };
            if (arg3 == arg4) {
                assert!(*0x1::vector::borrow<u128>(arg1, v2) > *0x1::vector::borrow<u128>(arg0, v2), 13906834685445931031);
            } else {
                assert!(*0x1::vector::borrow<u128>(arg1, v2) < *0x1::vector::borrow<u128>(arg0, v2), 13906834698330832919);
            };
            v2 = v2 + 1;
        };
        v2 = 1;
        while (v2 < v0) {
            if (arg3 == arg4) {
                assert!(*0x1::vector::borrow<u128>(arg0, v2) > *0x1::vector::borrow<u128>(arg0, v2 - 1), 13906834745574424583);
            } else {
                assert!(*0x1::vector::borrow<u128>(arg0, v2) < *0x1::vector::borrow<u128>(arg0, v2 - 1), 13906834754164359175);
            };
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

