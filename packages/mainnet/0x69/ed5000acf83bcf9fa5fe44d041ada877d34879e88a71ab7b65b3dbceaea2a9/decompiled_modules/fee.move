module 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::fee {
    public(friend) fun calculate_deep_reserves_coverage_order_fee(arg0: u64, arg1: u64) : u64 {
        0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(arg1, arg0)
    }

    public(friend) fun calculate_fee_by_rate(arg0: u64, arg1: u64) : u64 {
        0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_full_order_fee(arg0: u64, arg1: u64) : (u64, u64, u64) {
        let v0 = calculate_deep_reserves_coverage_order_fee(arg0, arg1);
        let v1 = calculate_protocol_fee(arg0, arg1);
        (v0 + v1, v0, v1)
    }

    public(friend) fun calculate_input_coin_deepbook_fee(arg0: u64, arg1: u64) : u64 {
        calculate_fee_by_rate(arg0, 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()))
    }

    public(friend) fun calculate_input_coin_protocol_fee(arg0: u64, arg1: u64) : u64 {
        0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(calculate_fee_by_rate(arg0, arg1), 750000000)
    }

    public(friend) fun calculate_protocol_fee(arg0: u64, arg1: u64) : u64 {
        0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::math::mul(arg1, 10000000), arg0)
    }

    public(friend) fun charge_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_fee_by_rate(0x2::balance::value<T0>(v0), arg1))
    }

    public fun estimate_full_fee_limit<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        abort 1000
    }

    public fun estimate_full_fee_limit_v2<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        abort 1000
    }

    public fun estimate_full_fee_limit_v3<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::helper::calculate_deep_required<T0, T1>(arg0, arg6, arg7);
        let (v1, v2, v3) = estimate_full_order_fee_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg4, arg5, v0, 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::helper::get_sui_per_deep<T2, T3>(arg2, arg3, arg1, arg8));
        (v1, v2, v3, v0)
    }

    public fun estimate_full_fee_market<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        abort 1000
    }

    public fun estimate_full_fee_market_v2<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        abort 1000
    }

    public fun estimate_full_fee_market_v3<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let (_, v1) = 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::helper::calculate_market_order_params<T0, T1>(arg0, arg6, arg7, arg8);
        let (v2, v3, v4) = estimate_full_order_fee_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg4, arg5, v1, 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::helper::get_sui_per_deep<T2, T3>(arg2, arg3, arg1, arg8));
        (v2, v3, v4, v1)
    }

    public(friend) fun estimate_full_order_fee_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        if (arg0 || !(arg1 + arg2 < arg3)) {
            (0, 0, 0)
        } else {
            calculate_full_order_fee(arg4, arg3 - arg1 - arg2)
        }
    }

    // decompiled from Move bytecode v6
}

