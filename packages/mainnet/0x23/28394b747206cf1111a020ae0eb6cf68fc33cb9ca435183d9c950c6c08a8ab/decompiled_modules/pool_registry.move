module 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry {
    struct RegisteredPoolFields has copy, drop, store {
        type_names: vector<0x1::ascii::String>,
        weights: vector<u64>,
        flatness: u64,
        fees_swap_in: vector<u64>,
        fees_swap_out: vector<u64>,
        fees_deposit: vector<u64>,
        fees_withdraw: vector<u64>,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        protocol_version: u64,
        coins: 0x2::table::Table<0x1::ascii::String, bool>,
        lp_coin_map: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        registered_pools: 0x2::table::Table<RegisteredPoolFields, bool>,
    }

    public(friend) fun add_coin<T0>(arg0: &mut PoolRegistry) {
        let v0 = 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys::type_to_string<T0>();
        if (!0x2::table::contains<0x1::ascii::String, bool>(&arg0.coins, v0)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.coins, v0, true);
        };
    }

    public(friend) fun borrow_uid(arg0: &PoolRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public fun contains_coin<T0>(arg0: &PoolRegistry) : bool {
        0x2::table::contains<0x1::ascii::String, bool>(&arg0.coins, 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys::type_to_string<T0>())
    }

    public fun contains_lp_coin<T0>(arg0: &PoolRegistry) : bool {
        0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.lp_coin_map, 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys::type_to_string<T0>())
    }

    fun in_lexicographical_order(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = 0x1::ascii::as_bytes(arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v0);
        let v4 = 0;
        while (v4 < v2 && v4 < v3) {
            let v5 = *0x1::vector::borrow<u8>(v0, v4);
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            if (v5 != v6) {
                return v5 < v6
            };
            v4 = v4 + 1;
        };
        v2 <= v3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id               : 0x2::object::new(arg0),
            protocol_version : 1,
            coins            : 0x2::table::new<0x1::ascii::String, bool>(arg0),
            lp_coin_map      : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
            registered_pools : 0x2::table::new<RegisteredPoolFields, bool>(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun is_sorted(arg0: &vector<0x1::ascii::String>) : bool {
        let v0 = 0x1::vector::length<0x1::ascii::String>(arg0);
        if (v0 <= 1) {
            return true
        };
        let v1 = 1;
        let v2 = 0x1::vector::borrow<0x1::ascii::String>(arg0, v1 - 1);
        while (v1 < v0) {
            v2 = 0x1::vector::borrow<0x1::ascii::String>(arg0, v1);
            if (!in_lexicographical_order(v2, v2)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun lp_coin_map(arg0: &PoolRegistry) : &0x2::table::Table<0x1::ascii::String, 0x2::object::ID> {
        &arg0.lp_coin_map
    }

    public fun lp_type_to_pool_id<T0>(arg0: &PoolRegistry) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.lp_coin_map, 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys::type_to_string<T0>())
    }

    public fun protocol_version(arg0: &PoolRegistry) : u64 {
        arg0.protocol_version
    }

    public(friend) fun register_pool<T0>(arg0: &mut PoolRegistry, arg1: &0x2::object::UID, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        assert!(is_sorted(&arg2), 60);
        let v0 = RegisteredPoolFields{
            type_names    : arg2,
            weights       : arg3,
            flatness      : arg4,
            fees_swap_in  : arg5,
            fees_swap_out : arg6,
            fees_deposit  : arg7,
            fees_withdraw : arg8,
        };
        assert!(!0x2::table::contains<RegisteredPoolFields, bool>(&arg0.registered_pools, v0), 61);
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.lp_coin_map, 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::keys::type_to_string<T0>(), 0x2::object::uid_to_inner(arg1));
        0x2::table::add<RegisteredPoolFields, bool>(&mut arg0.registered_pools, v0, true);
    }

    public fun supported_coins(arg0: &PoolRegistry) : &0x2::table::Table<0x1::ascii::String, bool> {
        &arg0.coins
    }

    // decompiled from Move bytecode v6
}

