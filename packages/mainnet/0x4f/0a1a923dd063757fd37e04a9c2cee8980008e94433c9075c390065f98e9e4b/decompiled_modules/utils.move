module 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils {
    public fun calc_lock_duration_multiplier(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == arg2 || arg1 <= arg2) {
            return lock_multiplier_lower_bound()
        };
        lock_multiplier_lower_bound() + ((((arg3 - lock_multiplier_lower_bound()) as u128) * ((arg0 - arg2) as u128) / ((arg1 - arg2) as u128)) as u64)
    }

    public fun calc_multiplier_staked_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= lock_multiplier_lower_bound(), arg1);
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(arg0, arg1 - lock_multiplier_lower_bound())
    }

    public fun lock_multiplier_lower_bound() : u64 {
        1000000000000000000
    }

    public fun type_to_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

