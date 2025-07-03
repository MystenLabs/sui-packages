module 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::OracleConfig, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock) : (u64, u64) {
        0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::assert_pyth_price_info_object(arg2, arg1);
        let v0 = 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::div(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg3)), 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(1000000));
        let (v1, _, v3, v4) = 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::pyth_adaptor::get_pyth_price(arg0, arg1, arg2, arg4);
        assert!(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::le(v0, 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::max_exchange_rate(arg2)), 2);
        assert!(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::ge(v0, 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::min_exchange_rate(arg2)), 2);
        let v5 = 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::decimals();
        let v6 = if (v3 < v5) {
            0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::floor(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::mul(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(v1), v0)) * 0x1::u64::pow(10, v5 - v3)
        } else {
            0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::floor(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::mul(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(v1), v0)) / 0x1::u64::pow(10, v3 - v5)
        };
        assert!(v6 > 0, 1);
        (v6, v4)
    }

    public fun set_price_as_primary(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::OracleConfig, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock) {
        let (v0, v1) = get_price(arg1, arg2, arg3, arg4, arg5);
        let v2 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_primary_price<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, Rule>(v2, arg0, 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new(v0, v1));
    }

    public fun set_price_as_secondary(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::OracleConfig, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock) {
        let (v0, v1) = get_price(arg1, arg2, arg3, arg4, arg5);
        let v2 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_secondary_price<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, Rule>(v2, arg0, 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new(v0, v1));
    }

    // decompiled from Move bytecode v6
}

