module 0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth {
    struct MetaVaultPythIntegration has store, key {
        id: 0x2::object::UID,
        price_feed_registry: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        stale_price_threshold_secs_registry: 0x2::table::Table<0x2::object::ID, u64>,
        default_stale_price_threshold_secs: u64,
    }

    public fun authorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0, T1>(arg0: &MetaVaultPythIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3))
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &MetaVaultPythIntegration, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3))
    }

    public fun deauthorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegration) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultPythIntegration{
            id                                  : 0x2::object::new(arg0),
            price_feed_registry                 : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            stale_price_threshold_secs_registry : 0x2::table::new<0x2::object::ID, u64>(arg0),
            default_stale_price_threshold_secs  : 30,
        };
        0x2::transfer::share_object<MetaVaultPythIntegration>(v0);
    }

    fun normalize_to_18_point_decimals(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v0);
        assert!(v1 <= 18, 9223373183611371526);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128) * 0x1::u128::pow(10, ((18 - v1) as u8))
    }

    public fun price_feed_id<T0>(arg0: &MetaVaultPythIntegration) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 9223372427696865282);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0)
    }

    fun price_of<T0>(arg0: &MetaVaultPythIntegration, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 9223372990337581058);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0);
        assert!(v1 == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 9223373020402483204);
        let v2 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, v1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, v1)
        } else {
            arg0.default_stale_price_threshold_secs
        };
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, v2);
        normalize_to_18_point_decimals(&v3)
    }

    public fun set_default_stale_price_threshold_secs(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegration, arg2: u64) {
        arg1.default_stale_price_threshold_secs = arg2;
    }

    public fun set_price_feed_id<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegration, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.price_feed_registry, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_feed_registry, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_feed_registry, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun set_stale_price_threshold_secs(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegration, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.stale_price_threshold_secs_registry, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg1.stale_price_threshold_secs_registry, v0);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.stale_price_threshold_secs_registry, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

