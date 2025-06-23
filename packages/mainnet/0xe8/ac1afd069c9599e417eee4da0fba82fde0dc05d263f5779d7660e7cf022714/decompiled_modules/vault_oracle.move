module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle {
    struct PriceInfo has store {
        aggregator: address,
        price: u256,
        last_updated: u64,
    }

    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        aggregators: 0x2::table::Table<0x1::ascii::String, PriceInfo>,
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
        aggregator: address,
    }

    public(friend) fun add_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        assert!(!0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 1002);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg3);
        let v1 = PriceInfo{
            aggregator   : 0x2::object::id_to_address(&v0),
            price        : get_current_price(arg0, arg1, arg3),
            last_updated : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg2, v1);
        let v2 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg3);
        let v3 = SwitchboardAggregatorAdded{aggregator: 0x2::object::id_to_address(&v2)};
        0x2::event::emit<SwitchboardAggregatorAdded>(v3);
    }

    public fun get_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 1000);
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2);
        assert!(0x1::u64::diff(v0.last_updated, 0x2::clock::timestamp_ms(arg1)) < 60000, 1001);
        v0.price
    }

    public fun get_current_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : u256 {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) - 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v0) < arg0.update_interval, 1001);
        (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0)) as u256)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id              : 0x2::object::new(arg0),
            aggregators     : 0x2::table::new<0x1::ascii::String, PriceInfo>(arg0),
            update_interval : 60000,
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    public(friend) fun set_update_interval(arg0: &mut OracleConfig, arg1: u64) {
        arg0.update_interval = arg1;
        let v0 = UpdateIntervalSet{update_interval: arg1};
        0x2::event::emit<UpdateIntervalSet>(v0);
    }

    public fun update_price(arg0: &mut OracleConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = get_current_price(arg0, arg2, arg1);
        let v2 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg3);
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg1);
        assert!(v2.aggregator == 0x2::object::id_to_address(&v3), 1003);
        v2.price = v1;
        v2.last_updated = v0;
        let v4 = PriceUpdated{
            price     : v1,
            timestamp : v0,
        };
        0x2::event::emit<PriceUpdated>(v4);
    }

    // decompiled from Move bytecode v6
}

