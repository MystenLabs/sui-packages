module 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_global {
    struct MarketFactoryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        reserveFeePercent: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::FixedPoint64,
        overrideFeePercent: 0x2::bag::Bag,
        markets: 0x2::bag::Bag,
    }

    public fun add(arg0: &mut MarketFactoryConfig, arg1: 0x1::string::String) {
        0x2::bag::add<0x1::string::String, bool>(&mut arg0.markets, arg1, true);
    }

    public fun contains(arg0: &MarketFactoryConfig, arg1: 0x1::string::String) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.markets, arg1)
    }

    public fun get_reserve_fee_percent(arg0: &MarketFactoryConfig) : 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::FixedPoint64 {
        arg0.reserveFeePercent
    }

    public fun get_treasury(arg0: &MarketFactoryConfig) : address {
        arg0.treasury
    }

    public fun init_config(arg0: u128, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_raw_value(arg0);
        assert!(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::less_or_equal(v0, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_rational(1, 1)), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_factory_reserve_fee_too_high());
        let v1 = MarketFactoryConfig{
            id                 : 0x2::object::new(arg2),
            treasury           : arg1,
            reserveFeePercent  : v0,
            overrideFeePercent : 0x2::bag::new(arg2),
            markets            : 0x2::bag::new(arg2),
        };
        0x2::transfer::share_object<MarketFactoryConfig>(v1);
    }

    public fun update_config(arg0: &mut MarketFactoryConfig, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_raw_value(arg1);
        assert!(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::less_or_equal(v0, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_rational(1, 1)), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_factory_reserve_fee_too_high());
        arg0.reserveFeePercent = v0;
        arg0.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

