module 0x655be69cb1917abf455cfde4395c4f0cda2c3704ef48d7c15b54c4992ca39c59::pyth {
    struct MetaVaultPythIntegrationDenominatedFeed has store, key {
        id: 0x2::object::UID,
        base_usd_price_feed_id: 0x2::object::ID,
        price_feed_registry: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        stale_price_threshold_secs_registry: 0x2::table::Table<0x2::object::ID, u64>,
        default_stale_price_threshold_secs: u64,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun base_usd_price_feed_id(arg0: &MetaVaultPythIntegrationDenominatedFeed) : 0x2::object::ID {
        arg0.base_usd_price_feed_id
    }

    public fun create_deposit_cap<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, T1> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3, arg4))
    }

    public fun create_vault(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultPythIntegrationDenominatedFeed{
            id                                  : 0x2::object::new(arg2),
            base_usd_price_feed_id              : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1),
            price_feed_registry                 : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2),
            stale_price_threshold_secs_registry : 0x2::table::new<0x2::object::ID, u64>(arg2),
            default_stale_price_threshold_secs  : 30,
        };
        0x2::transfer::share_object<MetaVaultPythIntegrationDenominatedFeed>(v0);
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, T1> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3, arg4))
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun default_stale_price_threshold_secs(arg0: &MetaVaultPythIntegrationDenominatedFeed) : u64 {
        arg0.default_stale_price_threshold_secs
    }

    fun divide_by(arg0: u128, arg1: u128) : u128 {
        arg0 * 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() / arg1
    }

    fun normalize_to_18_point_decimals(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v0);
        assert!(v1 <= 18, 9223373557273657352);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128) * 0x1::u128::pow(10, ((18 - v1) as u8))
    }

    public fun price_feed_id<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 9223372522186276868);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0)
    }

    fun price_of<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2) == arg0.base_usd_price_feed_id, 9223373325345030146);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 9223373346819997700);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0) == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 9223373376884899846);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, stale_price_threshold_secs(arg0, arg1));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg3, stale_price_threshold_secs(arg0, arg2));
        divide_by(normalize_to_18_point_decimals(&v1), normalize_to_18_point_decimals(&v2))
    }

    public fun set_default_stale_price_threshold_secs(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: u64) {
        arg1.default_stale_price_threshold_secs = arg2;
    }

    public fun set_price_feed_id<T0>(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.price_feed_registry, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_feed_registry, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_feed_registry, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun set_stale_price_threshold_secs(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.stale_price_threshold_secs_registry, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg1.stale_price_threshold_secs_registry, v0);
        };
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.stale_price_threshold_secs_registry, v0, arg3);
    }

    public fun stale_price_threshold_secs(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u64 {
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, v0)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, v0)
        } else {
            arg0.default_stale_price_threshold_secs
        }
    }

    // decompiled from Move bytecode v6
}

