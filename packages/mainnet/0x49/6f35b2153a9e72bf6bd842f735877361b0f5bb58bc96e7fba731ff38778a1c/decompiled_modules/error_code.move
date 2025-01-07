module 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code {
    public fun cannot_extend_after_unlock() : u64 {
        104
    }

    public fun cannot_topup_after_unlock() : u64 {
        103
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

