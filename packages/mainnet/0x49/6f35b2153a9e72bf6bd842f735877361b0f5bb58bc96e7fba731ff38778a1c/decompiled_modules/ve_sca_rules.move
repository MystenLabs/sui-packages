module 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::ve_sca_rules {
    public fun assert_lock_amount_and_unlock_at_for_initial_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::constants::min_lock_amount(), 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::less_than_min_lock_amount());
        assert_unlock_at(arg1, arg2);
    }

    public fun assert_lock_amount_and_unlock_at_for_locking_more(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::constants::min_topup_amount(), 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::less_than_min_topup_amount());
        assert_unlock_at(arg1, arg2);
    }

    public fun assert_new_unlock_at_for_extend_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 > arg1, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::cannot_unlock_earlier());
        assert_unlock_at(arg0, arg2);
    }

    public fun assert_unlock_at(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 > v0, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::cannot_unlock_earlier());
        assert!(arg0 % 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::constants::unlock_round_duration() == 0, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::unlock_time_should_be_rounded());
        assert!((arg0 - v0) / 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::constants::unlock_round_duration() >= 1, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::should_locked_atleast_one_round());
        assert!(arg0 - v0 <= 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::constants::max_lock_duration(), 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::lock_duration_too_long());
    }

    public fun assert_unlock_at_for_redeem_sca(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::lock_not_over_yet());
    }

    // decompiled from Move bytecode v6
}

