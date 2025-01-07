module 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::calculator {
    public fun calc_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 >= arg1) {
            0
        } else {
            0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::util::mul_div(arg0, arg1 - v0, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::constants::max_lock_duration())
        }
    }

    public fun get_unlock_round_time(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1 && arg0 <= 207, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::invalid_round_number());
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        v0 + 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::constants::unlock_round_duration() - v0 % 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::constants::unlock_round_duration() + 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::constants::unlock_round_duration() * arg0
    }

    public fun new_ve_sca_from_extending_lock(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg2 > arg1, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::cannot_unlock_earlier());
        calc_ve_sca(arg0, arg2, arg3) - calc_ve_sca(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

