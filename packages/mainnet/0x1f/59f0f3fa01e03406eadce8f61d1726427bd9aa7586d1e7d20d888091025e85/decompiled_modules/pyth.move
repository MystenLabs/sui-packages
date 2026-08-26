module 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth {
    struct MetaVaultPythIntegrationDenominatedFeed has store, key {
        id: 0x2::object::UID,
        base_usd_price_feed_id: 0x2::object::ID,
        price_feed_registry: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        stale_price_threshold_secs_registry: 0x2::table::Table<0x2::object::ID, u64>,
        default_stale_price_threshold_secs: u64,
    }

    public fun authorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::authorize(arg0, &mut arg1.id);
    }

    public fun base_usd_price_feed_id(arg0: &MetaVaultPythIntegrationDenominatedFeed) : 0x2::object::ID {
        arg0.base_usd_price_feed_id
    }

    public fun create_deposit_cap<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3, arg4))
    }

    public fun create_deposit_cap_v2<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, price_of_v2<T1>(arg0, arg2, arg3, arg4))
    }

    public fun create_vault(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x2::tx_context::TxContext) {
        abort 13906834560891027466
    }

    public fun create_vault_v2(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultPythIntegrationDenominatedFeed{
            id                                  : 0x2::object::new(arg2),
            base_usd_price_feed_id              : 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg1),
            price_feed_registry                 : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2),
            stale_price_threshold_secs_registry : 0x2::table::new<0x2::object::ID, u64>(arg2),
            default_stale_price_threshold_secs  : 30,
        };
        0x2::transfer::share_object<MetaVaultPythIntegrationDenominatedFeed>(v0);
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, price_of<T1>(arg0, arg2, arg3, arg4))
    }

    public fun create_withdraw_cap_v2<T0, T1>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, price_of_v2<T1>(arg0, arg2, arg3, arg4))
    }

    public fun deauthorize(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun default_stale_price_threshold_secs(arg0: &MetaVaultPythIntegrationDenominatedFeed) : u64 {
        arg0.default_stale_price_threshold_secs
    }

    fun divide_by(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one() as u256) / (arg1 as u256)) as u128)
    }

    fun exchange_rate_meta_coin_to_coin(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        divide_by(normalize_to_18_point_decimals(arg0, arg1), normalize_to_18_point_decimals(arg2, arg3))
    }

    fun normalize_to_18_point_decimals(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 <= 18, 13906836485036245000);
        (arg0 as u128) * 0x1::u128::pow(10, ((18 - arg1) as u8))
    }

    public fun price_feed_id<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 13906834724099391492);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0)
    }

    fun price_of<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let (v0, v1) = stale_price_threshold_secs_for<T0>(arg0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg3, v1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        exchange_rate_meta_coin_to_coin(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v7))
    }

    fun price_of_v2<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let (v0, v1) = stale_price_threshold_secs_for<T0>(arg0, 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg1), 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2));
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg3, v0);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg2, arg3, v1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v2);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v2);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        exchange_rate_meta_coin_to_coin(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v6), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v7))
    }

    public fun set_base_usd_price_feed_id_v2(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        arg1.base_usd_price_feed_id = 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2);
    }

    public fun set_default_stale_price_threshold_secs(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: u64) {
        arg1.default_stale_price_threshold_secs = arg2;
    }

    public fun set_price_feed_id<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        abort 13906834977502855178
    }

    public fun set_price_feed_id_v2<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg1.price_feed_registry;
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(v1, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(v1, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(v1, v0, 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2));
    }

    public fun set_stale_price_threshold_secs(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        abort 13906835037632397322
    }

    public fun set_stale_price_threshold_secs_v2(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &mut MetaVaultPythIntegrationDenominatedFeed, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: u64) {
        let v0 = 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2);
        let v1 = &mut arg1.stale_price_threshold_secs_registry;
        if (0x2::table::contains<0x2::object::ID, u64>(v1, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(v1, v0);
        };
        0x2::table::add<0x2::object::ID, u64>(v1, v0, arg3);
    }

    public fun stale_price_threshold_secs(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u64 {
        stale_price_threshold_secs_for_id(arg0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1))
    }

    fun stale_price_threshold_secs_for<T0>(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : (u64, u64) {
        assert!(arg2 == arg0.base_usd_price_feed_id, 13906836231632781314);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 13906836248812781572);
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0) == arg1, 13906836274582716422);
        (stale_price_threshold_secs_for_id(arg0, arg1), stale_price_threshold_secs_for_id(arg0, arg2))
    }

    fun stale_price_threshold_secs_for_id(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.stale_price_threshold_secs_registry, arg1)
        } else {
            arg0.default_stale_price_threshold_secs
        }
    }

    public fun stale_price_threshold_secs_v2(arg0: &MetaVaultPythIntegrationDenominatedFeed, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        stale_price_threshold_secs_for_id(arg0, 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg1))
    }

    // decompiled from Move bytecode v7
}

