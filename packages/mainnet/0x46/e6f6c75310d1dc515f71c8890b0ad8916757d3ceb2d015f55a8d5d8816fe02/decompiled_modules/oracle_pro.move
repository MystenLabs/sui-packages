module 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_pro {
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
        provider: vector<u8>,
        price: u256,
        maximum_effective_price: u256,
        minimum_effective_price: u256,
        maximum_allowed_span: u64,
        current_timestamp: u64,
        historical_price_ttl: u64,
        historycal_price: u256,
        historycal_updated_time: u64,
    }

    struct OracleUnavailable has copy, drop {
        type: u8,
        config_address: address,
        feed_address: address,
        provider: vector<u8>,
        price: u256,
        updated_time: u64,
    }

    public fun get_price_from_adaptor(arg0: &0x2::clock::Clock, arg1: &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig, arg2: u8, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u256, u64) {
        let v0 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_provider_from_oracle_provider_config(arg1);
        if (v0 == 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::supra_provider()) {
            return 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::adaptor_supra::get_price_to_target_decimal(arg3, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::adaptor_supra::vector_to_pair_id(0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_pair_id_from_oracle_provider_config(arg1)), arg2)
        };
        assert!(v0 == 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::pyth_provider(), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::invalid_oracle_provider());
        assert!(0x2::address::from_bytes(0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::adaptor_pyth::get_identifier_to_vector(arg5)) == 0x2::address::from_bytes(0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_pair_id_from_oracle_provider_config(arg1)), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::pair_not_match());
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::adaptor_pyth::get_price_to_target_decimal(arg0, arg4, arg5, arg2)
    }

    public fun update_prices(arg0: &0x2::clock::Clock, arg1: &mut 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::OracleConfig, arg2: &mut 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_vec_feeds(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            update_single_price(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    public fun update_single_price(arg0: &0x2::clock::Clock, arg1: &mut 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::OracleConfig, arg2: &mut 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address) {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::version_verification(arg1);
        assert!(!0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::is_paused(arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::paused());
        let v0 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_config_id_to_address(arg1);
        let v1 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_price_feed_mut(arg1, arg6);
        if (!0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::is_price_feed_enable(v1)) {
            return
        };
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_max_timestamp_diff_from_feed(v1);
        let v4 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_oracle_id_from_feed(v1);
        let v5 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle::decimal(arg2, v4);
        let v6 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_primary_oracle_provider(v1);
        if (0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_empty(v6)) {
            return
        };
        let (v7, v8) = get_price_from_adaptor(arg0, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_primary_oracle_provider_config(v1), v5, arg3, arg4, arg5);
        let v9 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::strategy::is_oracle_price_fresh(v2, v8, v3);
        let v10 = false;
        let v11 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::is_secondary_oracle_available(v1);
        let v12 = 0;
        if (v11) {
            let (v13, v14) = get_price_from_adaptor(arg0, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_secondary_source_config(v1), v5, arg3, arg4, arg5);
            v12 = v13;
            v10 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::strategy::is_oracle_price_fresh(v2, v14, v3);
        };
        let v15 = false;
        let v16 = v7;
        if (v9 && v10) {
            let v17 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_price_diff_threshold1_from_feed(v1);
            let v18 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_price_diff_threshold2_from_feed(v1);
            let v19 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_max_duration_within_thresholds_from_feed(v1);
            let v20 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_diff_threshold2_timer_from_feed(v1);
            let v21 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::strategy::validate_price_difference(v7, v12, v17, v18, v2, v19, v20);
            if (v21 != 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::level_normal()) {
                let v22 = PriceRegulation{
                    level                          : v21,
                    config_address                 : v0,
                    feed_address                   : arg6,
                    price_diff_threshold1          : v17,
                    price_diff_threshold2          : v18,
                    current_time                   : v2,
                    diff_threshold2_timer          : v20,
                    max_duration_within_thresholds : v19,
                    primary_price                  : v7,
                    secondary_price                : v12,
                };
                0x2::event::emit<PriceRegulation>(v22);
                if (v21 != 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::level_warning()) {
                    return
                };
                v15 = true;
            };
        } else if (v9) {
            if (v11) {
                let v23 = OracleUnavailable{
                    type           : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::secondary_type(),
                    config_address : v0,
                    feed_address   : arg6,
                    provider       : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(v6),
                    price          : v7,
                    updated_time   : v8,
                };
                0x2::event::emit<OracleUnavailable>(v23);
            };
        } else if (v10) {
            let v24 = OracleUnavailable{
                type           : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::primary_type(),
                config_address : v0,
                feed_address   : arg6,
                provider       : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(v6),
                price          : v7,
                updated_time   : v8,
            };
            0x2::event::emit<OracleUnavailable>(v24);
            v16 = v12;
        } else {
            let v25 = OracleUnavailable{
                type           : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_constants::both_type(),
                config_address : v0,
                feed_address   : arg6,
                provider       : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(v6),
                price          : v7,
                updated_time   : v8,
            };
            0x2::event::emit<OracleUnavailable>(v25);
            return
        };
        let v26 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_maximum_effective_price_from_feed(v1);
        let v27 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_minimum_effective_price_from_feed(v1);
        let v28 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_maximum_allowed_span_percentage_from_feed(v1);
        let v29 = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_historical_price_ttl(v1);
        let (v30, v31) = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::get_history_price_data_from_feed(v1);
        if (!0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::strategy::validate_price_range_and_history(v16, v26, v27, v28, v2, v29, v30, v31)) {
            let v32 = InvalidOraclePrice{
                config_address          : v0,
                feed_address            : arg6,
                provider                : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(v6),
                price                   : v16,
                maximum_effective_price : v26,
                minimum_effective_price : v27,
                maximum_allowed_span    : v28,
                current_timestamp       : v2,
                historical_price_ttl    : v29,
                historycal_price        : v30,
                historycal_updated_time : v31,
            };
            0x2::event::emit<InvalidOraclePrice>(v32);
            return
        };
        if (v15) {
            0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::start_or_continue_diff_threshold2_timer(v1, v2);
        } else {
            0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::reset_diff_threshold2_timer(v1);
        };
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config::keep_history_update(v1, v16, 0x2::clock::timestamp_ms(arg0));
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle::update_price(arg0, arg2, v4, v16);
    }

    // decompiled from Move bytecode v6
}

