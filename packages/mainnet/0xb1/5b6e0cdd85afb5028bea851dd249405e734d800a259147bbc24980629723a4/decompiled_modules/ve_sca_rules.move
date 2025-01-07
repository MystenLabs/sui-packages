module 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca_rules {
    public fun assert_for_extend_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::extend_after_unlock());
        assert!(arg0 > arg1, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::extend_to_shorter_duration());
        assert_new_unlock_at(arg0, arg2);
    }

    public fun assert_for_initial_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::min_lock_amount(), 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::less_than_min_lock_amount());
        assert_new_unlock_at(arg1, arg2);
    }

    public fun assert_for_locking_more(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::topup_after_unlock());
        assert!(arg0 >= 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::min_topup_amount(), 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::less_than_min_topup_amount());
    }

    public fun assert_for_redeem_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::lock_not_over_yet());
        assert!(arg0 > 0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::nothing_to_redeem());
    }

    public fun assert_for_renew_expired_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 < 0x2::clock::timestamp_ms(arg2) / 1000, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::renew_before_unlock());
        assert!(arg0 == 0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::renew_before_redeem());
    }

    public fun assert_new_unlock_at(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 > v0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::unlock_in_the_past());
        assert!(arg0 % 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::unlock_round_duration() == 0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::unlock_at_non_checkpoint());
        assert!(arg0 - v0 <= 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::max_lock_duration(), 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::unlock_too_far_in_the_future());
    }

    // decompiled from Move bytecode v6
}

