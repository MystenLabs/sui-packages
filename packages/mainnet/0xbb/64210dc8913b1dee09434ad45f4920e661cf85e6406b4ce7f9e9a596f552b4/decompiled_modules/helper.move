module 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::helper {
    struct OraclePriceUsed has copy, drop, store {
        sui_per_deep: u64,
    }

    public(friend) fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 + 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_deep_required<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (is_pool_whitelisted<T0, T1>(arg0)) {
            0
        } else {
            let (v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg1, arg2);
            v1
        }
    }

    public(friend) fun calculate_market_order_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg2) {
            let (v2, _, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, arg1, arg3);
            let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
            (v2 - v2 % v6, v4)
        } else {
            let (_, _, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg1, 0, arg3);
            (arg1, v10)
        }
    }

    public(friend) fun calculate_order_amount(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::mul(arg0, arg1)
        } else {
            arg0
        }
    }

    public(friend) fun get_fee_bps<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        v0
    }

    public(friend) fun get_order_deep_price_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (bool, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0))
    }

    public(friend) fun get_sui_per_deep<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = get_sui_per_deep_from_oracle(arg0, arg1, arg3);
        if (0x1::option::is_none<u64>(&v0)) {
            get_sui_per_deep_from_reference_pool<T0, T1>(arg2, arg3)
        } else {
            0x1::option::extract<u64>(&mut v0)
        }
    }

    public(friend) fun get_sui_per_deep_from_oracle(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let (v0, v1) = 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::oracle::get_pyth_ema_price(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::oracle::get_pyth_ema_price(arg1, arg2);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price>(&v3) || 0x1::option::is_none<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price>(&v7)) {
            return 0x1::option::none<u64>()
        };
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) != 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::oracle::get_deep_price_fee_id() || 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v6) != 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::oracle::get_sui_price_fee_id()) {
            return 0x1::option::none<u64>()
        };
        let v8 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price>(&mut v3);
        let v9 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price>(&mut v7);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v8);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v10);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v9);
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v12);
        let v14 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v8);
        let v15 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v14);
        let v16 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v9);
        let v17 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v16);
        if (v15 == 0 || v17 == 0) {
            return 0x1::option::none<u64>()
        };
        let v18 = v13 + 3 >= v11;
        let v19 = if (v18) {
            v13 + 3 - v11
        } else {
            v11 - 3 - v13
        };
        let v20 = if (v18) {
            0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::div(v15 * 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::pow(10, v19), v17)
        } else {
            0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::div(v15, v17 * 0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::pow(10, v19))
        };
        let v21 = OraclePriceUsed{sui_per_deep: v20};
        0x2::event::emit<OraclePriceUsed>(v21);
        0x1::option::some<u64>(v20)
    }

    public(friend) fun get_sui_per_deep_from_reference_pool<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::registered_pool<T0, T1>(arg0), 13906834908782788609);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v3 = 0x1::type_name::get<0x2::sui::SUI>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 13906834960322396161);
        if (v0 == v2) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1)
        } else {
            0xbb64210dc8913b1dee09434ad45f4920e661cf85e6406b4ce7f9e9a596f552b4::math::div(1000000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1))
        }
    }

    public(friend) fun is_pool_whitelisted<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : bool {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)
    }

    public(friend) fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun validate_slippage(arg0: u64) {
        assert!(arg0 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), 13906835664697163779);
    }

    // decompiled from Move bytecode v6
}

