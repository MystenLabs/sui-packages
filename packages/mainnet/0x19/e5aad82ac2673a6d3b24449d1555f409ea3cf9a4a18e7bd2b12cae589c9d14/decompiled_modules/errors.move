module 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors {
    public fun err_amount_in_is_zero() : u64 {
        abort 3
    }

    public fun err_amount_out_is_zero() : u64 {
        abort 8
    }

    public fun err_amount_out_limit_is_zero() : u64 {
        abort 11
    }

    public fun err_amount_out_slippage_check_failed() : u64 {
        abort 1
    }

    public fun err_exceed_max_amount_in() : u64 {
        abort 7
    }

    public fun err_expect_amount_out_overflow() : u64 {
        abort 13
    }

    public fun err_invalid_fee_recipient() : u64 {
        abort 4
    }

    public fun err_invalid_slippage() : u64 {
        abort 9
    }

    public fun err_missing_quote_guard() : u64 {
        abort 12
    }

    public fun err_not_support_b2a() : u64 {
        abort 6
    }

    public fun err_remains_balance() : u64 {
        abort 2
    }

    public fun err_too_large_fee_rate() : u64 {
        abort 5
    }

    // decompiled from Move bytecode v7
}

