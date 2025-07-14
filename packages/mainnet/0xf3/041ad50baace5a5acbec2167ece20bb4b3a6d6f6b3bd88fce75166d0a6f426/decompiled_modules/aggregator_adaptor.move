module 0xf3041ad50baace5a5acbec2167ece20bb4b3a6d6f6b3bd88fce75166d0a6f426::aggregator_adaptor {
    struct SwapInfo<phantom T0, phantom T1> {
        expected_amount_out: u64,
        slippage: u64,
    }

    struct Swap has drop {
        dummy_field: bool,
    }

    fun change_decimals(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 > arg2) {
            return arg0 / 0x1::u64::pow(10, arg1 - arg2)
        };
        if (arg1 < arg2) {
            return arg0 * 0x1::u64::pow(10, arg2 - arg1)
        };
        arg0
    }

    public fun get_expected_amount_out<T0, T1>(arg0: &SwapInfo<T0, T1>) : u64 {
        arg0.expected_amount_out
    }

    public fun initiate_swap<T0, T1, T2>(arg0: &mut 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::boring_vault::Vault<T0>, arg1: &0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::manager::GuardManager<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle::PriceFeedsMap<T0>, arg5: u64, arg6: u64, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapInfo<T1, T2>) {
        assert!(arg6 <= 500, 0);
        let v0 = b"";
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v2));
        let v3 = 0x1::option::some<vector<u8>>(v0);
        let v4 = Swap{dummy_field: false};
        let v5 = 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::manager::authorize_and_withdraw_if_needed<T1, Swap, T0>(arg0, arg1, v4, arg5, &v3, arg10);
        let v6 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v8 = 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle_operations::divide_safe(change_decimals(arg5, 0x2::coin::get_decimals<T1>(arg7), 0x2::coin::get_decimals<T2>(arg8)), 0x1::u64::pow(10, 0x2::coin::get_decimals<T2>(arg8)), 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle_operations::transform_price_to_decimal_format(0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle_operations::calculate_price_ratio(0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle::get_price<T0>(arg9, arg2, &v6, arg4, 60, 10), 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle::get_price<T0>(arg9, arg3, &v7, arg4, 60, 10), 0x1::u64::pow(10, 0x2::coin::get_decimals<T2>(arg8)))));
        assert!(v8 > 0, 2);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v5);
        let v9 = SwapInfo<T1, T2>{
            expected_amount_out : v8,
            slippage            : arg6,
        };
        (0x1::option::extract<0x2::coin::Coin<T1>>(&mut v5), v9)
    }

    public fun resolve_swap<T0, T1, T2>(arg0: &mut 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::boring_vault::Vault<T0>, arg1: SwapInfo<T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let SwapInfo {
            expected_amount_out : v0,
            slippage            : v1,
        } = arg1;
        assert!(0x2::coin::value<T2>(&arg2) >= 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle_operations::divide_safe(v0, 10000, 10000 - v1), 1);
        0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::manager::return_asset<T2, T0>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

