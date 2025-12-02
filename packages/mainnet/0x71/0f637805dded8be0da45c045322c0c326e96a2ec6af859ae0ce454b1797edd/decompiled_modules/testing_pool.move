module 0x58a85d4ca1ee12437997a5b2a83d525e6ac6bc2612e4fe2d4885c05081892688::testing_pool {
    struct TestingPool has store, key {
        id: 0x2::object::UID,
        assets: 0x2::bag::Bag,
        types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        whitelists: 0x2::vec_set::VecSet<address>,
    }

    public fun add_to_whitelist(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.whitelists, &v0), 0);
        0x2::vec_set::insert<address>(&mut arg0.whitelists, arg1);
    }

    public fun add_types<T0>(arg0: &mut TestingPool) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.types, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun deposit<T0>(arg0: &mut TestingPool, arg1: &Whitelist, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg1.whitelists, &v0), 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.types, &v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T0>()), 0x2::coin::into_balance<T0>(arg2));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TestingPool{
            id     : 0x2::object::new(arg0),
            assets : 0x2::bag::new(arg0),
            types  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = Whitelist{
            id         : 0x2::object::new(arg0),
            whitelists : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::public_share_object<Whitelist>(v1);
        0x2::transfer::public_share_object<TestingPool>(v0);
    }

    public fun liquidate<T0, T1>(arg0: &mut TestingPool, arg1: &Whitelist, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg1.whitelists, &v0), 0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.types, &v1), 1);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.types, &v2), 1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T0>()), 0x2::coin::into_balance<T0>(arg3));
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.assets, 0x1::type_name::with_defining_ids<T1>());
        assert!(0x2::balance::value<T1>(v3) >= arg2, 2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v3, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

