module 0xa73001d5f5a504bc232ace51fe8e460cbd5b8ac129dae28747693eae0444aa24::market_global {
    struct MarketFactoryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        reserve_fee_percent: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        override_fee_percent: 0x2::bag::Bag,
        permissionless: bool,
        markets: 0x2::bag::Bag,
    }

    public fun add(arg0: &mut MarketFactoryConfig, arg1: 0x1::string::String) {
        0x2::bag::add<0x1::string::String, bool>(&mut arg0.markets, arg1, true);
    }

    public fun contains(arg0: &MarketFactoryConfig, arg1: 0x1::string::String) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.markets, arg1)
    }

    public fun get_reserve_fee_percent(arg0: &MarketFactoryConfig) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        arg0.reserve_fee_percent
    }

    public fun get_treasury(arg0: &MarketFactoryConfig) : address {
        arg0.treasury
    }

    public fun init_config(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg1);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 1)), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_factory_reserve_fee_too_high());
        let v1 = MarketFactoryConfig{
            id                   : 0x2::object::new(arg3),
            treasury             : arg2,
            reserve_fee_percent  : v0,
            override_fee_percent : 0x2::bag::new(arg3),
            permissionless       : false,
            markets              : 0x2::bag::new(arg3),
        };
        0x2::transfer::share_object<MarketFactoryConfig>(v1);
    }

    public fun is_market_permissionless(arg0: &MarketFactoryConfig) : bool {
        arg0.permissionless
    }

    public fun update_config(arg0: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::Version, arg1: &0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: u128, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::version::assert_current_version(arg0);
        assert!(0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::acl::update_config_role()), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::update_config_invalid_sender());
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg3);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 1)), 0x1567b8532bea4df658bf5703b4ae8517e249050f091bd2b25580477ec17e6beb::error::market_factory_reserve_fee_too_high());
        arg2.reserve_fee_percent = v0;
        arg2.treasury = arg4;
        arg2.permissionless = arg5;
    }

    // decompiled from Move bytecode v6
}

