module 0xf72cc1355025bd192f320125a87dfc53fe619d09159c85d76c95086507e2431d::pyth {
    struct MetaVaultPythIntegration has store, key {
        id: 0x2::object::UID,
        price_feed_registry: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public fun authorize(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &mut MetaVaultPythIntegration) {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &mut MetaVaultPythIntegration) {
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0, T1>(arg0: &MetaVaultPythIntegration, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::DepositCap<T1> {
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, 0x1::type_name::get<T1>()) == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3), 9223372582315753475);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg3, arg4);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, convert_to_coin_in_to_meta_coin_exchange_rate(&v0))
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &MetaVaultPythIntegration, arg1: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::Vault<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::WithdrawCap<T1> {
        assert!(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, 0x1::type_name::get<T1>()) == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3), 9223372741229543427);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg3, arg4);
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, convert_to_meta_coin_to_coin_out_exchange_rate(&v0))
    }

    fun convert_to_coin_in_to_meta_coin_exchange_rate(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v2 = 18 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v0);
        if (v2 >= 38) {
            abort 0
        };
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_and_divide((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128), 0x1::u128::pow(10, (v2 as u8)), 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::exchange_rate_one_to_one())
    }

    fun convert_to_meta_coin_to_coin_out_exchange_rate(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v2 = 18 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v0);
        if (v2 >= 38) {
            abort 0
        };
        0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::multiply_and_divide(0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::exchange_rate_one_to_one(), 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math::exchange_rate_one_to_one(), (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128) * 0x1::u128::pow(10, (v2 as u8)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultPythIntegration{
            id                  : 0x2::object::new(arg0),
            price_feed_registry : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<MetaVaultPythIntegration>(v0);
    }

    public fun price_feed_id<T0>(arg0: &MetaVaultPythIntegration) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0), 9223372358977323009);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_feed_registry, v0)
    }

    public fun set_price_feed_id<T0>(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &mut MetaVaultPythIntegration, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_feed_registry, 0x1::type_name::get<T0>(), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    // decompiled from Move bytecode v6
}

