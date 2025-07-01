module 0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::scallop_provider {
    struct ScallopProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_scallop_balance_sheet(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed {
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::new(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(1), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg0 + arg1 - arg2)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg3)), 0x2::clock::timestamp_ms(arg4) / 1000, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero())
    }

    public fun update_scallop_as_primary<T0, T1>(arg0: &0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::coin_registry::CoinRegistry, arg1: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::coin_registry::assert_pool_coin_type<T0, T1>(arg0);
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg4)), 0x1::type_name::get<T0>()));
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::update_price_feed_as_primary<T1, ScallopProvider>(arg1, arg2, price_feed_from_scallop_balance_sheet(v0, v1, v2, v3, arg3), arg3);
    }

    public fun update_scallop_as_secondary<T0, T1>(arg0: &0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::coin_registry::CoinRegistry, arg1: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &mut 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        0xd3944ddb6997ad8c8d45fff29a21db0c94830845a0f462f5525be4514ea6fd07::coin_registry::assert_pool_coin_type<T0, T1>(arg0);
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg4)), 0x1::type_name::get<T0>()));
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::update_price_feed_as_secondary<T1, ScallopProvider>(arg1, arg2, price_feed_from_scallop_balance_sheet(v0, v1, v2, v3, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

