module 0x809f8aed754750d7dc6564374e0940ab76ae9a913b99f214f5182fe97a97ec1d::coin_registry {
    struct COIN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        price_object_ids: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        pool_coin_types: 0x2::table::Table<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    struct CoinRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_pyth_object_info_and_coins<T0, T1>(arg0: &CoinRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.pool_coin_types, v0), 0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_object_ids, v0), 1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.pool_coin_types, v0) == &v1, 2);
        let v2 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        assert!(&v2 == 0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_object_ids, v0), 3);
    }

    fun init(arg0: COIN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinRegistry{
            id               : 0x2::object::new(arg1),
            price_object_ids : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
            pool_coin_types  : 0x2::table::new<0x1::type_name::TypeName, 0x1::type_name::TypeName>(arg1),
        };
        0x2::transfer::share_object<CoinRegistry>(v0);
        let v1 = CoinRegistryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CoinRegistryCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register_price_info_object<T0, T1>(arg0: &CoinRegistryCap, arg1: &mut CoinRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.price_object_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_object_ids, v0);
        };
        if (0x2::table::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.pool_coin_types, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg1.pool_coin_types, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_object_ids, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        0x2::table::add<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg1.pool_coin_types, v0, 0x1::type_name::get<T1>());
    }

    // decompiled from Move bytecode v6
}

