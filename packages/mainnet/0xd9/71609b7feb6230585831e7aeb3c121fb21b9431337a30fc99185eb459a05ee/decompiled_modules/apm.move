module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::apm {
    struct MinPriceHistory has copy, drop, store {
        price: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
        last_update: u64,
    }

    fun create_min_price_history_vector() : vector<MinPriceHistory> {
        let v0 = 0x1::vector::empty<MinPriceHistory>();
        let v1 = MinPriceHistory{
            price       : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0),
            last_update : 0,
        };
        let v2 = 0;
        while (v2 < 24) {
            0x1::vector::push_back<MinPriceHistory>(&mut v0, v1);
            v2 = v2 + 1;
        };
        v0
    }

    fun init_if_not_exists(arg0: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: 0x1::type_name::TypeName) {
        if (0x2::dynamic_field::exists_<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::MinPriceHistoryKey>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::min_price_history_key(arg1))) {
            return
        };
        0x2::dynamic_field::add<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid_mut(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::min_price_history_key(arg1), create_min_price_history_vector());
    }

    public(friend) fun is_price_fluctuate(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x2::dynamic_field::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::min_price_history_key(arg2));
        let v1 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0);
        let v2 = 0;
        while (v2 < 24) {
            let v3 = 0x1::vector::borrow<MinPriceHistory>(v0, v2);
            if (0x2::clock::timestamp_ms(arg3) / 1000 - v3.last_update <= 86400) {
                if (0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::eq(v1, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0))) {
                    v1 = v3.price;
                } else if (0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::gt(v3.price, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0))) {
                    v1 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::min(v1, v3.price);
                };
            };
            v2 = v2 + 1;
        };
        let v4 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg1, arg2, arg3));
        if (0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::le(v4, v1)) {
            return false
        };
        assert!(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::gt(v1, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::apm_price_history_empty_error());
        if (0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::ge(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::sub(v4, v1), v1), *0x2::dynamic_field::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::ApmThresholdKey, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::apm_threshold_key(arg2)))) {
            return true
        };
        false
    }

    public(friend) fun record_min_price_history(arg0: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x1::vector::borrow_mut<MinPriceHistory>(0x2::dynamic_field::borrow_mut<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid_mut(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::min_price_history_key(arg2)), v0 / 3600 % 24);
        if (v1.last_update == 0 || v0 - v1.last_update > 3600) {
            v1.price = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg1, arg2, arg3));
        } else {
            v1.price = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::min(v1.price, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg1, arg2, arg3)));
        };
        v1.last_update = v0;
    }

    public fun refresh_apm_state<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        record_min_price_history(arg1, arg2, 0x1::type_name::with_defining_ids<T0>(), arg3);
    }

    public(friend) fun set_apm_threshold(arg0: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_if_not_exists(arg0, arg1);
        if (0x2::dynamic_field::exists_<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::ApmThresholdKey>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::apm_threshold_key(arg1))) {
            *0x2::dynamic_field::borrow_mut<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::ApmThresholdKey, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid_mut(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::apm_threshold_key(arg1)) = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_percent_u64(arg2);
        } else {
            0x2::dynamic_field::add<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::ApmThresholdKey, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid_mut(arg0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::apm_threshold_key(arg1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_percent_u64(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

