module 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_factory {
    struct PairSimpleInfo has copy, drop, store {
        pair_id: 0x2::object::ID,
        pair_key: 0x2::object::ID,
        bin_step: u16,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
    }

    struct Pairs has store, key {
        id: 0x2::object::UID,
        list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PairSimpleInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pairs_id: 0x2::object::ID,
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

    public fun create_pair<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut Pairs, arg2: u32, arg3: u16, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3);
        assert!(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::is_in_whitelist(arg0, 0x1::type_name::get<T0>()) || 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::is_in_whitelist(arg0, 0x1::type_name::get<T1>()), 2);
        let v2 = new_pair_key<T0, T1>(arg3);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PairSimpleInfo>(&arg1.list, v2)) {
            abort 1
        };
        let v3 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::new<T0, T1>(arg2, arg3, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::base_factor(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::filter_period(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::decay_period(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::reduction_factor(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::variable_fee_control(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::protocol_share(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::max_volatility_accumulator(arg0, arg3), arg4, arg5, arg6);
        arg1.index = arg1.index + 1;
        let v4 = 0x2::object::id<0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>>(&v3);
        let v5 = PairSimpleInfo{
            pair_id     : v4,
            pair_key    : v2,
            bin_step    : arg3,
            coin_type_a : v0,
            coin_type_b : v1,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PairSimpleInfo>(&mut arg1.list, v2, v5);
        let v6 = CreatePairEvent{
            pair_id     : v4,
            bin_step    : arg3,
            coin_type_a : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            active_id   : arg2,
        };
        0x2::event::emit<CreatePairEvent>(v6);
        0x2::transfer::public_share_object<0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>>(v3);
    }

    public fun create_pair_test<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut Pairs, arg2: u32, arg3: u16, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1> {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3);
        assert!(0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::is_in_whitelist(arg0, 0x1::type_name::get<T0>()) || 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::is_in_whitelist(arg0, 0x1::type_name::get<T1>()), 2);
        let v2 = new_pair_key<T0, T1>(arg3);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PairSimpleInfo>(&arg1.list, v2)) {
            abort 1
        };
        let v3 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::new<T0, T1>(arg2, arg3, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::base_factor(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::filter_period(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::decay_period(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::reduction_factor(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::variable_fee_control(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::protocol_share(arg0, arg3), 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::max_volatility_accumulator(arg0, arg3), arg4, arg5, arg6);
        arg1.index = arg1.index + 1;
        let v4 = 0x2::object::id<0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>>(&v3);
        let v5 = PairSimpleInfo{
            pair_id     : v4,
            pair_key    : v2,
            bin_step    : arg3,
            coin_type_a : v0,
            coin_type_b : v1,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PairSimpleInfo>(&mut arg1.list, v2, v5);
        let v6 = CreatePairEvent{
            pair_id     : v4,
            bin_step    : arg3,
            coin_type_a : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            active_id   : arg2,
        };
        0x2::event::emit<CreatePairEvent>(v6);
        v3
    }

    public fun force_decay<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::check_pair_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::force_decay<T0, T1>(arg1, arg2);
    }

    public fun increase_oracle_length<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::check_pair_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::increase_oracle_length<T0, T1>(arg1, arg2, arg3);
    }

    public fun index(arg0: &Pairs) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pairs{
            id    : 0x2::object::new(arg0),
            list  : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PairSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Pairs>(v0);
        let v1 = InitFactoryEvent{pairs_id: 0x2::object::id<Pairs>(&v0)};
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

    public fun pause_pair<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::check_pair_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::pause_pair<T0, T1>(arg1, arg2);
    }

    public fun pool_simple_info(arg0: &Pairs, arg1: 0x2::object::ID) : &PairSimpleInfo {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PairSimpleInfo>(&arg0.list, arg1)
    }

    public fun set_static_fee_parameters<T0, T1>(arg0: &0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::GlobalConfig, arg1: &mut 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::LBPair<T0, T1>, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::checked_package_version(arg0);
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::config::check_pair_manager_role(arg0, 0x2::tx_context::sender(arg9));
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::lb_pair::set_static_fee_parameters<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

