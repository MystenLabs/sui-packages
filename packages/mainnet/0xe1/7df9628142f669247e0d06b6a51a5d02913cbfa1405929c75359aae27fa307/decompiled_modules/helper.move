module 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::helper {
    public(friend) fun apply_discount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000000000, 7);
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg0, 1000000000 - arg1)
    }

    public(friend) fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 + 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_deep_required<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)) {
            0
        } else {
            let (v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg1, arg2);
            v1
        }
    }

    public(friend) fun calculate_discount_rate(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= arg2, 8);
        if (arg2 == 0) {
            return arg0
        };
        let v0 = arg2 - arg1;
        if (v0 == 0) {
            return 0
        };
        0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::div(0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg0, v0), arg2)
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
            0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::mul(arg0, arg1)
        } else {
            arg0
        }
    }

    public(friend) fun calculate_order_taker_maker_ratio(arg0: u64, arg1: u64, arg2: u8) : (u64, u64) {
        assert!(arg0 > 0, 9);
        assert!(arg1 <= arg0, 10);
        let v0 = arg1 < arg0 && (arg2 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::live() || arg2 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::partially_filled());
        let v1 = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::div(arg1, arg0);
        let v2 = if (v0) {
            1000000000 - v1
        } else {
            0
        };
        (v1, v2)
    }

    public fun current_version() : u16 {
        1
    }

    public(friend) fun get_fee_bps<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        v0
    }

    public(friend) fun get_order_deep_price_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : (bool, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0))
    }

    public(friend) fun get_pool_first_ask_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let (_, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
        let v4 = v2;
        assert!(!0x1::vector::is_empty<u64>(&v4), 4);
        *0x1::vector::borrow<u64>(&v4, 0)
    }

    public(friend) fun get_sui_per_deep<T0, T1>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = get_sui_per_deep_from_oracle(arg0, arg1, arg3);
        let v1 = get_sui_per_deep_from_reference_pool<T0, T1>(arg2, arg3);
        if (v0 > v1) {
            v0
        } else {
            v1
        }
    }

    public(friend) fun get_sui_per_deep_from_oracle(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::oracle::get_pyth_price(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::oracle::get_pyth_price(arg1, arg2);
        let v6 = v5;
        let v7 = v4;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::oracle::deep_price_feed_id() && 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v6) == 0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::oracle::sui_price_feed_id(), 3);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v7);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v8), 5);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v9), 5);
        let v10 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v8);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v9);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v7);
        let v14 = v11 + 3 >= v10;
        let v15 = if (v14) {
            v11 + 3 - v10
        } else {
            v10 - 3 - v11
        };
        assert!(v15 <= 19, 6);
        if (v14) {
            0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::div(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v12) * 0x1::u64::pow(10, (v15 as u8)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v13))
        } else {
            0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::div(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v12), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v13) * 0x1::u64::pow(10, (v15 as u8)))
        }
    }

    public(friend) fun get_sui_per_deep_from_reference_pool<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::registered_pool<T0, T1>(arg0), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v3 = 0x1::type_name::get<0x2::sui::SUI>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 1);
        if (v0 == v2) {
            get_pool_first_ask_price<T0, T1>(arg0, arg1)
        } else {
            0xe17df9628142f669247e0d06b6a51a5d02913cbfa1405929c75359aae27fa307::math::div(1000000000, get_pool_first_ask_price<T0, T1>(arg0, arg1))
        }
    }

    public(friend) fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun validate_slippage(arg0: u64) {
        assert!(arg0 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), 2);
    }

    // decompiled from Move bytecode v6
}

