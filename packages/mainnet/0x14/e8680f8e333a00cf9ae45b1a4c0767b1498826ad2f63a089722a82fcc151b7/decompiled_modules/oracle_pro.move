module 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_pro {
    struct PriceRegulation has copy, drop {
        level: u8,
        config_address: address,
        feed_address: address,
        price_diff_threshold1: u64,
        price_diff_threshold2: u64,
        current_time: u64,
        diff_threshold2_timer: u64,
        max_duration_within_thresholds: u64,
        primary_price: u256,
        secondary_price: u256,
    }

    struct InvalidOraclePrice has copy, drop {
        config_address: address,
        feed_address: address,
        provider: 0x1::ascii::String,
        price: u256,
        maximum_effective_price: u256,
        minimum_effective_price: u256,
        maximum_allowed_span: u64,
        current_timestamp: u64,
        historical_price_ttl: u64,
        historical_price: u256,
        historical_updated_time: u64,
    }

    struct OracleUnavailable has copy, drop {
        type: u8,
        config_address: address,
        feed_address: address,
        provider: 0x1::ascii::String,
        price: u256,
        updated_time: u64,
    }

    public fun get_price_from_adaptor(arg0: &0x2::clock::Clock, arg1: &0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::OracleProviderConfig, arg2: u8, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u256, u64) {
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::get_provider_from_oracle_provider_config(arg1);
        if (v0 == 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::supra_provider()) {
            return 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::adaptor_supra::get_price_to_target_decimal(arg3, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::adaptor_supra::vector_to_pair_id(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_pair_id_from_oracle_provider_config(arg1)), arg2)
        };
        assert!(v0 == 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::pyth_provider(), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::invalid_oracle_provider());
        assert!(0x2::address::from_bytes(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::adaptor_pyth::get_identifier_to_vector(arg5)) == 0x2::address::from_bytes(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_pair_id_from_oracle_provider_config(arg1)), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::pair_not_match());
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::adaptor_pyth::get_price_unsafe_to_target_decimal(arg5, arg2)
    }

    public fun update_prices(arg0: &0x2::clock::Clock, arg1: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::OracleConfig, arg2: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_vec_feeds(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            update_single_price(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    public fun update_prices_for_testing(arg0: &0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::OracleConfig, arg3: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::PriceOracle, arg4: &vector<u256>, arg5: &vector<u64>, arg6: &vector<u256>, arg7: &vector<u64>) {
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_vec_feeds(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            update_single_price_for_testing_non_abort(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u256>(arg4, v1), *0x1::vector::borrow<u64>(arg5, v1), *0x1::vector::borrow<u256>(arg6, v1), *0x1::vector::borrow<u64>(arg7, v1), *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    public fun update_single_price(arg0: &0x2::clock::Clock, arg1: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::OracleConfig, arg2: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address) {
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::version_verification(arg1);
        assert!(!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_paused(arg1), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::paused());
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_config_id_to_address(arg1);
        let v1 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_feed_mut(arg1, arg6);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_price_feed_enable(v1)) {
            return
        };
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_timestamp_diff_from_feed(v1);
        let v4 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_oracle_id_from_feed(v1);
        let v5 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::decimal(arg2, v4);
        let v6 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_primary_oracle_provider(v1);
        if (0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::is_empty(v6)) {
            return
        };
        let v7 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_primary_oracle_provider_config(v1);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::is_oracle_provider_config_enable(v7)) {
            return
        };
        let (v8, v9) = get_price_from_adaptor(arg0, v7, v5, arg3, arg4, arg5);
        let v10 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v2, v9, v3);
        let v11 = false;
        let v12 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_secondary_oracle_available(v1);
        let v13 = 0;
        let v14 = 0;
        if (v12) {
            let (v15, v16) = get_price_from_adaptor(arg0, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_secondary_source_config(v1), v5, arg3, arg4, arg5);
            v14 = v16;
            v13 = v15;
            v11 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v2, v16, v3);
        };
        let v17 = false;
        let v18 = v8;
        if (v10 && v11) {
            let v19 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold1_from_feed(v1);
            let v20 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold2_from_feed(v1);
            let v21 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_duration_within_thresholds_from_feed(v1);
            let v22 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_diff_threshold2_timer_from_feed(v1);
            let v23 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_difference(v8, v13, v19, v20, v2, v21, v22);
            if (v23 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_normal()) {
                let v24 = PriceRegulation{
                    level                          : v23,
                    config_address                 : v0,
                    feed_address                   : arg6,
                    price_diff_threshold1          : v19,
                    price_diff_threshold2          : v20,
                    current_time                   : v2,
                    diff_threshold2_timer          : v22,
                    max_duration_within_thresholds : v21,
                    primary_price                  : v8,
                    secondary_price                : v13,
                };
                0x2::event::emit<PriceRegulation>(v24);
                if (v23 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_warning()) {
                    return
                };
                v17 = true;
            };
        } else if (v10) {
            if (v12) {
                let v25 = OracleUnavailable{
                    type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::secondary_type(),
                    config_address : v0,
                    feed_address   : arg6,
                    provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_secondary_oracle_provider(v1)),
                    price          : v13,
                    updated_time   : v14,
                };
                0x2::event::emit<OracleUnavailable>(v25);
            };
        } else if (v11) {
            let v26 = OracleUnavailable{
                type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::primary_type(),
                config_address : v0,
                feed_address   : arg6,
                provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v6),
                price          : v8,
                updated_time   : v9,
            };
            0x2::event::emit<OracleUnavailable>(v26);
            v18 = v13;
        } else {
            let v27 = OracleUnavailable{
                type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::both_type(),
                config_address : v0,
                feed_address   : arg6,
                provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v6),
                price          : v8,
                updated_time   : v9,
            };
            0x2::event::emit<OracleUnavailable>(v27);
            return
        };
        let v28 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_effective_price_from_feed(v1);
        let v29 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_minimum_effective_price_from_feed(v1);
        let v30 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_allowed_span_percentage_from_feed(v1);
        let v31 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_historical_price_ttl(v1);
        let (v32, v33) = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_history_price_data_from_feed(v1);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_range_and_history(v18, v28, v29, v30, v2, v31, v32, v33)) {
            let v34 = InvalidOraclePrice{
                config_address          : v0,
                feed_address            : arg6,
                provider                : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v6),
                price                   : v18,
                maximum_effective_price : v28,
                minimum_effective_price : v29,
                maximum_allowed_span    : v30,
                current_timestamp       : v2,
                historical_price_ttl    : v31,
                historical_price        : v32,
                historical_updated_time : v33,
            };
            0x2::event::emit<InvalidOraclePrice>(v34);
            return
        };
        if (v17) {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::start_or_continue_diff_threshold2_timer(v1, v2);
        } else {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::reset_diff_threshold2_timer(v1);
        };
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::keep_history_update(v1, v18, 0x2::clock::timestamp_ms(arg0));
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::update_price(arg0, arg2, v4, v18);
    }

    public fun update_single_price_for_testing(arg0: &0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::OracleConfig, arg3: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::PriceOracle, arg4: u256, arg5: u64, arg6: u256, arg7: u64, arg8: address) {
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::version_verification(arg2);
        assert!(!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_paused(arg2), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::paused());
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_config_id_to_address(arg2);
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_feed_mut(arg2, arg8);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_price_feed_enable(v0)) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_timestamp_diff_from_feed(v0);
        if (0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::is_empty(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_primary_oracle_provider(v0))) {
            abort 1
        };
        let v3 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v1, arg5, v2);
        let v4 = false;
        let v5 = 0;
        if (0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_secondary_oracle_available(v0)) {
            v5 = arg6;
            v4 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v1, arg7, v2);
        };
        let v6 = false;
        let v7 = arg4;
        if (v3 && v4) {
            let v8 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_difference(arg4, v5, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold1_from_feed(v0), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold2_from_feed(v0), v1, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_duration_within_thresholds_from_feed(v0), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_diff_threshold2_timer_from_feed(v0));
            if (v8 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_normal()) {
                if (v8 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_warning()) {
                    abort 2
                };
                v6 = true;
            };
        } else if (v3) {
        } else {
            assert!(v4, 3);
            v7 = v5;
        };
        let (v9, v10) = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_history_price_data_from_feed(v0);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_range_and_history(v7, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_effective_price_from_feed(v0), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_minimum_effective_price_from_feed(v0), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_allowed_span_percentage_from_feed(v0), v1, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_historical_price_ttl(v0), v9, v10)) {
            abort 4
        };
        if (v6) {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::start_or_continue_diff_threshold2_timer(v0, v1);
        } else {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::reset_diff_threshold2_timer(v0);
        };
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::keep_history_update(v0, v7, 0x2::clock::timestamp_ms(arg1));
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::update_price(arg1, arg3, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_oracle_id_from_feed(v0), v7);
    }

    public fun update_single_price_for_testing_non_abort(arg0: &0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::OracleConfig, arg3: &mut 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::PriceOracle, arg4: u256, arg5: u64, arg6: u256, arg7: u64, arg8: address) : u256 {
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::version_verification(arg2);
        assert!(!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_paused(arg2), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::paused());
        let v0 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_config_id_to_address(arg2);
        let v1 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_feed_mut(arg2, arg8);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_price_feed_enable(v1)) {
            return 1
        };
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_timestamp_diff_from_feed(v1);
        let v4 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_primary_oracle_provider(v1);
        if (0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::is_empty(v4)) {
            return 2
        };
        let v5 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v2, arg5, v3);
        let v6 = false;
        let v7 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::is_secondary_oracle_available(v1);
        let v8 = 0;
        let v9 = 0;
        if (v7) {
            v9 = arg7;
            v8 = arg6;
            v6 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::is_oracle_price_fresh(v2, arg7, v3);
        };
        let v10 = false;
        let v11 = arg4;
        if (v5 && v6) {
            let v12 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold1_from_feed(v1);
            let v13 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_price_diff_threshold2_from_feed(v1);
            let v14 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_max_duration_within_thresholds_from_feed(v1);
            let v15 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_diff_threshold2_timer_from_feed(v1);
            let v16 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_difference(arg4, v8, v12, v13, v2, v14, v15);
            if (v16 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_normal()) {
                let v17 = PriceRegulation{
                    level                          : v16,
                    config_address                 : v0,
                    feed_address                   : arg8,
                    price_diff_threshold1          : v12,
                    price_diff_threshold2          : v13,
                    current_time                   : v2,
                    diff_threshold2_timer          : v15,
                    max_duration_within_thresholds : v14,
                    primary_price                  : arg4,
                    secondary_price                : v8,
                };
                0x2::event::emit<PriceRegulation>(v17);
                if (v16 != 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::level_warning()) {
                    return (v16 as u256) + 10
                };
                v10 = true;
            };
        } else if (v5) {
            if (v7) {
                let v18 = OracleUnavailable{
                    type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::secondary_type(),
                    config_address : v0,
                    feed_address   : arg8,
                    provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_secondary_oracle_provider(v1)),
                    price          : v8,
                    updated_time   : v9,
                };
                0x2::event::emit<OracleUnavailable>(v18);
            };
        } else if (v6) {
            let v19 = OracleUnavailable{
                type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::primary_type(),
                config_address : v0,
                feed_address   : arg8,
                provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v4),
                price          : arg4,
                updated_time   : arg5,
            };
            0x2::event::emit<OracleUnavailable>(v19);
            v11 = v8;
        } else {
            let v20 = OracleUnavailable{
                type           : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::both_type(),
                config_address : v0,
                feed_address   : arg8,
                provider       : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v4),
                price          : arg4,
                updated_time   : arg5,
            };
            0x2::event::emit<OracleUnavailable>(v20);
            return 4
        };
        let v21 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_effective_price_from_feed(v1);
        let v22 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_minimum_effective_price_from_feed(v1);
        let v23 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_maximum_allowed_span_percentage_from_feed(v1);
        let v24 = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_historical_price_ttl(v1);
        let (v25, v26) = 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_history_price_data_from_feed(v1);
        if (!0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::strategy::validate_price_range_and_history(v11, v21, v22, v23, v2, v24, v25, v26)) {
            let v27 = InvalidOraclePrice{
                config_address          : v0,
                feed_address            : arg8,
                provider                : 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider::to_string(v4),
                price                   : v11,
                maximum_effective_price : v21,
                minimum_effective_price : v22,
                maximum_allowed_span    : v23,
                current_timestamp       : v2,
                historical_price_ttl    : v24,
                historical_price        : v25,
                historical_updated_time : v26,
            };
            0x2::event::emit<InvalidOraclePrice>(v27);
            return 5
        };
        if (v10) {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::start_or_continue_diff_threshold2_timer(v1, v2);
        } else {
            0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::reset_diff_threshold2_timer(v1);
        };
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::keep_history_update(v1, v11, 0x2::clock::timestamp_ms(arg1));
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle::update_price(arg1, arg3, 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::config::get_oracle_id_from_feed(v1), v11);
        v11 + 10000
    }

    // decompiled from Move bytecode v6
}

