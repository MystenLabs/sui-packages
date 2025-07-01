module 0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::coin_registry {
    struct COIN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        pool_coin_types: 0x2::table::Table<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    struct CoinRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_pool_coin_type<T0, T1>(arg0: &CoinRegistry) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.pool_coin_types, v0), 0);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.pool_coin_types, v0) == &v1, 1);
    }

    fun init(arg0: COIN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinRegistry{
            id              : 0x2::object::new(arg1),
            pool_coin_types : 0x2::table::new<0x1::type_name::TypeName, 0x1::type_name::TypeName>(arg1),
        };
        0x2::transfer::share_object<CoinRegistry>(v0);
        let v1 = CoinRegistryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CoinRegistryCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register_pool_coin_types<T0, T1>(arg0: &CoinRegistryCap, arg1: &mut CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.pool_coin_types, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg1.pool_coin_types, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg1.pool_coin_types, v0, 0x1::type_name::get<T1>());
    }

    // decompiled from Move bytecode v6
}

