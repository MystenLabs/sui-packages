module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market_global {
    struct MarketFactoryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        reserve_fee_percent: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        override_fee_percent: 0x2::table::Table<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>,
        permissionless: bool,
        max_reserve_fee_percent: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64,
        min_expiry_interval: u64,
        markets: 0x2::bag::Bag,
    }

    public(friend) fun add(arg0: &mut MarketFactoryConfig, arg1: 0x1::string::String) {
        0x2::bag::add<0x1::string::String, bool>(&mut arg0.markets, arg1, true);
    }

    public fun contains(arg0: &MarketFactoryConfig, arg1: 0x1::string::String) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.markets, arg1)
    }

    public fun get_min_expiry_interval(arg0: &MarketFactoryConfig) : u64 {
        arg0.min_expiry_interval
    }

    public fun get_reserve_fee_percent(arg0: &MarketFactoryConfig, arg1: 0x1::string::String) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        if (0x2::table::contains<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg0.override_fee_percent, arg1)) {
            return 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::value(0x2::table::borrow<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg0.override_fee_percent, arg1)))
        };
        arg0.reserve_fee_percent
    }

    public fun get_treasury(arg0: &MarketFactoryConfig) : address {
        arg0.treasury
    }

    public fun init_config(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::State, arg3: u128, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::uid(arg2), b"init market factory config"), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::init_config_already_initialized());
        let v0 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg3);
        let v1 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(1, 1);
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less_or_equal(v0, v1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_factory_reserve_fee_too_high());
        let v2 = MarketFactoryConfig{
            id                      : 0x2::object::new(arg5),
            treasury                : arg4,
            reserve_fee_percent     : v0,
            override_fee_percent    : 0x2::table::new<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(arg5),
            permissionless          : false,
            max_reserve_fee_percent : v1,
            min_expiry_interval     : 86400000,
            markets                 : 0x2::bag::new(arg5),
        };
        0x2::dynamic_field::add<vector<u8>, bool>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::uid(arg2), b"init market factory config", true);
        0x2::transfer::share_object<MarketFactoryConfig>(v2);
    }

    public fun is_market_permissionless(arg0: &MarketFactoryConfig) : bool {
        arg0.permissionless
    }

    public fun set_override_fee_percent(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: 0x1::string::String, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less_or_equal(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg4), arg2.max_reserve_fee_percent), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_factory_reserve_fee_too_high());
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
        if (0x2::table::contains<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg2.override_fee_percent, arg3)) {
            0x2::table::remove<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&mut arg2.override_fee_percent, arg3);
        };
        0x2::table::add<0x1::string::String, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&mut arg2.override_fee_percent, arg3, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg4));
    }

    public fun update_config(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: u128, arg4: address, arg5: u128, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
        let v0 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg3);
        let v1 = 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg5);
        if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v1) != 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(arg2.max_reserve_fee_percent)) {
            assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
            assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less(v1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(1, 1)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_factory_reserve_fee_too_high());
            arg2.max_reserve_fee_percent = v1;
        };
        if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v0) != 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(arg2.reserve_fee_percent)) {
            assert!(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less_or_equal(v0, v1), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_factory_reserve_fee_too_high());
            arg2.reserve_fee_percent = v0;
        };
        if (arg4 != arg2.treasury) {
            assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::update_config_invalid_sender());
            arg2.treasury = arg4;
        };
        arg2.reserve_fee_percent = v0;
        arg2.permissionless = arg7;
        arg2.min_expiry_interval = arg6;
    }

    // decompiled from Move bytecode v6
}

