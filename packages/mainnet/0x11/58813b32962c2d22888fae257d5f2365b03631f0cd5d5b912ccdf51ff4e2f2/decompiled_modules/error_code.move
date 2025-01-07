module 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code {
    public fun extend_after_unlock() : u64 {
        101
    }

    public fun extend_to_shorter_duration() : u64 {
        102
    }

    public fun invalid_checkpoint_round() : u64 {
        901
    }

    public fun less_than_min_lock_amount() : u64 {
        201
    }

    public fun less_than_min_topup_amount() : u64 {
        301
    }

    public fun lock_not_over_yet() : u64 {
        401
    }

    public fun mul_div_overflow() : u64 {
        903
    }

    public fun nothing_to_redeem() : u64 {
        402
    }

    public fun protocol_disabled() : u64 {
        801
    }

    public fun protocol_version_downgrade() : u64 {
        803
    }

    public fun protocol_version_mismatch() : u64 {
        802
    }

    public fun renew_before_redeem() : u64 {
        501
    }

    public fun renew_before_unlock() : u64 {
        502
    }

    public fun should_refresh_first() : u64 {
        701
    }

    public fun topup_after_unlock() : u64 {
        302
    }

    public fun unlock_at_non_checkpoint() : u64 {
        604
    }

    public fun unlock_in_the_past() : u64 {
        601
    }

    public fun unlock_too_close_to_current_time() : u64 {
        603
    }

    public fun unlock_too_far_in_the_future() : u64 {
        602
    }

    public fun ve_sca_amount_overflow() : u64 {
        902
    }

    // decompiled from Move bytecode v6
}

