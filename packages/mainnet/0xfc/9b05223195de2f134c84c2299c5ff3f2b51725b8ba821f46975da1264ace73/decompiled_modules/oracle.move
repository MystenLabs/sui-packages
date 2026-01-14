module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct UpdateCap has key {
        id: 0x2::object::UID,
        for: address,
    }

    struct UpdateCaps has key {
        id: 0x2::object::UID,
        for: vector<address>,
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

    struct UpdateTimeIntervalEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        time_interval: u64,
    }

    struct UpdateTokenNameEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        quote_token: 0x1::ascii::String,
        base_token: 0x1::ascii::String,
    }

    struct UpdatePythOracleEvent has copy, drop {
        oracle_id: 0x2::object::ID,
        base_price_info_object: 0x1::option::Option<0x2::object::ID>,
        quote_price_info_object: 0x1::option::Option<0x2::object::ID>,
    }

    struct UpdateAuthority has key {
        id: 0x2::object::UID,
        authority: vector<address>,
    }

    entry fun add_update_caps_user(arg0: &ManagerCap, arg1: &mut UpdateCaps, arg2: address) {
        if (!0x1::vector::contains<address>(&arg1.for, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.for, arg2);
        };
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

    entry fun burn_update_caps(arg0: &ManagerCap, arg1: UpdateCaps) {
        let UpdateCaps {
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

    entry fun create_update_caps(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCaps{
            id  : 0x2::object::new(arg1),
            for : vector[],
        };
        0x2::transfer::share_object<UpdateCaps>(v0);
    }

    public fun get_oracle(arg0: &Oracle) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 13906836390547226636);
        (arg0.price, arg0.decimal)
    }

    public fun get_price_with_interval_ms(arg0: &Oracle, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.ts_ms < arg0.time_interval && v0 - arg0.ts_ms <= arg2, 13906836472151605260);
        (arg0.price, arg0.decimal)
    }

    public fun get_token(arg0: &Oracle) : (0x1::ascii::String, 0x1::ascii::String, 0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.base_token, arg0.quote_token, arg0.base_token_type, arg0.quote_token_type)
    }

    public fun get_twap_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 13906836429201932300);
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

    entry fun remove_update_caps_user(arg0: &ManagerCap, arg1: &mut UpdateCaps, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.for, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.for, v1);
        };
    }

    public fun update(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    fun update_(arg0: &mut Oracle, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906836261697552386);
        assert!(arg2 > 0, 13906836265992519682);
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

    entry fun update_bls_public_key(arg0: &mut Oracle, arg1: &ManagerCap, arg2: vector<u8>) {
        version_check(arg0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"bls_public_key"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, vector<u8>>(&mut arg0.id, 0x1::string::utf8(b"bls_public_key")) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, vector<u8>>(&mut arg0.id, 0x1::string::utf8(b"bls_public_key"), arg2);
        };
    }

    entry fun update_pyth_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"quote_price_info_object"), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3));
        let v0 = UpdatePythOracleEvent{
            oracle_id               : 0x2::object::id<Oracle>(arg0),
            base_price_info_object  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)),
            quote_price_info_object : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3)),
        };
        0x2::event::emit<UpdatePythOracleEvent>(v0);
    }

    entry fun update_pyth_oracle_usd(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD") || arg0.base_token == 0x1::ascii::string(b"USD"), 13906835694762393610);
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        let v0 = UpdatePythOracleEvent{
            oracle_id               : 0x2::object::id<Oracle>(arg0),
            base_price_info_object  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)),
            quote_price_info_object : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<UpdatePythOracleEvent>(v0);
    }

    public fun update_time_interval(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64) {
        version_check(arg0);
        arg0.time_interval = arg2;
        let v0 = UpdateTimeIntervalEvent{
            oracle_id     : 0x2::object::id<Oracle>(arg0),
            time_interval : arg2,
        };
        0x2::event::emit<UpdateTimeIntervalEvent>(v0);
    }

    public fun update_token(arg0: &mut Oracle, arg1: &ManagerCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        version_check(arg0);
        arg0.quote_token = arg2;
        arg0.base_token = arg3;
        let v0 = UpdateTokenNameEvent{
            oracle_id   : 0x2::object::id<Oracle>(arg0),
            quote_token : arg2,
            base_token  : arg3,
        };
        0x2::event::emit<UpdateTokenNameEvent>(v0);
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
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth), 13906835784956706826);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth) == &v0, 13906835789251280900);
        let v1 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3);
        assert!(0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"quote_price_info_object")) == &v1, 13906835793546248196);
        let (v2, v3, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg4);
        let (v5, v6, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg3, arg4);
        assert!(v2 > 0, 13906835810725986306);
        assert!(v5 > 0, 13906835815020953602);
        let v8 = (((v2 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) * (0x1::u64::pow(10, (v6 as u8)) as u256) / (0x1::u64::pow(10, (v3 as u8)) as u256) / (v5 as u256)) as u64);
        let (v9, v10, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        let (v12, v13, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg3);
        assert!(v9 > 0, 13906835849380691970);
        assert!(v12 > 0, 13906835853675659266);
        let v15 = (((v9 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) * (0x1::u64::pow(10, (v13 as u8)) as u256) / (0x1::u64::pow(10, (v10 as u8)) as u256) / (v12 as u256)) as u64);
        update_(arg0, v8, v15, arg4, arg5);
    }

    public fun update_with_pyth_usd(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg0.quote_token == 0x1::ascii::string(b"USD") || arg0.base_token == 0x1::ascii::string(b"USD") && arg0.quote_token == 0x1::ascii::string(b"JPY"), 13906835939575529482);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"quote_price_info_object")), 13906835948165070852);
        assert!(arg0.pyth == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)), 13906835956755005444);
        let (v0, v1, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg3);
        assert!(v0 > 0, 13906835969639776258);
        let v3 = (((v0 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) / (0x1::u64::pow(10, (v1 as u8)) as u256)) as u64);
        let (v4, v5, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        assert!(v4 > 0, 13906835995409580034);
        let v7 = (((v4 as u256) * (0x1::u64::pow(10, (arg0.decimal as u8)) as u256) / (0x1::u64::pow(10, (v5 as u8)) as u256)) as u64);
        update_(arg0, v3, v7, arg3, arg4);
    }

    public fun update_with_signature(arg0: &mut Oracle, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = b"";
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        assert!(v0 == arg2, 13906836115669450766);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, 0x2::dynamic_field::borrow<0x1::string::String, vector<u8>>(&arg0.id, 0x1::string::utf8(b"bls_public_key")), &arg2), 13906836137144418320);
        let v2 = 0x1::ascii::string(arg3);
        assert!(0x1::type_name::as_string(&arg0.base_token_type) == &v2, 13906836141439516690);
        assert!(0x1::u64::diff(0x2::clock::timestamp_ms(arg7), arg6) < arg0.time_interval, 13906836145734090764);
        assert!(arg0.ts_ms < arg6, 13906836150029582356);
        update_(arg0, arg4, arg5, arg7, arg8);
    }

    public fun update_with_update_cap(arg0: &mut Oracle, arg1: &UpdateCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg1.for == 0x2::tx_context::sender(arg5), 13906835312510042118);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    public fun update_with_update_caps(arg0: &mut Oracle, arg1: &UpdateCaps, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg1.for, &v0), 13906835368344616966);
        update_(arg0, arg2, arg3, arg4, arg5);
    }

    fun version_check(arg0: &Oracle) {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"VERSION")), 13906836218748272648);
        assert!(2 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"VERSION")), 13906836201568403464);
    }

    // decompiled from Move bytecode v6
}

