module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry {
    struct PoolRegistryStateV1 has store, key {
        id: 0x2::object::UID,
        coins: 0x2::table::Table<0x1::ascii::String, bool>,
        lp_coin_map: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        registered_pools: 0x2::table::Table<vector<u8>, bool>,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        protocol_version: u64,
    }

    public(friend) fun add_coin<T0>(arg0: &mut PoolRegistry) {
        let v0 = borrow_state_mut(arg0);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>();
        if (!0x2::table::contains<0x1::ascii::String, bool>(&v0.coins, v1)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut v0.coins, v1, true);
        };
    }

    fun borrow_state(arg0: &PoolRegistry) : &PoolRegistryStateV1 {
        0x2::dynamic_object_field::borrow<u64, PoolRegistryStateV1>(&arg0.id, arg0.protocol_version)
    }

    fun borrow_state_mut(arg0: &mut PoolRegistry) : &mut PoolRegistryStateV1 {
        0x2::dynamic_object_field::borrow_mut<u64, PoolRegistryStateV1>(&mut arg0.id, arg0.protocol_version)
    }

    public(friend) fun borrow_uid(arg0: &PoolRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public fun contains_coin<T0>(arg0: &PoolRegistry) : bool {
        0x2::table::contains<0x1::ascii::String, bool>(&borrow_state(arg0).coins, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>())
    }

    public fun contains_lp_coin<T0>(arg0: &PoolRegistry) : bool {
        0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&borrow_state(arg0).lp_coin_map, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id               : 0x2::object::new(arg0),
            protocol_version : 1,
        };
        let v1 = PoolRegistryStateV1{
            id               : 0x2::object::new(arg0),
            coins            : 0x2::table::new<0x1::ascii::String, bool>(arg0),
            lp_coin_map      : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
            registered_pools : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::dynamic_object_field::add<u64, PoolRegistryStateV1>(&mut v0.id, 1, v1);
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public fun lp_coin_map(arg0: &PoolRegistry) : &0x2::table::Table<0x1::ascii::String, 0x2::object::ID> {
        &borrow_state(arg0).lp_coin_map
    }

    public fun lp_type_to_pool_id<T0>(arg0: &PoolRegistry) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&borrow_state(arg0).lp_coin_map, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>())
    }

    public fun protocol_version(arg0: &PoolRegistry) : u64 {
        arg0.protocol_version
    }

    public(friend) fun register_pool<T0>(arg0: &mut PoolRegistry, arg1: &0x2::object::UID, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::is_sorted(&arg2), 60);
        let v0 = borrow_state_mut(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = &mut v1;
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg2));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<u64>>(&arg3));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<u64>>(&arg5));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<u64>>(&arg6));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<u64>>(&arg7));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<vector<u64>>(&arg8));
        let v3 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v1);
        let v4 = 0x2::hash::blake2b256(&v3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&v0.registered_pools, v4), 61);
        0x2::table::add<vector<u8>, bool>(&mut v0.registered_pools, v4, true);
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut v0.lp_coin_map, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>(), 0x2::object::uid_to_inner(arg1));
    }

    public fun supported_coins(arg0: &PoolRegistry) : &0x2::table::Table<0x1::ascii::String, bool> {
        &borrow_state(arg0).coins
    }

    // decompiled from Move bytecode v6
}

