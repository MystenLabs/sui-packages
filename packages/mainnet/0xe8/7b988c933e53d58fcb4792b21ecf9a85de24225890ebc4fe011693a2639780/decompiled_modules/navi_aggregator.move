module 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator {
    struct NaviAggregatorCap has key {
        id: 0x2::object::UID,
        creator: address,
        admins: 0x2::table::Table<address, bool>,
        feeders: 0x2::table::Table<address, bool>,
    }

    struct NaviAggregator has store, key {
        id: 0x2::object::UID,
        oracles: 0x2::table::Table<u8, OracleInfo>,
        oracle_list: vector<u8>,
        oracle_count: u8,
        tokens: 0x2::table::Table<u8, TokenInfo>,
        token_ids: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        token_count: u8,
        aggregator_prices: 0x2::table::Table<u8, Price>,
        update_timestamp: u64,
        update_timeout: u64,
        invalid_time: u64,
    }

    struct OracleInfo has store {
        id: u8,
        weight: u64,
        prices: 0x2::table::Table<u8, Price>,
    }

    struct TokenInfo has store {
        id: u8,
        coin_type: 0x1::ascii::String,
        decimal: u8,
    }

    struct Price has store {
        id: u8,
        value: u256,
        timestamp: u64,
    }

    struct SetFeederEvent has copy, drop {
        admin: address,
        feeder: address,
        add: bool,
    }

    struct SetAdminEvent has copy, drop {
        creator: address,
        admin: address,
        add: bool,
    }

    struct SetInvalidTimeEvent has copy, drop {
        admin: address,
        invalid_time: u64,
    }

    struct SetUpdateTimeoutEvent has copy, drop {
        admin: address,
        update_timeout: u64,
    }

    struct RegisterOracleEvent has copy, drop {
        admin: address,
        oracle_id: u8,
        weight: u64,
    }

    struct SetOracleWeightEvent has copy, drop {
        admin: address,
        oracle_id: u8,
        weight: u64,
    }

    struct RegisterTokenEvent has copy, drop {
        admin: address,
        index: u8,
        type_name: 0x1::ascii::String,
        decimal: u8,
    }

    public fun get_token_decimal(arg0: &NaviAggregator, arg1: u8) : (bool, u8) {
        let v0 = &arg0.tokens;
        if (!0x2::table::contains<u8, TokenInfo>(v0, arg1)) {
            return (false, 0)
        };
        (true, 0x2::table::borrow<u8, TokenInfo>(v0, arg1).decimal)
    }

    public fun get_token_info<T0>(arg0: &NaviAggregator) : (bool, u8, u8) {
        let v0 = &arg0.token_ids;
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u8>(v0, v1)) {
            return (false, 0, 0)
        };
        let v2 = *0x2::table::borrow<0x1::type_name::TypeName, u8>(v0, v1);
        (true, v2, 0x2::table::borrow<u8, TokenInfo>(&arg0.tokens, v2).decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAggregator{
            id                : 0x2::object::new(arg0),
            oracles           : 0x2::table::new<u8, OracleInfo>(arg0),
            oracle_list       : 0x1::vector::empty<u8>(),
            oracle_count      : 0,
            tokens            : 0x2::table::new<u8, TokenInfo>(arg0),
            token_ids         : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            token_count       : 0,
            aggregator_prices : 0x2::table::new<u8, Price>(arg0),
            update_timestamp  : 0,
            update_timeout    : 60000,
            invalid_time      : 30000,
        };
        0x2::transfer::share_object<NaviAggregator>(v0);
        let v1 = NaviAggregatorCap{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
            admins  : 0x2::table::new<address, bool>(arg0),
            feeders : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v1.admins, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::share_object<NaviAggregatorCap>(v1);
    }

    fun only_admin(arg0: &NaviAggregatorCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.admins, v0), 60005);
        assert!(*0x2::table::borrow<address, bool>(&arg0.admins, v0), 60005);
    }

    fun only_feeder(arg0: &NaviAggregatorCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.feeders, v0), 60006);
        assert!(*0x2::table::borrow<address, bool>(&arg0.feeders, v0), 60006);
    }

    public entry fun register_oracle(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg4);
        assert!(!0x2::table::contains<u8, OracleInfo>(&mut arg1.oracles, arg2), 60002);
        let v0 = OracleInfo{
            id     : arg2,
            weight : arg3,
            prices : 0x2::table::new<u8, Price>(arg4),
        };
        0x2::table::add<u8, OracleInfo>(&mut arg1.oracles, arg2, v0);
        0x1::vector::push_back<u8>(&mut arg1.oracle_list, arg2);
        arg1.oracle_count = arg1.oracle_count + 1;
        let v1 = RegisterOracleEvent{
            admin     : 0x2::tx_context::sender(arg4),
            oracle_id : arg2,
            weight    : arg3,
        };
        0x2::event::emit<RegisterOracleEvent>(v1);
    }

    public entry fun register_token<T0>(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg1.token_ids;
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u8>(v1, v0), 60003);
        let v2 = arg1.token_count;
        let v3 = TokenInfo{
            id        : v2,
            coin_type : 0x1::type_name::into_string(v0),
            decimal   : arg2,
        };
        0x2::table::add<u8, TokenInfo>(&mut arg1.tokens, v2, v3);
        0x2::table::add<0x1::type_name::TypeName, u8>(v1, v0, v2);
        arg1.token_count = v2 + 1;
        let v4 = RegisterTokenEvent{
            admin     : 0x2::tx_context::sender(arg3),
            index     : v2,
            type_name : 0x1::type_name::into_string(v0),
            decimal   : arg2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_admin(arg0: &mut NaviAggregatorCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 60005);
        if (!0x2::table::contains<address, bool>(&arg0.admins, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.admins, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.admins, arg1) = arg2;
        };
        let v0 = SetAdminEvent{
            creator : 0x2::tx_context::sender(arg3),
            admin   : arg1,
            add     : arg2,
        };
        0x2::event::emit<SetAdminEvent>(v0);
    }

    public entry fun set_feeder(arg0: &mut NaviAggregatorCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 60005);
        if (!0x2::table::contains<address, bool>(&arg0.feeders, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.feeders, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.feeders, arg1) = arg2;
        };
        let v0 = SetFeederEvent{
            admin  : 0x2::tx_context::sender(arg3),
            feeder : arg1,
            add    : arg2,
        };
        0x2::event::emit<SetFeederEvent>(v0);
    }

    public entry fun set_invalid_time(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        arg1.invalid_time = arg2;
        let v0 = SetInvalidTimeEvent{
            admin        : 0x2::tx_context::sender(arg3),
            invalid_time : arg2,
        };
        0x2::event::emit<SetInvalidTimeEvent>(v0);
    }

    public entry fun set_oracle_weight(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg4);
        let v0 = &mut arg1.oracles;
        assert!(0x2::table::contains<u8, OracleInfo>(v0, arg2), 60001);
        0x2::table::borrow_mut<u8, OracleInfo>(v0, arg2).weight = arg3;
        let v1 = SetOracleWeightEvent{
            admin     : 0x2::tx_context::sender(arg4),
            oracle_id : arg2,
            weight    : arg3,
        };
        0x2::event::emit<SetOracleWeightEvent>(v1);
    }

    public entry fun set_update_timeout(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        arg1.update_timeout = arg2;
        let v0 = SetUpdateTimeoutEvent{
            admin          : 0x2::tx_context::sender(arg3),
            update_timeout : arg2,
        };
        0x2::event::emit<SetUpdateTimeoutEvent>(v0);
    }

    public entry fun update_aggregate_price(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::OracleFeederCap, arg3: &mut 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0x1::vector::empty<u8>();
        while (v1 < (0x2::table::length<u8, TokenInfo>(&arg1.tokens) as u8)) {
            let v4 = 0;
            let v5 = 0;
            let v6 = 0;
            let v7 = 0;
            while (v4 < (0x1::vector::length<u8>(&arg1.oracle_list) as u8)) {
                let v8 = 0x2::table::borrow<u8, OracleInfo>(&arg1.oracles, *0x1::vector::borrow<u8>(&arg1.oracle_list, (v4 as u64)));
                let v9 = v8.weight;
                if (v9 == 0) {
                    v4 = v4 + 1;
                    continue
                };
                if (0x2::table::contains<u8, Price>(&v8.prices, v1)) {
                    let v10 = 0x2::table::borrow<u8, Price>(&v8.prices, v1);
                    if (v0 > v10.timestamp + arg1.invalid_time) {
                        v4 = v4 + 1;
                        continue
                    };
                    if (v10.value == 0) {
                        v4 = v4 + 1;
                        continue
                    };
                    v6 = v6 + v10.value * (v9 as u256);
                    v5 = v5 + v9;
                    if (v10.timestamp > v7) {
                        v7 = v10.timestamp;
                    };
                };
                v4 = v4 + 1;
            };
            if (v6 > 0) {
                let v11 = v6 / (v5 as u256);
                0x1::vector::push_back<u8>(&mut v3, v1);
                0x1::vector::push_back<u256>(&mut v2, v11);
                let v12 = &mut arg1.aggregator_prices;
                update_internal_price(v12, v1, v11, v7);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u8>(&v3) > 0) {
            arg1.update_timestamp = v0;
            0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price_batch(arg2, arg4, arg3, v3, v2);
        };
    }

    fun update_internal_price(arg0: &mut 0x2::table::Table<u8, Price>, arg1: u8, arg2: u256, arg3: u64) {
        if (!0x2::table::contains<u8, Price>(arg0, arg1)) {
            let v0 = Price{
                id        : arg1,
                value     : arg2,
                timestamp : arg3,
            };
            0x2::table::add<u8, Price>(arg0, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<u8, Price>(arg0, arg1);
            v1.value = arg2;
            v1.timestamp = arg3;
        };
    }

    public fun update_internal_token_price_batch(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u8, arg3: vector<u8>, arg4: vector<u256>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg6);
        let v0 = &mut arg1.oracles;
        assert!(0x2::table::contains<u8, OracleInfo>(v0, arg2), 60001);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v1 == 0x1::vector::length<u256>(&arg4), 60004);
        assert!(v1 == 0x1::vector::length<u64>(&arg5), 60004);
        let v2 = 0;
        let v3 = &mut 0x2::table::borrow_mut<u8, OracleInfo>(v0, arg2).prices;
        while (v2 < v1) {
            update_internal_price(v3, *0x1::vector::borrow<u8>(&arg3, v2), *0x1::vector::borrow<u256>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2));
            v2 = v2 + 1;
        };
    }

    public fun update_token_price<T0>(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: u8, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg5);
        let v0 = &mut arg1.oracles;
        assert!(0x2::table::contains<u8, OracleInfo>(v0, arg2), 60001);
        let v1 = 0x2::table::borrow_mut<u8, OracleInfo>(v0, arg2);
        if (v1.weight == 0) {
            return
        };
        let v2 = &arg1.token_ids;
        assert!(0x2::table::contains<0x1::type_name::TypeName, u8>(v2, 0x1::type_name::get<T0>()), 60000);
        let v3 = &mut v1.prices;
        update_internal_price(v3, *0x2::table::borrow<0x1::type_name::TypeName, u8>(v2, 0x1::type_name::get<T0>()), arg3, arg4);
    }

    public fun update_token_price_batch(arg0: &NaviAggregatorCap, arg1: &mut NaviAggregator, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::OracleFeederCap, arg3: &mut 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg4: &0x2::clock::Clock, arg5: u8, arg6: vector<u8>, arg7: vector<u256>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        update_internal_token_price_batch(arg0, arg1, arg5, arg6, arg7, arg8, arg9);
        if (0x2::clock::timestamp_ms(arg4) < arg1.update_timestamp + arg1.update_timeout) {
            return
        };
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price_batch(arg2, arg4, arg3, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

