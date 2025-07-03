module 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config {
    struct OracleConfig has key {
        id: 0x2::object::UID,
        feed_id: 0x1::option::Option<0x2::object::ID>,
        conf_tolerance: 0x1::option::Option<0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal>,
        min_exchange_rate: 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal,
        max_exchange_rate: 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal,
    }

    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
        parent: 0x2::object::ID,
    }

    public fun assert_pyth_price_info_object(arg0: &OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == price_feed_id(arg0), 1);
    }

    public fun conf_tolerance_denominator() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id                : 0x2::object::new(arg0),
            feed_id           : 0x1::option::none<0x2::object::ID>(),
            conf_tolerance    : 0x1::option::none<0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal>(),
            min_exchange_rate : 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_percent(100),
            max_exchange_rate : 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_percent(112),
        };
        let v1 = OracleAdminCap{
            id     : 0x2::object::new(arg0),
            parent : 0x2::object::id<OracleConfig>(&v0),
        };
        0x2::transfer::share_object<OracleConfig>(v0);
        0x2::transfer::transfer<OracleAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_exchange_rate(arg0: &OracleConfig) : 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal {
        arg0.max_exchange_rate
    }

    public fun min_exchange_rate(arg0: &OracleConfig) : 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal {
        arg0.min_exchange_rate
    }

    public fun price_conf_tolerance(arg0: &OracleConfig) : 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal {
        assert!(0x1::option::is_some<0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal>(&arg0.conf_tolerance), 4);
        *0x1::option::borrow<0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal>(&arg0.conf_tolerance)
    }

    public fun price_feed_id(arg0: &OracleConfig) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.feed_id), 4);
        *0x1::option::borrow<0x2::object::ID>(&arg0.feed_id)
    }

    public entry fun update_exchange_rate_constraint(arg0: &mut OracleConfig, arg1: &OracleAdminCap, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<OracleConfig>(arg0) == arg1.parent, 2);
        arg0.min_exchange_rate = 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_bps(arg2);
        arg0.max_exchange_rate = 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_bps(arg3);
    }

    public entry fun update_oracle_config(arg0: &mut OracleConfig, arg1: &OracleAdminCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        assert!(arg3 <= conf_tolerance_denominator(), 3);
        assert!(0x2::object::id<OracleConfig>(arg0) == arg1.parent, 2);
        arg0.feed_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        arg0.conf_tolerance = 0x1::option::some<0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal>(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from_bps(arg3));
    }

    // decompiled from Move bytecode v6
}

