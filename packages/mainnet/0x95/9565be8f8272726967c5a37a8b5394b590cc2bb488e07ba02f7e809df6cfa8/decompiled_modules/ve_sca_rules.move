module 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::ve_sca_rules {
    public fun assert_for_extend_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2) / 1000, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::cannot_extend_after_unlock());
        assert!(arg0 > arg1, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::cannot_unlock_earlier());
        assert_new_unlock_at(arg0, arg2);
    }

    public fun assert_for_initial_locking(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::constants::min_lock_amount(), 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::less_than_min_lock_amount());
        assert_new_unlock_at(arg1, arg2);
    }

    public fun assert_for_locking_more(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::constants::min_topup_amount(), 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::less_than_min_topup_amount());
        assert_new_unlock_at(arg1, arg2);
    }

    public fun assert_for_redeem_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg1, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::lock_not_over_yet());
        assert!(arg0 > 0, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::nothing_to_redeem());
    }

    public fun assert_for_renew_expired_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 < 0x2::clock::timestamp_ms(arg2) / 1000, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::must_be_unlocked_before_reuse_expired_ve_sca_key());
        assert!(arg0 == 0, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::must_redeem_before_reuse_expired_ve_sca_key());
    }

    public fun assert_new_unlock_at(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 > v0, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::cannot_unlock_earlier());
        assert!(arg0 % 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::constants::unlock_round_duration() == 0, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::unlock_time_should_be_rounded());
        assert!((arg0 - v0) / 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::constants::unlock_round_duration() >= 1, 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::should_locked_atleast_one_round());
        assert!(arg0 - v0 <= 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::constants::max_lock_duration(), 0x959565be8f8272726967c5a37a8b5394b590cc2bb488e07ba02f7e809df6cfa8::error_code::lock_duration_too_long());
    }

    // decompiled from Move bytecode v6
}

