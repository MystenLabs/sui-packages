module 0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::fee {
    public(friend) fun calculate_deep_reserves_coverage_order_fee(arg0: u64, arg1: u64) : u64 {
        0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::math::mul(arg1, arg0)
    }

    public(friend) fun calculate_full_order_fee(arg0: u64, arg1: u64) : u64 {
        calculate_deep_reserves_coverage_order_fee(arg0, arg1) + calculate_protocol_fee(arg0, arg1)
    }

    public(friend) fun calculate_protocol_fee(arg0: u64, arg1: u64) : u64 {
        0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::math::mul(0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::math::mul(arg1, 10000000), arg0)
    }

    public(friend) fun calculate_swap_fee(arg0: u64, arg1: u64) : u64 {
        0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::math::mul(arg0, arg1)
    }

    public(friend) fun charge_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_swap_fee(0x2::balance::value<T0>(v0), arg1))
    }

    public fun estimate_full_fee<T0, T1, T2, T3>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        estimate_full_order_fee_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg2, arg3, 0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::helper::calculate_deep_required<T0, T1>(arg0, arg4, arg5), 0x86cfd26fca8ca4dec9bc5ef6b11126b98cdd4ca4a91ea9516ec6ffd94a66336e::helper::get_sui_per_deep<T2, T3>(arg1, arg6))
    }

    public(friend) fun estimate_full_order_fee_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 || !(arg1 + arg2 < arg3)) {
            0
        } else {
            calculate_full_order_fee(arg4, arg3 - arg1 - arg2)
        }
    }

    // decompiled from Move bytecode v6
}

