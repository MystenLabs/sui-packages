module 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules {
    public fun assert_for_extend_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::extend_after_unlock());
        assert!(arg0 > arg1, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::extend_to_shorter_duration());
        assert_new_unlock_at(arg0, arg2);
    }

    public fun assert_for_initial_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::constants::min_lock_amount(), 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::less_than_min_lock_amount());
        assert_new_unlock_at(arg1, arg2);
    }

    public fun assert_for_locking_more(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::topup_after_unlock());
        assert!(arg0 >= 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::constants::min_topup_amount(), 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::less_than_min_topup_amount());
    }

    public fun assert_for_redeem_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::lock_not_over_yet());
        assert!(arg0 > 0, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::nothing_to_redeem());
    }

    public fun assert_for_renew_expired_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 < 0x2::clock::timestamp_ms(arg2) / 1000, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::renew_before_unlock());
        assert!(arg0 == 0, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::renew_before_redeem());
    }

    public fun assert_new_unlock_at(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 > v0, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::unlock_in_the_past());
        assert!(arg0 % 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::constants::unlock_round_duration() == 0, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::unlock_at_non_checkpoint());
        assert!(arg0 - v0 <= 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::constants::max_lock_duration(), 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::unlock_too_far_in_the_future());
    }

    // decompiled from Move bytecode v6
}

