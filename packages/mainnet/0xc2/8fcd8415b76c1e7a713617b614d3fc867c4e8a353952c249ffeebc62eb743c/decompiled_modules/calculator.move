module 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::calculator {
    public fun calc_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 >= arg1 || arg0 == 0) {
            0
        } else {
            let v2 = 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::util::mul_div(arg0, arg1 - v0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::max_lock_duration());
            assert!(v2 > 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::ve_sca_amount_overflow());
            v2
        }
    }

    public fun get_unlock_round_time(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1 && arg0 <= 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::max_lock_rounds() - 1, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::invalid_checkpoint_round());
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        v0 + 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::unlock_round_duration() - v0 % 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::unlock_round_duration() + 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::unlock_round_duration() * arg0
    }

    public fun new_ve_sca_from_extending_lock(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg2 > arg1, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::extend_to_shorter_duration());
        calc_ve_sca(arg0, arg2, arg3) - calc_ve_sca(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

