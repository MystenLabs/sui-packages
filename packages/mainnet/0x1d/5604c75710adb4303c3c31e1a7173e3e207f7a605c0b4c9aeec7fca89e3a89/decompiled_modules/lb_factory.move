module 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_factory {
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

    struct CreatePairReceipt {
        pair_id: 0x2::object::ID,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
    }

    struct InitFactoryEvent has copy, drop {
        pair_factory: 0x2::object::ID,
    }

    struct PairCreatedEvent has copy, drop {
        pair_id: 0x2::object::ID,
        token_x: 0x1::string::String,
        token_y: 0x1::string::String,
        bin_step: u16,
        active_id: u32,
        fee_scheduler_enabled: bool,
        activation_timestamp: u64,
    }

    public fun bin_step(arg0: &PairSimpleInfo) : u32 {
        (arg0.bin_step as u32)
    }

    public fun coin_types(arg0: &PairSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_pair<T0, T1>(arg0: &0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::GlobalConfig, arg1: &mut Pairs, arg2: u32, arg3: u16, arg4: u32, arg5: u8, arg6: bool, arg7: u8, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::checked_package_version(arg0);
        assert!(!0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::global_paused(arg0), 106);
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::fee_tier_exists(arg0, arg4), 108);
        let (v0, v1) = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::get_bin_range(arg0, arg3);
        assert!(arg2 >= v0 && arg2 <= v1, 105);
        if (!0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::get_allow_create_pair(arg0)) {
            0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg12));
        };
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::fee_tier_exists(arg0, arg4), 110);
        if (arg6) {
            assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::is_in_whitelist(arg0, 0x1::type_name::get<T1>()), 103);
        } else {
            assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::is_in_whitelist(arg0, 0x1::type_name::get<T0>()), 103);
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        assert!(v2 != v3, 107);
        let v4 = new_pair_key<T0, T1>(arg4, arg8, arg9);
        if (0x2::table::contains<0x2::object::ID, PairSimpleInfo>(&arg1.list, v4)) {
            abort 104
        };
        let (v5, v6, v7, v8) = if (arg8) {
            if (arg7 == 0) {
                0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::linear_fee_scheduler(arg0, arg4)
            } else {
                assert!(arg7 == 1, 111);
                0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::exponential_fee_scheduler(arg0, arg4)
            }
        } else {
            (0, 0, 0, 0)
        };
        let v9 = 0x2::clock::timestamp_ms(arg11);
        if (arg10 == 0) {
            arg10 = v9;
        };
        assert!(arg10 >= v9, 111);
        let v10 = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::new<T0, T1>(arg2, arg3, arg4, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::protocol_share(arg0, arg4), arg10, arg5, arg6, arg9, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::filter_period(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::decay_period(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::reduction_factor(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::variable_fee_control(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::max_volatility_accumulator(arg0, arg4), arg7, arg8, v5, v6, v7, v8, arg12);
        arg1.index = arg1.index + 1;
        let v11 = 0x2::object::id<0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>>(&v10);
        let v12 = PairSimpleInfo{
            pair_id     : v11,
            pair_key    : v4,
            bin_step    : arg3,
            coin_type_a : v2,
            coin_type_b : v3,
        };
        0x2::table::add<0x2::object::ID, PairSimpleInfo>(&mut arg1.list, v4, v12);
        let v13 = PairCreatedEvent{
            pair_id               : v11,
            token_x               : 0x1::string::from_ascii(0x1::type_name::into_string(v2)),
            token_y               : 0x1::string::from_ascii(0x1::type_name::into_string(v3)),
            bin_step              : arg3,
            active_id             : arg2,
            fee_scheduler_enabled : arg8,
            activation_timestamp  : arg10,
        };
        0x2::event::emit<PairCreatedEvent>(v13);
        0x2::transfer::public_share_object<0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>>(v10);
    }

    public fun create_pair_with_receipt<T0, T1>(arg0: &0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::GlobalConfig, arg1: &mut Pairs, arg2: u32, arg3: u16, arg4: u32, arg5: u8, arg6: bool, arg7: u8, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>, CreatePairReceipt) {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::checked_package_version(arg0);
        assert!(!0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::global_paused(arg0), 106);
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::fee_tier_exists(arg0, arg4), 108);
        let (v0, v1) = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::get_bin_range(arg0, arg3);
        assert!(arg2 >= v0 && arg2 <= v1, 105);
        if (!0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::get_allow_create_pair(arg0)) {
            0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg12));
        };
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::fee_tier_exists(arg0, arg4), 110);
        if (arg6) {
            assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::is_in_whitelist(arg0, 0x1::type_name::get<T1>()), 103);
        } else {
            assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::is_in_whitelist(arg0, 0x1::type_name::get<T0>()), 103);
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        assert!(v2 != v3, 107);
        let v4 = new_pair_key<T0, T1>(arg4, arg8, arg9);
        if (0x2::table::contains<0x2::object::ID, PairSimpleInfo>(&arg1.list, v4)) {
            abort 104
        };
        let (v5, v6, v7, v8) = if (arg8) {
            if (arg7 == 0) {
                0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::linear_fee_scheduler(arg0, arg4)
            } else {
                assert!(arg7 == 1, 111);
                0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::exponential_fee_scheduler(arg0, arg4)
            }
        } else {
            0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::linear_fee_scheduler(arg0, arg4)
        };
        assert!(arg10 >= 0x2::clock::timestamp_ms(arg11), 111);
        let v9 = 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::new<T0, T1>(arg2, arg3, arg4, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::protocol_share(arg0, arg4), arg10, arg5, arg6, arg9, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::filter_period(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::decay_period(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::reduction_factor(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::variable_fee_control(arg0, arg4), 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config::max_volatility_accumulator(arg0, arg4), arg7, arg8, v5, v6, v7, v8, arg12);
        arg1.index = arg1.index + 1;
        let v10 = 0x2::object::id<0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>>(&v9);
        let v11 = PairSimpleInfo{
            pair_id     : v10,
            pair_key    : v4,
            bin_step    : arg3,
            coin_type_a : v2,
            coin_type_b : v3,
        };
        0x2::table::add<0x2::object::ID, PairSimpleInfo>(&mut arg1.list, v4, v11);
        let v12 = PairCreatedEvent{
            pair_id               : v10,
            token_x               : 0x1::string::from_ascii(0x1::type_name::into_string(v2)),
            token_y               : 0x1::string::from_ascii(0x1::type_name::into_string(v3)),
            bin_step              : arg3,
            active_id             : arg2,
            fee_scheduler_enabled : arg8,
            activation_timestamp  : arg10,
        };
        0x2::event::emit<PairCreatedEvent>(v12);
        let v13 = CreatePairReceipt{
            pair_id     : v10,
            coin_type_x : 0x1::type_name::get<T0>(),
            coin_type_y : 0x1::type_name::get<T1>(),
        };
        (v9, v13)
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

    public fun new_pair_key<T0, T1>(arg0: u32, arg1: bool, arg2: bool) : 0x2::object::ID {
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
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u32>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<bool>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<bool>(&arg2));
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

    public fun share_pair<T0, T1>(arg0: 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>, arg1: CreatePairReceipt) {
        let CreatePairReceipt {
            pair_id     : v0,
            coin_type_x : v1,
            coin_type_y : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>>(&arg0), 111);
        assert!(v1 == 0x1::type_name::get<T0>(), 111);
        assert!(v2 == 0x1::type_name::get<T1>(), 111);
        0x2::transfer::public_share_object<0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::lb_pair::LBPair<T0, T1>>(arg0);
    }

    // decompiled from Move bytecode v6
}

