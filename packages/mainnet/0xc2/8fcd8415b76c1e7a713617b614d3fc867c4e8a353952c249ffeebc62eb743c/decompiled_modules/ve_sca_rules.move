module 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::ve_sca_rules {
    public fun assert_for_extend_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::extend_after_unlock());
        assert!(arg0 > arg1, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::extend_to_shorter_duration());
        assert_new_unlock_at(arg0, arg2);
    }

    public fun assert_for_initial_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::min_lock_amount(), 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::less_than_min_lock_amount());
        assert_new_unlock_at(arg1, arg2);
    }

    public fun assert_for_locking_more(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::topup_after_unlock());
        assert!(arg0 >= 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::min_topup_amount(), 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::less_than_min_topup_amount());
    }

    public fun assert_for_merge_ve_sca(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        assert!(arg1 > v0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::merge_after_unlock());
        assert!(arg3 > v0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::merge_after_unlock());
        assert!(arg0 > 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::merge_zero_amount());
        assert!(arg2 > 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::merge_zero_amount());
        assert!(arg4 == arg0 + arg2, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::fatal_error());
        assert!(arg5 == 0x1::u64::max(arg1, arg3), 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::fatal_error());
        assert!(arg6 == 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::fatal_error());
        assert!(arg7 == arg3, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::fatal_error());
    }

    public fun assert_for_redeem_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::lock_not_over_yet());
        assert!(arg0 > 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::nothing_to_redeem());
    }

    public fun assert_for_renew_expired_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 < 0x2::clock::timestamp_ms(arg2) / 1000, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::renew_before_unlock());
        assert!(arg0 == 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::renew_before_redeem());
    }

    public fun assert_new_unlock_at(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 > v0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::unlock_in_the_past());
        assert!(arg0 % 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::unlock_round_duration() == 0, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::unlock_at_non_checkpoint());
        assert!(arg0 - v0 <= 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::constants::max_lock_duration(), 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::unlock_too_far_in_the_future());
    }

    // decompiled from Move bytecode v6
}

