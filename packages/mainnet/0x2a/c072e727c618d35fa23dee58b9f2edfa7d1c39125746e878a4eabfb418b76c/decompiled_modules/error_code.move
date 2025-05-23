module 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::error_code {
    public fun cannot_extend_after_unlock() : u64 {
        104
    }

    public fun cannot_unlock_earlier() : u64 {
        201
    }

    public fun invalid_round_number() : u64 {
        202
    }

    public fun less_than_min_lock_amount() : u64 {
        105
    }

    public fun less_than_min_topup_amount() : u64 {
        106
    }

    public fun lock_duration_too_long() : u64 {
        604
    }

    public fun lock_not_over_yet() : u64 {
        102
    }

    public fun mul_div_overflow() : u64 {
        801
    }

    public fun must_be_unlocked_before_reuse_expired_ve_sca_key() : u64 {
        402
    }

    public fun must_redeem_before_reuse_expired_ve_sca_key() : u64 {
        401
    }

    public fun nothing_to_redeem() : u64 {
        107
    }

    public fun protocol_disabled() : u64 {
        301
    }

    public fun protocol_version_can_only_increase() : u64 {
        701
    }

    public fun protocol_version_mismatch() : u64 {
        302
    }

    public fun should_locked_atleast_one_round() : u64 {
        603
    }

    public fun should_refresh_first() : u64 {
        601
    }

    public fun unlock_time_should_be_rounded() : u64 {
        602
    }

    public fun ve_sca_amount_overflow() : u64 {
        203
    }

    // decompiled from Move bytecode v6
}

