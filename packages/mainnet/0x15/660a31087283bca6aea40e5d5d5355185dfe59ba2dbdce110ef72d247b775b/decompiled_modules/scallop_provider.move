module 0x15660a31087283bca6aea40e5d5d5355185dfe59ba2dbdce110ef72d247b775b::scallop_provider {
    struct ScallopProvider has drop {
        dummy_field: bool,
    }

    fun exchange_rate_from_scallop_balance_sheet(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg0 + arg1 - arg2), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg3))
    }

    fun price_feed_from_scallop_balance_sheet_and_pyth(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed {
        let (v0, v1, v2) = unpack_pyth_price_info_object(arg4);
        let v3 = exchange_rate_from_scallop_balance_sheet(arg0, arg1, arg2, arg3);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::new(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(v0, v3), v2, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(v1, v3))
    }

    fun unpack_pyth_price_info_object(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2);
        let v4 = if (v3) {
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8)))
        } else {
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6) as u8)))
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let (v8, v9) = if (v3) {
            (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7)), v4), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v1)), v4))
        } else {
            (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7)), v4), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v1)), v4))
        };
        let v10 = v8;
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&v10), 0);
        (v10, v9, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1))
    }

    public fun update_scallop_as_primary<T0, T1>(arg0: &0x15660a31087283bca6aea40e5d5d5355185dfe59ba2dbdce110ef72d247b775b::coin_registry::CoinRegistry, arg1: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        0x15660a31087283bca6aea40e5d5d5355185dfe59ba2dbdce110ef72d247b775b::coin_registry::assert_pyth_object_info_and_coins<T0, T1>(arg0, arg4);
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg5)), 0x1::type_name::get<T0>()));
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::update_price_feed_as_primary<T1, ScallopProvider>(arg1, arg2, price_feed_from_scallop_balance_sheet_and_pyth(v0, v1, v2, v3, arg4), arg3);
    }

    public fun update_scallop_as_secondary<T0, T1>(arg0: &0x15660a31087283bca6aea40e5d5d5355185dfe59ba2dbdce110ef72d247b775b::coin_registry::CoinRegistry, arg1: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        0x15660a31087283bca6aea40e5d5d5355185dfe59ba2dbdce110ef72d247b775b::coin_registry::assert_pyth_object_info_and_coins<T0, T1>(arg0, arg4);
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg5)), 0x1::type_name::get<T0>()));
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::update_price_feed_as_secondary<T1, ScallopProvider>(arg1, arg2, price_feed_from_scallop_balance_sheet_and_pyth(v0, v1, v2, v3, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

