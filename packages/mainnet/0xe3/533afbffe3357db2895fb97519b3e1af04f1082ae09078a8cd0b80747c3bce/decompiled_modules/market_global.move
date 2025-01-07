module 0xe3533afbffe3357db2895fb97519b3e1af04f1082ae09078a8cd0b80747c3bce::market_global {
    struct MarketFactoryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        reserve_fee_percent: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64,
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

    public fun get_reserve_fee_percent(arg0: &MarketFactoryConfig) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::FixedPoint64 {
        arg0.reserve_fee_percent
    }

    public fun get_treasury(arg0: &MarketFactoryConfig) : address {
        arg0.treasury
    }

    public fun init_config(arg0: &0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::Version, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::assert_current_version(arg0);
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(arg1);
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::less_or_equal(v0, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_rational(1, 1)), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::market_factory_reserve_fee_too_high());
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

    public fun update_config(arg0: &0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::Version, arg1: &0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: u128, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::version::assert_current_version(arg0);
        assert!(0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::acl::update_config_role()), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::update_config_invalid_sender());
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(arg3);
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::less_or_equal(v0, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_rational(1, 1)), 0x2851ee8f2b681f842cf9ecc1e82dec43551bf0b940eedfa03a1d50349a316797::error::market_factory_reserve_fee_too_high());
        arg2.reserve_fee_percent = v0;
        arg2.treasury = arg4;
        arg2.permissionless = arg5;
    }

    // decompiled from Move bytecode v6
}

