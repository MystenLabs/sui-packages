module 0xa329d8a3d499f6c811caa208455d81d648fe79ff04d8ffb351a52466a57958a4::fee {
    public(friend) fun calculate_deep_reserves_coverage_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    public(friend) fun calculate_full_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        calculate_deep_reserves_coverage_fee(arg0, arg1) + calculate_protocol_fee(arg0, arg2, arg3)
    }

    public(friend) fun calculate_protocol_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg1 <= arg2, 9223372457761570817);
        (((arg0 as u128) * (arg1 as u128) * (1000000000 as u128) / (arg2 as u128) * (3000000 as u128) / (1000000000 as u128) / (1000000000 as u128)) as u64)
    }

    public(friend) fun charge_deep_reserves_coverage_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_deep_reserves_coverage_fee(0x2::balance::value<T0>(v0), arg1))
    }

    public(friend) fun charge_full_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_full_fee(0x2::balance::value<T0>(v0), arg1, arg2, arg3))
    }

    public(friend) fun charge_protocol_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, calculate_protocol_fee(0x2::balance::value<T0>(v0), arg1, arg2))
    }

    public fun estimate_full_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : u64 {
        estimate_full_fee_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg1, arg2, arg3, arg4, 0xa329d8a3d499f6c811caa208455d81d648fe79ff04d8ffb351a52466a57958a4::helper::get_fee_bps<T0, T1>(arg0), arg5, arg6)
    }

    public(friend) fun estimate_full_fee_core(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64) : u64 {
        if (arg0 || !arg1) {
            0
        } else {
            calculate_full_fee(0xa329d8a3d499f6c811caa208455d81d648fe79ff04d8ffb351a52466a57958a4::helper::calculate_order_amount(arg2, arg3, arg4), arg5, arg6, arg7)
        }
    }

    // decompiled from Move bytecode v6
}

