module 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_pro {
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

    public fun get_price_from_adaptor(arg0: &0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::OracleProviderConfig, arg1: u8, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u256, u64) {
        let v0 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::get_provider_from_oracle_provider_config(arg0);
        if (v0 == 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::supra_provider()) {
            return 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::adaptor_supra::get_price_to_target_decimal(arg2, 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::adaptor_supra::vector_to_pair_id(0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_pair_id_from_oracle_provider_config(arg0)), arg1)
        };
        assert!(v0 == 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::pyth_provider(), 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_error::invalid_oracle_provider());
        assert!(0x2::address::from_bytes(0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::adaptor_pyth::get_identifier_to_vector(arg3)) == 0x2::address::from_bytes(0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_pair_id_from_oracle_provider_config(arg0)), 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_error::pair_not_match());
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::adaptor_pyth::get_price_unsafe_to_target_decimal(arg3, arg1)
    }

    public fun update_single_price(arg0: &0x2::clock::Clock, arg1: &mut 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::OracleConfig, arg2: &mut 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: address) {
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::version_verification(arg1);
        assert!(!0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::is_paused(arg1), 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_error::paused());
        let v0 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_config_id_to_address(arg1);
        let v1 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_price_feed_mut(arg1, arg5);
        if (!0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::is_price_feed_enable(v1)) {
            return
        };
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_max_timestamp_diff_from_feed(v1);
        let v4 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_oracle_id_from_feed(v1);
        let v5 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle::decimal(arg2, v4);
        let v6 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_primary_oracle_provider(v1);
        if (0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::is_empty(v6)) {
            return
        };
        let v7 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_primary_oracle_provider_config(v1);
        if (!0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::is_oracle_provider_config_enable(v7)) {
            return
        };
        let (v8, v9) = get_price_from_adaptor(v7, v5, arg3, arg4);
        let v10 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::strategy::is_oracle_price_fresh(v2, v9, v3);
        let v11 = false;
        let v12 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::is_secondary_oracle_available(v1);
        let v13 = 0;
        let v14 = 0;
        if (v12) {
            let (v15, v16) = get_price_from_adaptor(0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_secondary_source_config(v1), v5, arg3, arg4);
            v14 = v16;
            v13 = v15;
            v11 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::strategy::is_oracle_price_fresh(v2, v16, v3);
        };
        let v17 = false;
        let v18 = v8;
        if (v10 && v11) {
            let v19 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_price_diff_threshold1_from_feed(v1);
            let v20 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_price_diff_threshold2_from_feed(v1);
            let v21 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_max_duration_within_thresholds_from_feed(v1);
            let v22 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_diff_threshold2_timer_from_feed(v1);
            let v23 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::strategy::validate_price_difference(v8, v13, v19, v20, v2, v21, v22);
            if (v23 != 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::level_normal()) {
                let v24 = PriceRegulation{
                    level                          : v23,
                    config_address                 : v0,
                    feed_address                   : arg5,
                    price_diff_threshold1          : v19,
                    price_diff_threshold2          : v20,
                    current_time                   : v2,
                    diff_threshold2_timer          : v22,
                    max_duration_within_thresholds : v21,
                    primary_price                  : v8,
                    secondary_price                : v13,
                };
                0x2::event::emit<PriceRegulation>(v24);
                if (v23 != 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::level_warning()) {
                    return
                };
                v17 = true;
            };
        } else if (v10) {
            if (v12) {
                let v25 = OracleUnavailable{
                    type           : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::secondary_type(),
                    config_address : v0,
                    feed_address   : arg5,
                    provider       : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::to_string(0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_secondary_oracle_provider(v1)),
                    price          : v13,
                    updated_time   : v14,
                };
                0x2::event::emit<OracleUnavailable>(v25);
            };
        } else if (v11) {
            let v26 = OracleUnavailable{
                type           : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::primary_type(),
                config_address : v0,
                feed_address   : arg5,
                provider       : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::to_string(v6),
                price          : v8,
                updated_time   : v9,
            };
            0x2::event::emit<OracleUnavailable>(v26);
            v18 = v13;
        } else {
            let v27 = OracleUnavailable{
                type           : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_constants::both_type(),
                config_address : v0,
                feed_address   : arg5,
                provider       : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::to_string(v6),
                price          : v8,
                updated_time   : v9,
            };
            0x2::event::emit<OracleUnavailable>(v27);
            return
        };
        let v28 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_maximum_effective_price_from_feed(v1);
        let v29 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_minimum_effective_price_from_feed(v1);
        let v30 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_maximum_allowed_span_percentage_from_feed(v1);
        let v31 = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_historical_price_ttl(v1);
        let (v32, v33) = 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::get_history_price_data_from_feed(v1);
        if (!0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::strategy::validate_price_range_and_history(v18, v28, v29, v30, v2, v31, v32, v33)) {
            let v34 = InvalidOraclePrice{
                config_address          : v0,
                feed_address            : arg5,
                provider                : 0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle_provider::to_string(v6),
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
            0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::start_or_continue_diff_threshold2_timer(v1, v2);
        } else {
            0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::reset_diff_threshold2_timer(v1);
        };
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::config::keep_history_update(v1, v18, 0x2::clock::timestamp_ms(arg0));
        0xfee08a8d5dd4f631ab2df1a17cc1ab78a8e8d5b319d11d98fa3e9a181382e0cb::oracle::update_price(arg0, arg2, v4, v18);
    }

    // decompiled from Move bytecode v6
}

