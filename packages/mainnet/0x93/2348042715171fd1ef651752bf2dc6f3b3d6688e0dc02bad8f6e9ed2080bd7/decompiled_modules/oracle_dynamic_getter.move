module 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_dynamic_getter {
    public fun get_dynamic_single_price(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::OracleConfig, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: address) : (u64, u256) {
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::version_verification(arg1);
        if (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::is_paused(arg1)) {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::paused(), 0)
        };
        let v0 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_price_feed(arg1, arg5);
        if (!0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::is_price_feed_enable(v0)) {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::price_feed_not_found(), 0)
        };
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_max_timestamp_diff_from_feed(v0);
        let v3 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::safe_decimal(arg2, 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_oracle_id_from_feed(v0));
        if (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_provider::is_empty(0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_primary_oracle_provider(v0))) {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::invalid_oracle_provider(), 0)
        };
        let v4 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_primary_oracle_provider_config(v0);
        if (!0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_provider::is_oracle_provider_config_enable(v4)) {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::oracle_provider_disabled(), 0)
        };
        let (v5, v6) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_pro::get_price_from_adaptor(v4, v3, arg3, arg4);
        let v7 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::strategy::is_oracle_price_fresh(v1, v6, v2);
        let v8 = false;
        let v9 = 0;
        if (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::is_secondary_oracle_available(v0)) {
            let (v10, v11) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_pro::get_price_from_adaptor(0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_secondary_source_config(v0), v3, arg3, arg4);
            v9 = v10;
            v8 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::strategy::is_oracle_price_fresh(v1, v11, v2);
        };
        let v12 = v5;
        if (v7 && v8) {
            let v13 = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::strategy::validate_price_difference(v5, v9, 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_price_diff_threshold1_from_feed(v0), 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_price_diff_threshold2_from_feed(v0), v1, 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_max_duration_within_thresholds_from_feed(v0), 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_diff_threshold2_timer_from_feed(v0));
            if (v13 != 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::level_normal()) {
                if (v13 != 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::level_warning()) {
                    return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::invalid_price_diff(), 0)
                };
            };
        } else if (v7) {
        } else if (v8) {
            v12 = v9;
        } else {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::no_available_price(), 0)
        };
        let (v14, v15) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_history_price_data_from_feed(v0);
        if (!0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::strategy::validate_price_range_and_history(v12, 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_maximum_effective_price_from_feed(v0), 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_minimum_effective_price_from_feed(v0), 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_maximum_allowed_span_percentage_from_feed(v0), v1, 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::config::get_historical_price_ttl(v0), v14, v15)) {
            return (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::invalid_final_price(), 0)
        };
        (0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::success(), v12)
    }

    // decompiled from Move bytecode v6
}

