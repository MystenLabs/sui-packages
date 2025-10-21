module 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle {
    struct PriceInfo has drop, store {
        aggregator: address,
        decimals: u8,
        price: u256,
        last_updated: u64,
    }

    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        aggregators: 0x2::table::Table<0x1::ascii::String, PriceInfo>,
        update_interval: u64,
        dex_slippage: u256,
    }

    struct UpdateIntervalSet has copy, drop {
        update_interval: u64,
    }

    struct DexSlippageSet has copy, drop {
        dex_slippage: u256,
    }

    struct PriceUpdated has copy, drop {
        price: u256,
        timestamp: u64,
    }

    struct SwitchboardAggregatorAdded has copy, drop {
        asset_type: 0x1::ascii::String,
        aggregator: address,
    }

    struct SwitchboardAggregatorRemoved has copy, drop {
        asset_type: 0x1::ascii::String,
        aggregator: address,
    }

    struct SwitchboardAggregatorChanged has copy, drop {
        asset_type: 0x1::ascii::String,
        old_aggregator: address,
        new_aggregator: address,
    }

    struct OracleConfigUpgraded has copy, drop {
        oracle_config_id: address,
        version: u64,
    }

    struct AssetPriceUpdated has copy, drop {
        asset_type: 0x1::ascii::String,
        price: u256,
        timestamp: u64,
    }

    public(friend) fun add_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u8, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        check_version(arg0);
        assert!(!0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 2003);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg4);
        let v1 = PriceInfo{
            aggregator   : 0x2::object::id_to_address(&v0),
            decimals     : arg3,
            price        : get_current_price(arg0, arg1, arg4),
            last_updated : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg2, v1);
        let v2 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg4);
        let v3 = SwitchboardAggregatorAdded{
            asset_type : arg2,
            aggregator : 0x2::object::id_to_address(&v2),
        };
        0x2::event::emit<SwitchboardAggregatorAdded>(v3);
    }

    public(friend) fun change_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 2001);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg2);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg3);
        let v2 = SwitchboardAggregatorChanged{
            asset_type     : arg2,
            old_aggregator : v0.aggregator,
            new_aggregator : 0x2::object::id_to_address(&v1),
        };
        0x2::event::emit<SwitchboardAggregatorChanged>(v2);
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg3);
        v0.aggregator = 0x2::object::id_to_address(&v3);
        v0.price = get_current_price(arg0, arg1, arg3);
        v0.last_updated = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun check_version(arg0: &OracleConfig) {
        assert!(arg0.version == 2, 2005);
    }

    public fun coin_decimals(arg0: &OracleConfig, arg1: 0x1::ascii::String) : u8 {
        0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).decimals
    }

    public fun dex_slippage(arg0: &OracleConfig) : u256 {
        arg0.dex_slippage
    }

    public fun get_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 2001);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2);
        assert!(0x1::u64::diff(v0.last_updated, 0x2::clock::timestamp_ms(arg1)) < arg0.update_interval, 2002);
        v0.price
    }

    public fun get_current_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : u256 {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        let v2 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v1);
        if (v0 >= v2) {
            assert!(v0 - v2 < arg0.update_interval, 2002);
        };
        (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v1)) as u256)
    }

    public fun get_normalized_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2).decimals;
        if (v0 < 9) {
            get_asset_price(arg0, arg1, arg2) * (0x1::u64::pow(10, 9 - v0) as u256)
        } else {
            get_asset_price(arg0, arg1, arg2) / (0x1::u64::pow(10, v0 - 9) as u256)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id              : 0x2::object::new(arg0),
            version         : 2,
            aggregators     : 0x2::table::new<0x1::ascii::String, PriceInfo>(arg0),
            update_interval : 60000,
            dex_slippage    : 100,
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    public(friend) fun remove_switchboard_aggregator(arg0: &mut OracleConfig, arg1: 0x1::ascii::String) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1), 2001);
        let v0 = SwitchboardAggregatorRemoved{
            asset_type : arg1,
            aggregator : 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).aggregator,
        };
        0x2::event::emit<SwitchboardAggregatorRemoved>(v0);
        0x2::table::remove<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg1);
    }

    public(friend) fun set_dex_slippage(arg0: &mut OracleConfig, arg1: u256) {
        check_version(arg0);
        arg0.dex_slippage = arg1;
        let v0 = DexSlippageSet{dex_slippage: arg1};
        0x2::event::emit<DexSlippageSet>(v0);
    }

    public(friend) fun set_update_interval(arg0: &mut OracleConfig, arg1: u64) {
        check_version(arg0);
        arg0.update_interval = arg1;
        let v0 = UpdateIntervalSet{update_interval: arg1};
        0x2::event::emit<UpdateIntervalSet>(v0);
    }

    public fun update_interval(arg0: &OracleConfig) : u64 {
        arg0.update_interval
    }

    public fun update_price(arg0: &mut OracleConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String) {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = get_current_price(arg0, arg2, arg1);
        let v2 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg3);
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg1);
        assert!(v2.aggregator == 0x2::object::id_to_address(&v3), 2004);
        v2.price = v1;
        v2.last_updated = v0;
        let v4 = AssetPriceUpdated{
            asset_type : arg3,
            price      : v1,
            timestamp  : v0,
        };
        0x2::event::emit<AssetPriceUpdated>(v4);
    }

    public(friend) fun upgrade_oracle_config(arg0: &mut OracleConfig) {
        assert!(arg0.version < 2, 2005);
        arg0.version = 2;
        let v0 = OracleConfigUpgraded{
            oracle_config_id : 0x2::object::uid_to_address(&arg0.id),
            version          : 2,
        };
        0x2::event::emit<OracleConfigUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

