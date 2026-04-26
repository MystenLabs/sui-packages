module 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool_factory {
    struct POOL_FACTORY has drop {
        dummy_field: bool,
    }

    struct PairKey has copy, drop, store {
        type_a: 0x1::ascii::String,
        type_b: 0x1::ascii::String,
    }

    struct FactoryRegistry has key {
        id: 0x2::object::UID,
        pool_count: u64,
        pairs: 0x2::table::Table<PairKey, 0x2::object::ID>,
        sealed: bool,
    }

    struct OriginCap has key {
        id: 0x2::object::UID,
    }

    struct FactoryInitialized has copy, drop {
        factory_id: 0x2::object::ID,
        deployer: address,
    }

    struct FactorySealed has copy, drop {
        factory_id: 0x2::object::ID,
        deployer: address,
        timestamp_ms: u64,
    }

    public fun assert_sorted<T0, T1>() : PairKey {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(bytes_lt(0x1::ascii::as_bytes(&v0), 0x1::ascii::as_bytes(&v1)), 4);
        PairKey{
            type_a : v0,
            type_b : v1,
        }
    }

    fun bytes_lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
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
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun canonical_pool_id<T0, T1>(arg0: &FactoryRegistry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = if (bytes_lt(0x1::ascii::as_bytes(&v0), 0x1::ascii::as_bytes(&v1))) {
            PairKey{type_a: v0, type_b: v1}
        } else {
            PairKey{type_a: v1, type_b: v0}
        };
        if (0x2::table::contains<PairKey, 0x2::object::ID>(&arg0.pairs, v2)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PairKey, 0x2::object::ID>(&arg0.pairs, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun create_canonical_pool<T0, T1>(arg0: &mut FactoryRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1> {
        let v0 = assert_sorted<T0, T1>();
        assert!(0x2::coin::value<T0>(&arg1) > 0 && 0x2::coin::value<T1>(&arg2) > 0, 5);
        assert!(!0x2::table::contains<PairKey, 0x2::object::ID>(&arg0.pairs, v0), 6);
        let (v1, v2) = 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::create_pool<T0, T1>(arg1, arg2, arg3, arg4);
        0x2::table::add<PairKey, 0x2::object::ID>(&mut arg0.pairs, v0, v1);
        arg0.pool_count = arg0.pool_count + 1;
        v2
    }

    public fun create_canonical_pool_entry<T0, T1>(arg0: &mut FactoryRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_canonical_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun destroy_cap(arg0: OriginCap, arg1: &mut FactoryRegistry, arg2: 0x2::package::UpgradeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.sealed, 18);
        let OriginCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::package::make_immutable(arg2);
        arg1.sealed = true;
        let v1 = FactorySealed{
            factory_id   : 0x2::object::id<FactoryRegistry>(arg1),
            deployer     : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FactorySealed>(v1);
    }

    fun init(arg0: POOL_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryRegistry{
            id         : 0x2::object::new(arg1),
            pool_count : 0,
            pairs      : 0x2::table::new<PairKey, 0x2::object::ID>(arg1),
            sealed     : false,
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = FactoryInitialized{
            factory_id : 0x2::object::id<FactoryRegistry>(&v0),
            deployer   : v1,
        };
        0x2::event::emit<FactoryInitialized>(v2);
        0x2::transfer::share_object<FactoryRegistry>(v0);
        let v3 = OriginCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OriginCap>(v3, v1);
    }

    public fun is_sealed(arg0: &FactoryRegistry) : bool {
        arg0.sealed
    }

    public fun pool_count(arg0: &FactoryRegistry) : u64 {
        arg0.pool_count
    }

    // decompiled from Move bytecode v7
}

