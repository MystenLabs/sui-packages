module 0x215de4e4f22fd7fe4f698907ce8e69b972f3b27b9799825e24f7e77b6b2d6b58::market_global {
    struct MarketFactoryConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        reserve_fee_percent: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
        override_fee_percent: 0x2::table::Table<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>,
        permissionless: bool,
        max_reserve_fee_percent: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64,
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

    public fun get_reserve_fee_percent(arg0: &MarketFactoryConfig, arg1: 0x1::string::String) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        if (0x2::table::contains<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg0.override_fee_percent, arg1)) {
            return 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::value(0x2::table::borrow<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg0.override_fee_percent, arg1)))
        };
        arg0.reserve_fee_percent
    }

    public fun get_treasury(arg0: &MarketFactoryConfig) : address {
        arg0.treasury
    }

    public fun init_config(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::ACL, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::assert_current_version(arg0);
        assert!(0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::admin_role()), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::update_config_invalid_sender());
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(arg2);
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational(1, 1);
        assert!(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::less_or_equal(v0, v1), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::market_factory_reserve_fee_too_high());
        let v2 = MarketFactoryConfig{
            id                      : 0x2::object::new(arg4),
            treasury                : arg3,
            reserve_fee_percent     : v0,
            override_fee_percent    : 0x2::table::new<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(arg4),
            permissionless          : false,
            max_reserve_fee_percent : v1,
            min_expiry_interval     : 86400000,
            markets                 : 0x2::bag::new(arg4),
        };
        0x2::transfer::share_object<MarketFactoryConfig>(v2);
    }

    public fun is_market_permissionless(arg0: &MarketFactoryConfig) : bool {
        arg0.permissionless
    }

    public fun set_override_fee_percent(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::ACL, arg1: &mut MarketFactoryConfig, arg2: 0x1::string::String, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::has_role(arg0, 0x2::tx_context::sender(arg4), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::admin_role()), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::update_config_invalid_sender());
        if (0x2::table::contains<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg1.override_fee_percent, arg2)) {
            0x2::table::remove<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg1.override_fee_percent, arg2);
        };
        0x2::table::add<0x1::string::String, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg1.override_fee_percent, arg2, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(arg3));
    }

    public fun update_config(arg0: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::Version, arg1: &0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::ACL, arg2: &mut MarketFactoryConfig, arg3: u128, arg4: address, arg5: u128, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::version::assert_current_version(arg0);
        assert!(0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::update_config_role()), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::update_config_invalid_sender());
        if (arg5 != 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(arg2.max_reserve_fee_percent)) {
            assert!(0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::admin_role()), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::update_config_invalid_sender());
            arg2.max_reserve_fee_percent = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(arg5);
        };
        if (arg4 != arg2.treasury) {
            assert!(0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::acl::admin_role()), 0x696345bc36a218f6d37c2ef8396ae0f5fc64fa341ec7a2858f8884e07cf5e781::error::update_config_invalid_sender());
            arg2.treasury = arg4;
        };
        arg2.reserve_fee_percent = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(arg3);
        arg2.permissionless = arg7;
        arg2.min_expiry_interval = arg6;
    }

    // decompiled from Move bytecode v6
}

