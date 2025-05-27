module 0x409e14fb772ccb47071d88c20d2e62dc797964ddabf45a87163cb4d3c6989114::vault_oracle {
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
        coin_decimals: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        update_interval: u64,
    }

    struct UpdateIntervalSet has copy, drop {
        update_interval: u64,
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

    public(friend) fun add_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u8, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        check_version(arg0);
        assert!(!0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 1003);
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
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 1001);
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
        assert!(arg0.version == 1, 1005);
    }

    public fun denormalize_amount<T0>(arg0: &OracleConfig, arg1: u64) : u64 {
        arg1 / 0x1::u64::pow(10, *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals, 0x1::type_name::get<T0>()))
    }

    public fun get_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 1001);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2);
        assert!(0x1::u64::diff(v0.last_updated, 0x2::clock::timestamp_ms(arg1)) < arg0.update_interval, 1002);
        v0.price
    }

    public fun get_current_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : u256 {
        check_version(arg0);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) - 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v0) < arg0.update_interval, 1002);
        (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0)) as u256)
    }

    public fun get_normalized_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2).decimals;
        let v1 = if (v0 < 9) {
            (0x1::u64::pow(10, 9 - v0) as u256)
        } else {
            (0x1::u64::pow(10, v0 - 9) as u256)
        };
        get_asset_price(arg0, arg1, arg2) * v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id              : 0x2::object::new(arg0),
            version         : 1,
            aggregators     : 0x2::table::new<0x1::ascii::String, PriceInfo>(arg0),
            coin_decimals   : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            update_interval : 60000,
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    public fun normalize_amount<T0>(arg0: &OracleConfig, arg1: u256) : u256 {
        arg1 * (0x1::u64::pow(10, *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals, 0x1::type_name::get<T0>())) as u256)
    }

    public(friend) fun remove_switchboard_aggregator(arg0: &mut OracleConfig, arg1: 0x1::ascii::String) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1), 1001);
        let v0 = SwitchboardAggregatorRemoved{
            asset_type : arg1,
            aggregator : 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).aggregator,
        };
        0x2::event::emit<SwitchboardAggregatorRemoved>(v0);
        0x2::table::remove<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg1);
    }

    public(friend) fun set_coin_decimals<T0>(arg0: &mut OracleConfig, arg1: u8) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.coin_decimals, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u8>(&mut arg0.coin_decimals, v0) = arg1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.coin_decimals, v0, arg1);
        };
    }

    public(friend) fun set_update_interval(arg0: &mut OracleConfig, arg1: u64) {
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
        assert!(v2.aggregator == 0x2::object::id_to_address(&v3), 1004);
        v2.price = v1;
        v2.last_updated = v0;
        let v4 = PriceUpdated{
            price     : v1,
            timestamp : v0,
        };
        0x2::event::emit<PriceUpdated>(v4);
    }

    public(friend) fun upgrade_oracle_config(arg0: &mut OracleConfig) {
        assert!(arg0.version < 1, 1005);
        arg0.version = 1;
        let v0 = OracleConfigUpgraded{
            oracle_config_id : 0x2::object::uid_to_address(&arg0.id),
            version          : 1,
        };
        0x2::event::emit<OracleConfigUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

