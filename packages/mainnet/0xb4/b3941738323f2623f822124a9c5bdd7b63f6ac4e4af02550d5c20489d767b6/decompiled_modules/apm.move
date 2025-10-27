module 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::apm {
    struct MinPriceHistory has copy, drop, store {
        price: 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal,
        last_update: u64,
    }

    fun create_min_price_history_vector() : vector<MinPriceHistory> {
        let v0 = 0x1::vector::empty<MinPriceHistory>();
        let v1 = MinPriceHistory{
            price       : 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(0),
            last_update : 0,
        };
        let v2 = 0;
        while (v2 < 24) {
            0x1::vector::push_back<MinPriceHistory>(&mut v0, v1);
            v2 = v2 + 1;
        };
        v0
    }

    fun init_if_not_exists(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: 0x1::type_name::TypeName) {
        if (0x2::dynamic_field::exists_<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinPriceHistoryKey>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::min_price_history_key(arg1))) {
            return
        };
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::min_price_history_key(arg1), create_min_price_history_vector());
    }

    public(friend) fun is_price_fluctuate(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x2::dynamic_field::borrow<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::min_price_history_key(arg2));
        let v1 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(0);
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v3 = 0;
        while (v3 < 24) {
            let v4 = 0x1::vector::borrow<MinPriceHistory>(v0, v3);
            if (v2 - v4.last_update <= 86400) {
                if (0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::eq(v1, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(0))) {
                    v1 = v4.price;
                } else if (0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::gt(v4.price, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(0))) {
                    v1 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::min(v1, v4.price);
                };
            };
            v3 = v3 + 1;
        };
        let v5 = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from_fixed_point32(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg1, arg2, arg3));
        if (0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::le(v5, v1)) {
            return false
        };
        if (0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::eq(v1, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from(0))) {
            return false
        };
        if (0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::ge(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::div(0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::sub(v5, v1), v1), *0x2::dynamic_field::borrow<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::ApmThresholdKey, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::apm_threshold_key(arg2)))) {
            return true
        };
        false
    }

    public(friend) fun record_min_price_history(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x1::vector::borrow_mut<MinPriceHistory>(0x2::dynamic_field::borrow_mut<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinPriceHistoryKey, vector<MinPriceHistory>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::min_price_history_key(arg2)), v0 / 3600 % 24);
        if (v1.last_update == 0 || v0 - v1.last_update > 3600) {
            v1.price = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from_fixed_point32(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg1, arg2, arg3));
        } else {
            v1.price = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::min(v1.price, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from_fixed_point32(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg1, arg2, arg3)));
        };
        v1.last_update = v0;
    }

    public(friend) fun set_apm_threshold(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: 0x1::type_name::TypeName, arg2: u8) {
        init_if_not_exists(arg0, arg1);
        if (0x2::dynamic_field::exists_<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::ApmThresholdKey>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::apm_threshold_key(arg1))) {
            *0x2::dynamic_field::borrow_mut<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::ApmThresholdKey, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::apm_threshold_key(arg1)) = 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from_percent(arg2);
        } else {
            0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::ApmThresholdKey, 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::Decimal>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::apm_threshold_key(arg1), 0x6b3402f2048ab5c52f5dac345e2807ec10b2dc7fa10f9c54185158681f70cd72::decimal::from_percent(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

