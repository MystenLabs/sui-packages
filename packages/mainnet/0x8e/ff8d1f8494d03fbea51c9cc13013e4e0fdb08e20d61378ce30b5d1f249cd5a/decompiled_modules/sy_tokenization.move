module 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::sy_tokenization {
    struct Registry<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        balance: 0x2::balance::Balance<T1>,
    }

    struct TypenameItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<TypenameItem, bool>,
    }

    struct NewRegistryEvent<phantom T0, phantom T1> has copy, drop {
        registry_id: 0x2::object::ID,
    }

    public fun mint<T0, T1>(arg0: &mut Registry<T0, T1>, arg1: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>) {
        if (0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::is_expired<T0, T1>(arg1, arg4)) {
            abort 1
        };
        let v0 = 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::utils::sy_to_asset(0x2::coin::value<T1>(&arg2), arg3);
        0x2::coin::put<T1>(&mut arg0.balance, arg2);
        (0x2::coin::mint<T0>(&mut arg0.treasury, v0, arg5), 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::mint<T0, T1>(v0, arg3, arg5))
    }

    public fun claim_interest<T0, T1>(arg0: &mut Registry<T0, T1>, arg1: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg2: &mut 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::is_expired<T0, T1>(arg1, arg3)) {
            abort 1
        };
        0x2::coin::take<T1>(&mut arg0.balance, 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::claim<T0, T1>(arg2), arg4)
    }

    public fun create_new_registry<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : Registry<T0, T1> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::utils::cmp_type_names(&v0, &v1);
        if (v2 == 1) {
            abort 4
        };
        if (v2 == 2) {
            v0 = 0x1::type_name::get<T1>();
            v1 = 0x1::type_name::get<T0>();
        };
        let v3 = TypenameItem{
            a : v0,
            b : v1,
        };
        assert!(0x2::table::contains<TypenameItem, bool>(&arg0.table, v3) == false, 5);
        0x2::table::add<TypenameItem, bool>(&mut arg0.table, v3, true);
        let v4 = Registry<T0, T1>{
            id       : 0x2::object::new(arg2),
            treasury : arg1,
            balance  : 0x2::balance::zero<T1>(),
        };
        let v5 = NewRegistryEvent<T0, T1>{registry_id: 0x2::object::id<Registry<T0, T1>>(&v4)};
        0x2::event::emit<NewRegistryEvent<T0, T1>>(v5);
        v4
    }

    public fun earn_interest<T0, T1>(arg0: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg1: &mut 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: &0x2::clock::Clock) {
        if (0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::is_expired<T0, T1>(arg0, arg3)) {
            abort 1
        };
        0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::earn<T0, T1>(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<TypenameItem, bool>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public fun merge<T0, T1>(arg0: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg1: &mut 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg2: 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) {
        0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::merge<T0, T1>(arg1, arg2, arg3);
    }

    public fun redeem_after_maturity<T0, T1>(arg0: &mut Registry<T0, T1>, arg1: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (!0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::is_expired<T0, T1>(arg1, arg4)) {
            abort 2
        };
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        0x2::coin::take<T1>(&mut arg0.balance, 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::utils::asset_to_sy(0x2::coin::value<T0>(&arg2), arg3), arg5)
    }

    public fun redeem_before_maturity<T0, T1>(arg0: &mut Registry<T0, T1>, arg1: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::is_expired<T0, T1>(arg1, arg5)) {
            abort 3
        };
        let v0 = 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::get_amount<T0, T1>(&arg3);
        assert!(0x2::coin::value<T0>(&arg2) == v0, 0);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::delete<T0, T1>(arg3);
        0x2::coin::take<T1>(&mut arg0.balance, 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::utils::asset_to_sy(v0, arg4), arg6)
    }

    public fun split<T0, T1>(arg0: &0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::amm::Market<T0, T1>, arg1: &mut 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::YieldObject<T0, T1> {
        0x8eff8d1f8494d03fbea51c9cc13013e4e0fdb08e20d61378ce30b5d1f249cd5a::yield_object::split<T0, T1>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

