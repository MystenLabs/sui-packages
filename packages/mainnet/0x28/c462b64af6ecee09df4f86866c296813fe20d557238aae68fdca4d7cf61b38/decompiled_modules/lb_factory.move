module 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::lb_factory {
    struct PairSimpleInfo has copy, drop, store {
        pair_id: 0x2::object::ID,
        pair_key: 0x2::object::ID,
        bin_step: u16,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
    }

    struct Pairs has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, PairSimpleInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pair_factory: 0x2::object::ID,
    }

    struct CreatePairEvent has copy, drop {
        pair_id: 0x2::object::ID,
        bin_step: u16,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        active_id: u32,
    }

    public fun bin_step(arg0: &PairSimpleInfo) : u32 {
        (arg0.bin_step as u32)
    }

    public fun coin_types(arg0: &PairSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_pair<T0, T1>(arg0: &0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::GlobalConfig, arg1: &mut Pairs, arg2: u32, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::checked_package_version(arg0);
        assert!(!0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::global_paused(arg0), 100);
        assert!(0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::bin_step_exists(arg0, arg3), 101);
        if (!0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::get_allow_create_pair(arg0)) {
            0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg4));
        };
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 102);
        assert!(0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::is_in_whitelist(arg0, 0x1::type_name::get<T0>()) || 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::is_in_whitelist(arg0, 0x1::type_name::get<T1>()), 103);
        let v2 = new_pair_key<T0, T1>(arg3);
        if (0x2::table::contains<0x2::object::ID, PairSimpleInfo>(&arg1.list, v2)) {
            abort 104
        };
        let v3 = 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::lb_pair::new<T0, T1>(arg2, arg3, 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::base_factor(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::filter_period(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::decay_period(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::reduction_factor(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::variable_fee_control(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::protocol_share(arg0, arg3), 0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::config::max_volatility_accumulator(arg0, arg3), arg4);
        arg1.index = arg1.index + 1;
        let v4 = 0x2::object::id<0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::lb_pair::LBPair<T0, T1>>(&v3);
        let v5 = PairSimpleInfo{
            pair_id     : v4,
            pair_key    : v2,
            bin_step    : arg3,
            coin_type_a : v0,
            coin_type_b : v1,
        };
        0x2::table::add<0x2::object::ID, PairSimpleInfo>(&mut arg1.list, v2, v5);
        let v6 = CreatePairEvent{
            pair_id     : v4,
            bin_step    : arg3,
            coin_type_a : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            active_id   : arg2,
        };
        0x2::event::emit<CreatePairEvent>(v6);
        0x2::transfer::public_share_object<0x28c462b64af6ecee09df4f86866c296813fe20d557238aae68fdca4d7cf61b38::lb_pair::LBPair<T0, T1>>(v3);
    }

    public fun index(arg0: &Pairs) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pairs{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, PairSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Pairs>(v0);
        let v1 = InitFactoryEvent{pair_factory: 0x2::object::id<Pairs>(&v0)};
        0x2::event::emit<InitFactoryEvent>(v1);
    }

    public fun new_pair_key<T0, T1>(arg0: u16) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v6 = *0x1::vector::borrow<u8>(&v3, v4);
            if (!v5 && v4 < 0x1::vector::length<u8>(&v1)) {
                let v7 = *0x1::vector::borrow<u8>(&v1, v4);
                if (v7 < v6) {
                    abort 6
                };
                if (v7 > v6) {
                    v5 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v6);
            v4 = v4 + 1;
        };
        if (!v5) {
            if (0x1::vector::length<u8>(&v1) < 0x1::vector::length<u8>(&v3)) {
                abort 6
            };
            if (0x1::vector::length<u8>(&v1) == 0x1::vector::length<u8>(&v3)) {
                abort 3
            };
        };
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u16>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun pair_id(arg0: &PairSimpleInfo) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun pair_key(arg0: &PairSimpleInfo) : 0x2::object::ID {
        arg0.pair_key
    }

    public fun pool_simple_info(arg0: &Pairs, arg1: 0x2::object::ID) : &PairSimpleInfo {
        0x2::table::borrow<0x2::object::ID, PairSimpleInfo>(&arg0.list, arg1)
    }

    // decompiled from Move bytecode v6
}

