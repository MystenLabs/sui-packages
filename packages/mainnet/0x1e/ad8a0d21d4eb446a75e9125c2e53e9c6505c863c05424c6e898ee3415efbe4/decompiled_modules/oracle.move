module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct UpdateCap has key {
        id: 0x2::object::UID,
        for: address,
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

    struct PriceEvent has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        ts_ms: u64,
    }

    struct UpdateAuthority has key {
        id: 0x2::object::UID,
        authority: vector<address>,
    }

    public fun burn_manager_cap(arg0: ManagerCap) {
        let ManagerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_update_authority(arg0: UpdateAuthority) {
        let UpdateAuthority {
            id        : v0,
            authority : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun burn_update_cap(arg0: &ManagerCap, arg1: UpdateCap) {
        let UpdateCap {
            id  : v0,
            for : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun copy_manager_cap(arg0: &ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ManagerCap>(v0, arg1);
    }

    entry fun create_update_cap(arg0: &ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCap{
            id  : 0x2::object::new(arg2),
            for : arg1,
        };
        0x2::transfer::share_object<UpdateCap>(v0);
    }

    public fun get_oracle(arg0: &Oracle) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 13906835875151151116);
        (arg0.price, arg0.decimal)
    }

    public fun get_price_with_interval_ms(arg0: &Oracle, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.ts_ms < arg0.time_interval && v0 - arg0.ts_ms <= arg2, 13906835956755529740);
        (arg0.price, arg0.decimal)
    }

    public fun get_token(arg0: &Oracle) : (0x1::ascii::String, 0x1::ascii::String, 0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.base_token, arg0.quote_token, arg0.base_token_type, arg0.quote_token_type)
    }

    public fun get_twap_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 13906835913805856780);
        (arg0.twap_price, arg0.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_oracle<T0, T1>(arg0: &ManagerCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id               : 0x2::object::new(arg4),
            base_token       : arg1,
            quote_token      : arg2,
            base_token_type  : 0x1::type_name::with_defining_ids<T0>(),
            quote_token_type : 0x1::type_name::with_defining_ids<T1>(),
            decimal          : arg3,
            price            : 0,
            twap_price       : 0,
            ts_ms            : 0,
            epoch            : 0x2::tx_context::epoch(arg4),
            time_interval    : 300000,
            switchboard      : 0x1::option::none<0x2::object::ID>(),
            pyth             : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"VERSION"), 2);
        0x2::transfer::share_object<Oracle>(v0);
    }

    public fun update(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    fun update_(arg0: &mut Oracle, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906835746301476866);
        assert!(arg2 > 0, 13906835750596444162);
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
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD") || arg0.base_token == 0x1::ascii::string(b"USD"), 13906835187956252682);
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    entry fun update_pyth_oracle_usd_reciprocal(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD"), 13906835239495860234);
        arg0.pyth = 0x1::option::none<0x2::object::ID>();
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"reciprocal_pyth"), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun update_time_interval(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64) {
        version_check(arg0);
        arg0.time_interval = arg2;
    }

    public fun update_token(arg0: &mut Oracle, arg1: &ManagerCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        version_check(arg0);
        arg0.quote_token = arg2;
        arg0.base_token = arg3;
    }

    public fun update_v2(arg0: &mut Oracle, arg1: &UpdateAuthority, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun update_version(arg0: &mut Oracle, arg1: &ManagerCap) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"VERSION"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"VERSION")) = 2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"VERSION"), 2);
        };
    }

    public fun update_with_pyth(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth), 13906835312510304266);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth) == &v0, 13906835316804878340);
        let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3);
        assert!(0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"quote_price_info_object")) == &v1, 13906835321099845636);
        let (v2, v3, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg4);
        let (v5, v6, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg3, arg4);
        assert!(v2 > 0, 13906835338279583746);
        assert!(v5 > 0, 13906835342574551042);
        let v8 = (((v2 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) * (0x1::u64::pow(10, (v6 as u8)) as u256) / (0x1::u64::pow(10, (v3 as u8)) as u256) / (v5 as u256)) as u64);
        let (v9, v10, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        let (v12, v13, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg3);
        assert!(v9 > 0, 13906835376934289410);
        assert!(v12 > 0, 13906835381229256706);
        arg0.price = v8;
        arg0.twap_price = (((v9 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) * (0x1::u64::pow(10, (v13 as u8)) as u256) / (0x1::u64::pow(10, (v10 as u8)) as u256) / (v12 as u256)) as u64);
        arg0.ts_ms = 0x2::clock::timestamp_ms(arg4);
        arg0.epoch = 0x2::tx_context::epoch(arg5);
        let v15 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v8,
            ts_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PriceEvent>(v15);
    }

    public fun update_with_pyth_usd(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD") || arg0.base_token == 0x1::ascii::string(b"USD"), 13906835501488865290);
        let v0 = false;
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"reciprocal_pyth"))) {
            v0 = true;
            let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
            assert!(0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"reciprocal_pyth")) == &v1, 13906835522963308548);
        } else {
            assert!(arg0.pyth == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)), 13906835531553243140);
        };
        let (v2, v3, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg3);
        assert!(v2 > 0, 13906835548732981250);
        let v5 = (((v2 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) / (0x1::u64::pow(10, (v3 as u8)) as u256)) as u64);
        let v6 = v5;
        let (v7, v8, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        assert!(v7 > 0, 13906835570207817730);
        let v10 = (((v7 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) / (0x1::u64::pow(10, (v8 as u8)) as u256)) as u64);
        let v11 = v10;
        if (v0) {
            v6 = 0x1::u64::pow(10, ((arg0.decimal * 2) as u8)) / v5;
            v11 = 0x1::u64::pow(10, ((arg0.decimal * 2) as u8)) / v10;
        };
        arg0.price = v6;
        arg0.twap_price = v11;
        arg0.ts_ms = 0x2::clock::timestamp_ms(arg3);
        arg0.epoch = 0x2::tx_context::epoch(arg4);
        let v12 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v6,
            ts_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PriceEvent>(v12);
    }

    public fun update_with_update_cap(arg0: &mut Oracle, arg1: &UpdateCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg1.for == 0x2::tx_context::sender(arg5), 13906834994682462214);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    fun version_check(arg0: &Oracle) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"VERSION"))) {
            assert!(2 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"VERSION")), 13906835690467295240);
        };
        abort 13906835703352197128
    }

    // decompiled from Move bytecode v6
}

