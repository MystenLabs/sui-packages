module 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code {
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

    public fun lock_duration_too_long() : u64 {
        604
    }

    public fun lock_not_over_yet() : u64 {
        102
    }

    public fun mul_div_overflow() : u64 {
        701
    }

    public fun protocol_disabled() : u64 {
        301
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

    // decompiled from Move bytecode v6
}

