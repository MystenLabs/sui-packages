module 0x5fe3b133e6dcfcd04a1154d865d9bb3675729a8bd906fe23546d5a8c647e53de::market_global {
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

    public fun init_config(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg1);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 1)), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::market_factory_reserve_fee_too_high());
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

    public fun update_config(arg0: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::Version, arg1: &0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: u128, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::version::assert_current_version(arg0);
        assert!(0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::acl::update_config_role()), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::update_config_invalid_sender());
        let v0 = 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_raw_value(arg3);
        assert!(0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::less_or_equal(v0, 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::create_from_rational(1, 1)), 0xae115c07cb19bc7d9323bbb3e3e510aa0af8fba58473a2049ae802c9befda2d9::error::market_factory_reserve_fee_too_high());
        arg2.reserve_fee_percent = v0;
        arg2.treasury = arg4;
        arg2.permissionless = arg5;
    }

    // decompiled from Move bytecode v6
}

