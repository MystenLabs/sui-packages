module 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::oracle {
    struct PythConfig has drop, store {
        currencies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinTypeData>,
        max_age_secs: u64,
    }

    struct CoinTypeData has copy, drop, store {
        decimals: u8,
        price_feed_id: vector<u8>,
        type_name: 0x1::type_name::TypeName,
    }

    struct ConversionConfig has copy, drop {
        target_decimals: u8,
        base_decimals: u8,
        pyth_price: u64,
        pyth_decimals: u8,
    }

    public(friend) fun calculate_target_amount<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::MarginRegistry, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        calculate_target_currency_amount(price_config<T0>(arg0, arg1, false, arg3), arg2)
    }

    public(friend) fun calculate_target_currency_amount(arg0: ConversionConfig, arg1: u64) : u64 {
        assert!(arg0.pyth_price > 0, 1);
        (0x1::u128::divide_and_round_up(0x1::u128::divide_and_round_up((arg1 as u128) * 0x1::u128::pow(10, 10 + arg0.target_decimals + arg0.pyth_decimals - arg0.base_decimals), (arg0.pyth_price as u128)), 0x1::u128::pow(10, 10)) as u64)
    }

    public(friend) fun calculate_usd_currency_amount(arg0: ConversionConfig, arg1: u64) : u64 {
        assert!(arg0.pyth_price > 0, 1);
        (0x1::u128::divide_and_round_up(0x1::u128::divide_and_round_up((arg1 as u128) * (arg0.pyth_price as u128), 0x1::u128::pow(10, arg0.pyth_decimals)) * 0x1::u128::pow(10, 10), 0x1::u128::pow(10, 10 + arg0.base_decimals - arg0.target_decimals)) as u64)
    }

    public(friend) fun calculate_usd_price<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::MarginRegistry, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        calculate_usd_currency_amount(price_config<T0>(arg0, arg1, true, arg3), arg2)
    }

    fun get_config_for_type<T0>(arg0: &0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::MarginRegistry) : CoinTypeData {
        let v0 = 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::get_config<PythConfig>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1), 2);
        *0x2::vec_map::get<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1)
    }

    public fun new_coin_type_data<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: vector<u8>) : CoinTypeData {
        CoinTypeData{
            decimals      : 0x2::coin::get_decimals<T0>(arg0),
            price_feed_id : arg1,
            type_name     : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun new_pyth_config(arg0: vector<CoinTypeData>, arg1: u64) : PythConfig {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, CoinTypeData>();
        0x1::vector::reverse<CoinTypeData>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<CoinTypeData>(&arg0)) {
            let v2 = 0x1::vector::pop_back<CoinTypeData>(&mut arg0);
            0x2::vec_map::insert<0x1::type_name::TypeName, CoinTypeData>(&mut v0, v2.type_name, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<CoinTypeData>(arg0);
        PythConfig{
            currencies   : v0,
            max_age_secs : arg1,
        }
    }

    fun price_config<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::MarginRegistry, arg2: bool, arg3: &0x2::clock::Clock) : ConversionConfig {
        let v0 = get_config_for_type<T0>(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg3, 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::get_config<PythConfig>(arg1).max_age_secs);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3) == v0.price_feed_id, 3);
        let v4 = if (arg2) {
            9
        } else {
            v0.decimals
        };
        let v5 = if (arg2) {
            v0.decimals
        } else {
            9
        };
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        ConversionConfig{
            target_decimals : v4,
            base_decimals   : v5,
            pyth_price      : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6),
            pyth_decimals   : (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v7) as u8),
        }
    }

    // decompiled from Move bytecode v6
}

