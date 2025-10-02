module 0xac75aa2dd3c4fd03f869971dfc57cf43383d38d311fac189dbbd5dec6c0670a6::errors {
    public fun err_amount_in_is_zero() : u64 {
        abort 3
    }

    public fun err_amount_out_slippage_check_failed() : u64 {
        abort 1
    }

    public fun err_invalid_fee_recipient() : u64 {
        abort 4
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

    // decompiled from Move bytecode v6
}

