module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        base_token: 0x1::ascii::String,
        quote_token: 0x1::ascii::String,
        base_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        decimal: u64,
        price: u64,
        twap_price: u64,
        ts_ms: u64,
        epoch: u64,
        time_interval: u64,
        switchboard: 0x1::option::Option<0x2::object::ID>,
        pyth: 0x1::option::Option<0x2::object::ID>,
    }

    struct UpdateAuthority has key {
        id: 0x2::object::UID,
        authority: vector<address>,
    }

    struct PriceEvent has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        ts_ms: u64,
    }

    entry fun add_update_authority(arg0: &ManagerCap, arg1: &mut UpdateAuthority, arg2: vector<address>) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x1::vector::push_back<address>(&mut arg1.authority, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public entry fun copy_manager_cap(arg0: &ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ManagerCap>(v0, arg1);
    }

    public fun get_oracle(arg0: &Oracle) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.price, arg0.decimal)
    }

    public fun get_price_with_interval_ms(arg0: &Oracle, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.ts_ms < arg0.time_interval && v0 - arg0.ts_ms <= arg2, 1);
        (arg0.price, arg0.decimal)
    }

    public fun get_token(arg0: &Oracle) : (0x1::ascii::String, 0x1::ascii::String, 0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.base_token, arg0.quote_token, arg0.base_token_type, arg0.quote_token_type)
    }

    public fun get_twap_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.twap_price, arg0.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_oracle<T0, T1>(arg0: &ManagerCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id               : 0x2::object::new(arg4),
            base_token       : arg1,
            quote_token      : arg2,
            base_token_type  : 0x1::type_name::get<T0>(),
            quote_token_type : 0x1::type_name::get<T1>(),
            decimal          : arg3,
            price            : 0,
            twap_price       : 0,
            ts_ms            : 0,
            epoch            : 0x2::tx_context::epoch(arg4),
            time_interval    : 300000,
            switchboard      : 0x1::option::none<0x2::object::ID>(),
            pyth             : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Oracle>(v0);
    }

    entry fun new_update_authority(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg1));
        let v1 = UpdateAuthority{
            id        : 0x2::object::new(arg1),
            authority : v0,
        };
        0x2::transfer::share_object<UpdateAuthority>(v1);
    }

    public entry fun update(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    fun update_(arg0: &mut Oracle, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.price = arg1;
        arg0.twap_price = arg2;
        arg0.ts_ms = v0;
        arg0.epoch = 0x2::tx_context::epoch(arg4);
        let v1 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : arg1,
            ts_ms : v0,
        };
        0x2::event::emit<PriceEvent>(v1);
    }

    entry fun update_pyth_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"quote_price_info_object"), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3));
    }

    entry fun update_pyth_oracle_usd(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD"), 5);
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    entry fun update_pyth_oracle_usd_reciprocal(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD"), 5);
        arg0.pyth = 0x1::option::none<0x2::object::ID>();
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"reciprocal_pyth"), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    entry fun update_supra_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u32) {
        version_check(arg0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"supra_pair"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u32>(&mut arg0.id, 0x1::string::utf8(b"supra_pair")) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u32>(&mut arg0.id, 0x1::string::utf8(b"supra_pair"), arg2);
        };
    }

    entry fun update_switchboard_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        version_check(arg0);
        arg0.switchboard = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg2));
    }

    public entry fun update_time_interval(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64) {
        version_check(arg0);
        arg0.time_interval = arg2;
    }

    public entry fun update_token(arg0: &mut Oracle, arg1: &ManagerCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        version_check(arg0);
        arg0.quote_token = arg2;
        arg0.base_token = arg3;
    }

    public entry fun update_v2(arg0: &mut Oracle, arg1: &UpdateAuthority, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x1::vector::contains<address>(&arg1.authority, &v0);
        version_check(arg0);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun update_version(arg0: &mut Oracle, arg1: &ManagerCap) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"VERSION"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"VERSION")) = 1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"VERSION"), 1);
        };
    }

    public fun update_with_pyth(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth), 5);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth) == &v0, 6);
        let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3);
        assert!(0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"quote_price_info_object")) == &v1, 6);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg4);
        assert!(v2 > 0, 2);
        let v4 = if (v3 > arg0.decimal) {
            v2 / 0x1::u64::pow(10, ((v3 - arg0.decimal) as u8))
        } else {
            v2 * 0x1::u64::pow(10, ((arg0.decimal - v3) as u8))
        };
        let (v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg3, arg4);
        assert!(v5 > 0, 2);
        let v7 = (((v4 as u128) * (0x1::u64::pow(10, (v6 as u8)) as u128) / (v5 as u128)) as u64);
        arg0.price = v7;
        let v8 = 0x2::clock::timestamp_ms(arg4);
        arg0.ts_ms = v8;
        arg0.epoch = 0x2::tx_context::epoch(arg5);
        let (v9, v10, v11) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        assert!(v9 > 0, 2);
        assert!(v8 / 1000 - v11 < arg0.time_interval, 1);
        let v12 = if (v10 > arg0.decimal) {
            v9 / 0x1::u64::pow(10, ((v10 - arg0.decimal) as u8))
        } else {
            v9 * 0x1::u64::pow(10, ((arg0.decimal - v10) as u8))
        };
        let (v13, v14, v15) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg3);
        assert!(v13 > 0, 2);
        assert!(v8 / 1000 - v15 < arg0.time_interval, 1);
        arg0.twap_price = (((v12 as u128) * (0x1::u64::pow(10, (v14 as u8)) as u128) / (v13 as u128)) as u64);
        let v16 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v7,
            ts_ms : v8,
        };
        0x2::event::emit<PriceEvent>(v16);
    }

    public fun update_with_pyth_usd(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD"), 5);
        let v0 = false;
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"reciprocal_pyth"))) {
            v0 = true;
            let v1 = *0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"reciprocal_pyth"));
            let v2 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
            assert!(&v1 == &v2, 6);
        } else {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth), 5);
            let v3 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
            assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth) == &v3, 6);
        };
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg3);
        assert!(v4 > 0, 2);
        let v6 = if (v5 > arg0.decimal) {
            v4 / 0x1::u64::pow(10, ((v5 - arg0.decimal) as u8))
        } else {
            v4 * 0x1::u64::pow(10, ((arg0.decimal - v5) as u8))
        };
        let v7 = if (v0) {
            0x1::u64::pow(10, ((arg0.decimal * 2) as u8)) / v6
        } else {
            v6
        };
        arg0.price = v7;
        let v8 = 0x2::clock::timestamp_ms(arg3);
        arg0.ts_ms = v8;
        arg0.epoch = 0x2::tx_context::epoch(arg4);
        let (v9, v10, v11) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        assert!(v9 > 0, 2);
        assert!(v8 / 1000 - v11 < arg0.time_interval, 1);
        let v12 = if (v10 > arg0.decimal) {
            v9 / 0x1::u64::pow(10, ((v10 - arg0.decimal) as u8))
        } else {
            v9 * 0x1::u64::pow(10, ((arg0.decimal - v10) as u8))
        };
        if (v0) {
            arg0.twap_price = 0x1::u64::pow(10, ((arg0.decimal * 2) as u8)) / v12;
        } else {
            arg0.twap_price = v12;
        };
        let v13 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v7,
            ts_ms : v8,
        };
        0x2::event::emit<PriceEvent>(v13);
    }

    entry fun update_with_supra(arg0: &mut Oracle, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::supra::retrieve_price(arg1, *0x2::dynamic_field::borrow<0x1::string::String, u32>(&arg0.id, 0x1::string::utf8(b"supra_pair")));
        assert!(v0 > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        assert!(v3 - (v2 as u64) < arg0.time_interval, 1);
        let v4 = (arg0.decimal as u16);
        let v5 = if (v1 > v4) {
            v0 / (0x1::u64::pow(10, ((v1 - v4) as u8)) as u128)
        } else {
            v0 * (0x1::u64::pow(10, ((v4 - v1) as u8)) as u128)
        };
        let v6 = (v5 as u64);
        arg0.price = v6;
        arg0.twap_price = v6;
        arg0.ts_ms = v3;
        arg0.epoch = 0x2::tx_context::epoch(arg3);
        let v7 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v6,
            ts_ms : v3,
        };
        0x2::event::emit<PriceEvent>(v7);
    }

    entry fun update_with_switchboard(arg0: &mut Oracle, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.switchboard), 3);
        let v0 = 0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.switchboard) == &v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::switchboard_feed_parser::log_aggregator_info(arg1);
        assert!(v2 > 0, 2);
        let v4 = (v3 as u64);
        let v5 = if (v4 > arg0.decimal) {
            v2 / (0x1::u64::pow(10, ((v4 - arg0.decimal) as u8)) as u128)
        } else {
            v2 * (0x1::u64::pow(10, ((arg0.decimal - v4) as u8)) as u128)
        };
        let v6 = (v5 as u64);
        arg0.price = v6;
        arg0.twap_price = v6;
        arg0.ts_ms = v1;
        arg0.epoch = 0x2::tx_context::epoch(arg3);
        let v7 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v6,
            ts_ms : v1,
        };
        0x2::event::emit<PriceEvent>(v7);
    }

    fun version_check(arg0: &Oracle) {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"VERSION")), 7);
        assert!(1 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"VERSION")), 7);
    }

    // decompiled from Move bytecode v6
}

