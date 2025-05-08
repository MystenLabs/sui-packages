module 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils {
    public(friend) fun max(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = 0x1::u64::max(v0, *0x1::vector::borrow<u64>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun calc_lock_multiplier(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 <= arg1 || arg2 <= arg1) {
            return lock_multiplier_lower_bound()
        };
        if (arg0 >= arg2) {
            return arg3
        };
        0x1::u64::min(lock_multiplier_lower_bound() + ((((arg3 - lock_multiplier_lower_bound()) as u128) * ((arg0 - arg1) as u128) / ((arg2 - arg1) as u128)) as u64), arg3)
    }

    public fun calc_multiplier_staked_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= lock_multiplier_lower_bound(), arg1);
        divide(multiply(arg0, arg1 - lock_multiplier_lower_bound()), 1000000000000000000)
    }

    public fun calc_number_of_emissions_from_time_tn_to_tm(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x1::u64::min(arg1, arg2);
        if (v0 <= arg0) {
            return 0
        };
        (v0 - arg0) / arg3
    }

    public fun calc_remaining_number_of_emissions(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    public(friend) fun divide(arg0: u128, arg1: u64) : u64 {
        ((arg0 / (arg1 as u128)) as u64)
    }

    public(friend) fun divide_into_u128(arg0: u128, arg1: u64) : u128 {
        arg0 / (arg1 as u128)
    }

    public(friend) fun divide_u128(arg0: u128, arg1: u64) : u64 {
        ((arg0 / (arg1 as u128)) as u64)
    }

    public fun lock_multiplier_lower_bound() : u64 {
        1000000000000000000
    }

    public(friend) fun multiply(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public(friend) fun multiply_u128(arg0: u128, arg1: u64) : u128 {
        arg0 * (arg1 as u128)
    }

    public(friend) fun sum(arg0: vector<u64>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg0);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        v0
    }

    public fun total_rewards_accumulated_per_share_scaling_factor() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

