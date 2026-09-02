module 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle {
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

    struct PythAggregatorAdded has copy, drop {
        asset_type: 0x1::ascii::String,
        aggregator: address,
    }

    struct SwitchboardAggregatorRemoved has copy, drop {
        asset_type: 0x1::ascii::String,
        aggregator: address,
    }

    struct PythAggregatorRemoved has copy, drop {
        asset_type: 0x1::ascii::String,
        aggregator: address,
    }

    struct SwitchboardAggregatorChanged has copy, drop {
        asset_type: 0x1::ascii::String,
        old_aggregator: address,
        new_aggregator: address,
    }

    struct PythAggregatorChanged has copy, drop {
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

    public(friend) fun add_pyth_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u8, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        check_version(arg0);
        assert!(!0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 2003);
        let v0 = get_pyth_object_identifier(arg5);
        assert!(!is_rate_feed(v0), 2010);
        let v1 = PriceInfo{
            aggregator   : v0,
            decimals     : arg3,
            price        : get_current_price_v2(arg0, arg1, arg4, arg5),
            last_updated : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg2, v1);
        let v2 = PythAggregatorAdded{
            asset_type : arg2,
            aggregator : v0,
        };
        0x2::event::emit<PythAggregatorAdded>(v2);
    }

    public(friend) fun add_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u8, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        abort 2009
    }

    public fun asset_aggregator(arg0: &OracleConfig, arg1: 0x1::ascii::String) : address {
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1), 2001);
        0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).aggregator
    }

    public fun asset_price_last_updated(arg0: &OracleConfig, arg1: 0x1::ascii::String) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1), 2001);
        0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).last_updated
    }

    public(friend) fun change_pyth_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2), 2001);
        let v0 = get_pyth_object_identifier(arg4);
        assert!(!is_rate_feed(v0), 2010);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg2);
        let v2 = PythAggregatorChanged{
            asset_type     : arg2,
            old_aggregator : v1.aggregator,
            new_aggregator : v0,
        };
        0x2::event::emit<PythAggregatorChanged>(v2);
        v1.aggregator = v0;
        v1.price = get_current_price_v2(arg0, arg1, arg3, arg4);
        v1.last_updated = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun change_switchboard_aggregator(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        abort 2009
    }

    public(friend) fun check_version(arg0: &OracleConfig) {
        assert!(arg0.version == 5, 2005);
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
        abort 2009
    }

    public fun get_current_price_v2(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u256 {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price(arg2, arg3, arg1);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v1) * 1000;
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v2), 2007);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3), 2007);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v3);
        assert!(v5 <= 36, 2007);
        assert!(v4 <= v0 + 60000, 2006);
        if (v0 >= v4) {
            assert!(v0 - v4 < arg0.update_interval, 2002);
        };
        let v6 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_utils::to_oracle_decimal((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v2) as u256), v5);
        assert!(v6 > 0, 2007);
        v6
    }

    public fun get_normalized_asset_price(arg0: &OracleConfig, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) : u256 {
        let v0 = 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg2).decimals;
        if (v0 < 9) {
            get_asset_price(arg0, arg1, arg2) * (0x1::u64::pow(10, 9 - v0) as u256)
        } else {
            get_asset_price(arg0, arg1, arg2) / (0x1::u64::pow(10, v0 - 9) as u256)
        }
    }

    public fun get_pyth_object_identifier(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : address {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        0x2::address::from_bytes(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1))
    }

    public fun has_aggregator(arg0: &OracleConfig, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id              : 0x2::object::new(arg0),
            version         : 5,
            aggregators     : 0x2::table::new<0x1::ascii::String, PriceInfo>(arg0),
            update_interval : 60000,
            dex_slippage    : 100,
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    fun is_rate_feed(arg0: address) : bool {
        arg0 == @0x77a89fd7818905d056d1ba2a841868ad932fd32260a98a2205c5db28e02ea736
    }

    public(friend) fun remove_pyth_aggregator(arg0: &mut OracleConfig, arg1: 0x1::ascii::String) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1), 2001);
        let v0 = PythAggregatorRemoved{
            asset_type : arg1,
            aggregator : 0x2::table::borrow<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg1).aggregator,
        };
        0x2::event::emit<PythAggregatorRemoved>(v0);
        0x2::table::remove<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg1);
    }

    public(friend) fun remove_switchboard_aggregator(arg0: &mut OracleConfig, arg1: 0x1::ascii::String) {
        abort 2009
    }

    public(friend) fun set_dex_slippage(arg0: &mut OracleConfig, arg1: u256) {
        check_version(arg0);
        arg0.dex_slippage = arg1;
        let v0 = DexSlippageSet{dex_slippage: arg1};
        0x2::event::emit<DexSlippageSet>(v0);
    }

    public(friend) fun set_pyth_aggregator_for_vsui(arg0: &mut OracleConfig, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        check_version(arg0);
        let v0 = get_pyth_object_identifier(arg1);
        assert!(is_rate_feed(v0), 2011);
        let v1 = vsui_asset_type();
        if (0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, v1)) {
            let v2 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, v1);
            let v3 = PythAggregatorChanged{
                asset_type     : v1,
                old_aggregator : v2.aggregator,
                new_aggregator : v0,
            };
            0x2::event::emit<PythAggregatorChanged>(v3);
            v2.aggregator = v0;
            v2.price = 0;
            v2.last_updated = 0;
        } else {
            let v4 = PriceInfo{
                aggregator   : v0,
                decimals     : 9,
                price        : 0,
                last_updated : 0,
            };
            0x2::table::add<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, v1, v4);
            let v5 = PythAggregatorAdded{
                asset_type : v1,
                aggregator : v0,
            };
            0x2::event::emit<PythAggregatorAdded>(v5);
        };
    }

    public(friend) fun set_update_interval(arg0: &mut OracleConfig, arg1: u64) {
        check_version(arg0);
        assert!(arg1 > 0 && arg1 <= 60000, 2008);
        arg0.update_interval = arg1;
        let v0 = UpdateIntervalSet{update_interval: arg1};
        0x2::event::emit<UpdateIntervalSet>(v0);
    }

    public fun update_interval(arg0: &OracleConfig) : u64 {
        arg0.update_interval
    }

    public fun update_price(arg0: &mut OracleConfig, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String) {
        abort 2009
    }

    public fun update_price_v2(arg0: &mut OracleConfig, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String) {
        check_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg4), 2001);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = get_pyth_object_identifier(arg2);
        assert!(!is_rate_feed(v1), 2010);
        let v2 = get_current_price_v2(arg0, arg3, arg1, arg2);
        let v3 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg4);
        assert!(v3.aggregator == v1, 2004);
        v3.price = v2;
        v3.last_updated = v0;
        let v4 = AssetPriceUpdated{
            asset_type : arg4,
            price      : v2,
            timestamp  : v0,
        };
        0x2::event::emit<AssetPriceUpdated>(v4);
    }

    public fun update_price_v2_for_vsui(arg0: &mut OracleConfig, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String) {
        check_version(arg0);
        assert!(arg5 == vsui_asset_type(), 2014);
        assert!(0x2::table::contains<0x1::ascii::String, PriceInfo>(&arg0.aggregators, arg5), 2001);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(get_pyth_object_identifier(arg2) == @0x23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744, 2012);
        let v1 = get_pyth_object_identifier(arg3);
        assert!(is_rate_feed(v1), 2011);
        let v2 = get_current_price_v2(arg0, arg4, arg1, arg3);
        assert!(v2 >= 1000000000000000000 && v2 <= 2000000000000000000, 2013);
        let v3 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_utils::mul_with_oracle_price(get_current_price_v2(arg0, arg4, arg1, arg2), v2);
        assert!(v3 > 0, 2007);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, PriceInfo>(&mut arg0.aggregators, arg5);
        assert!(v4.aggregator == v1, 2004);
        v4.price = v3;
        v4.last_updated = v0;
        let v5 = AssetPriceUpdated{
            asset_type : arg5,
            price      : v3,
            timestamp  : v0,
        };
        0x2::event::emit<AssetPriceUpdated>(v5);
    }

    public(friend) fun upgrade_oracle_config(arg0: &mut OracleConfig) {
        assert!(arg0.version < 5, 2005);
        arg0.version = 5;
        let v0 = OracleConfigUpgraded{
            oracle_config_id : 0x2::object::uid_to_address(&arg0.id),
            version          : 5,
        };
        0x2::event::emit<OracleConfigUpgraded>(v0);
    }

    public fun vsui_asset_type() : 0x1::ascii::String {
        0x1::ascii::string(b"549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT")
    }

    // decompiled from Move bytecode v7
}

