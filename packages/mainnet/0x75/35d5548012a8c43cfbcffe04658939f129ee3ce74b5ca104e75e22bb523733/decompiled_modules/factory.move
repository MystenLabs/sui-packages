module 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::factory {
    struct TokenPair has copy, drop, store {
        token0: 0x1::type_name::TypeName,
        token1: 0x1::type_name::TypeName,
    }

    struct ProtocolPaused has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        pairs: 0x2::table::Table<TokenPair, address>,
        all_pairs: vector<address>,
        team_1_address: address,
        team_2_address: address,
        dev_address: address,
        locker_address: address,
        buyback_address: address,
        is_paused: bool,
        pause_admin: address,
    }

    struct PairCreated has copy, drop {
        token0: 0x1::type_name::TypeName,
        token1: 0x1::type_name::TypeName,
        pair: address,
        pair_len: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct PauseAdminTransferred has copy, drop {
        old_pause_admin: address,
        new_pause_admin: address,
    }

    public fun all_pairs_length(arg0: &Factory) : u64 {
        0x1::vector::length<address>(&arg0.all_pairs)
    }

    public fun assert_not_paused(arg0: &Factory) {
        assert!(!arg0.is_paused, 6);
    }

    fun compare_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 != v5) {
                return v4 < v5
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    fun compare_type_names_robust(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::get_address(arg0));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::get_address(arg1));
        if (v0 != v1) {
            return compare_bytes(&v0, &v1)
        };
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::get_module(arg0));
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::get_module(arg1));
        if (v2 != v3) {
            return compare_bytes(&v2, &v3)
        };
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::into_string(*arg0));
        let v5 = 0x1::ascii::into_bytes(0x1::type_name::into_string(*arg1));
        compare_bytes(&v4, &v5)
    }

    public(friend) fun create_pair<T0, T1>(arg0: &mut Factory, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = sort_tokens<T0, T1>();
        assert!(!0x2::table::contains<TokenPair, address>(&arg0.pairs, v2), 2);
        let v3 = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::pair::new<T0, T1>(arg1, arg2, arg0.team_1_address, arg0.team_2_address, arg0.dev_address, arg0.locker_address, arg0.buyback_address, arg3);
        let v4 = 0x2::object::id_address<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::pair::Pair<T0, T1>>(&v3);
        0x2::table::add<TokenPair, address>(&mut arg0.pairs, v2, v4);
        0x1::vector::push_back<address>(&mut arg0.all_pairs, v4);
        0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::pair::share_pair<T0, T1>(v3);
        let v5 = PairCreated{
            token0   : v0,
            token1   : v1,
            pair     : v4,
            pair_len : 0x1::vector::length<address>(&arg0.all_pairs),
        };
        0x2::event::emit<PairCreated>(v5);
        v4
    }

    public entry fun emergency_pause(arg0: &mut Factory, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.pause_admin, 7);
        assert!(!arg0.is_paused, 8);
        arg0.is_paused = true;
        let v0 = ProtocolPaused{
            admin     : 0x2::tx_context::sender(arg1),
            timestamp : 0,
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun get_all_pairs(arg0: &Factory) : &vector<address> {
        &arg0.all_pairs
    }

    public fun get_pair<T0, T1>(arg0: &Factory) : 0x1::option::Option<address> {
        let v0 = sort_tokens<T0, T1>();
        if (0x2::table::contains<TokenPair, address>(&arg0.pairs, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<TokenPair, address>(&arg0.pairs, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_pause_admin(arg0: &Factory) : address {
        arg0.pause_admin
    }

    public fun get_team_addresses(arg0: &Factory) : (address, address, address, address, address) {
        (arg0.team_1_address, arg0.team_2_address, arg0.dev_address, arg0.locker_address, arg0.buyback_address)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Factory{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            pairs           : 0x2::table::new<TokenPair, address>(arg0),
            all_pairs       : 0x1::vector::empty<address>(),
            team_1_address  : @0x5cf81060260cd6285918d637463433758a89b23268f7da43fc08e3175041acf4,
            team_2_address  : @0x11d00b1f0594da0aedc3dab291e619cea33e5cfcd3554738bfc1dd0375b65b56,
            dev_address     : @0xd84a545cf56ea9dcdcabe6a729bbf9da8b81d37fc00dbc7d177abd726ab765af,
            locker_address  : @0x5d061bec906f70c9f2b386e54361a62e2cc63b596d7ec2eb020e2a2d47232f05,
            buyback_address : @0x85242c621b2152b479e66cf73e96f8c4a67105866b6d0cbdc8a303b9b67d5ffe,
            is_paused       : false,
            pause_admin     : v0,
        };
        0x2::transfer::share_object<Factory>(v1);
    }

    public fun is_paused(arg0: &Factory) : bool {
        arg0.is_paused
    }

    public fun is_token0<T0>(arg0: &TokenPair) : bool {
        0x1::type_name::get<T0>() == arg0.token0
    }

    public fun set_addresses(arg0: &mut Factory, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 4);
        let v0 = if (arg1 != @0x0) {
            if (arg2 != @0x0) {
                if (arg3 != @0x0) {
                    if (arg4 != @0x0) {
                        arg5 != @0x0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        arg0.team_1_address = arg1;
        arg0.team_2_address = arg2;
        arg0.dev_address = arg3;
        arg0.locker_address = arg4;
        arg0.buyback_address = arg5;
    }

    public fun sort_tokens<T0, T1>() : TokenPair {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        assert!(compare_type_names_robust(&v0, &v1), 5);
        TokenPair{
            token0 : v0,
            token1 : v1,
        }
    }

    public entry fun transfer_admin(arg0: &mut Factory, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        assert!(arg1 != @0x0, 3);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public entry fun transfer_pause_admin(arg0: &mut Factory, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.pause_admin, 7);
        assert!(arg1 != @0x0, 3);
        arg0.pause_admin = arg1;
        let v0 = PauseAdminTransferred{
            old_pause_admin : arg0.pause_admin,
            new_pause_admin : arg1,
        };
        0x2::event::emit<PauseAdminTransferred>(v0);
    }

    public entry fun unpause(arg0: &mut Factory, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.pause_admin, 7);
        assert!(arg0.is_paused, 9);
        arg0.is_paused = false;
        let v0 = ProtocolUnpaused{
            admin     : 0x2::tx_context::sender(arg1),
            timestamp : 0,
        };
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public entry fun update_pair_fee_addresses<T0, T1>(arg0: &Factory, arg1: &mut 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::pair::Pair<T0, T1>, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 4);
        0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::pair::update_fee_addresses<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

