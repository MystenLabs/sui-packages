module 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::fee {
    public(friend) fun calculate_deep_reserves_coverage_order_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg4) {
            if (arg1) {
                0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::mul(0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::div(arg0, arg2), arg3)
            } else {
                0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::div(arg0, arg2)
            }
        } else if (arg1) {
            0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::div(arg0, arg2)
        } else {
            0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::div(0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::math::div(arg0, arg2), arg3)
        }
    }

    public(friend) fun calculate_full_order_fee(arg0: u64, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64) : u64 {
        calculate_deep_reserves_coverage_order_fee(arg5, arg3, arg4, arg1, arg2) + calculate_protocol_fee(0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::helper::calculate_order_amount(arg0, arg1, arg2), arg5, arg6)
    }

    public(friend) fun calculate_protocol_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg1 <= arg2, 9223373067646926849);
        (((arg0 as u128) * (arg1 as u128) * (1000000000 as u128) / (arg2 as u128) * (3000000 as u128) / (1000000000 as u128) / (1000000000 as u128)) as u64)
    }

    public(friend) fun calculate_swap_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    public(friend) fun charge_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_swap_fee(0x2::balance::value<T0>(v0), arg1))
    }

    public fun estimate_full_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : u64 {
        let (v0, v1) = 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::helper::get_order_deep_price_params<T0, T1>(arg0);
        estimate_full_order_fee_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5, v0, v1, 0x4f34dd25cd33e46553ceb731a9fa3e955c195b62cf79a5c565c4225cb31667f::helper::calculate_deep_required<T0, T1>(arg0, arg3, arg4))
    }

    public(friend) fun estimate_full_order_fee_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: u64) : u64 {
        if (arg0 || !(arg1 + arg2 < arg8)) {
            0
        } else {
            calculate_full_order_fee(arg3, arg4, arg5, arg6, arg7, arg8 - arg1 - arg2, arg8)
        }
    }

    // decompiled from Move bytecode v6
}

