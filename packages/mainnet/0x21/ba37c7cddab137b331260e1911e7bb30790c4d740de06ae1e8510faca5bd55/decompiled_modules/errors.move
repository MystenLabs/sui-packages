module 0x21ba37c7cddab137b331260e1911e7bb30790c4d740de06ae1e8510faca5bd55::errors {
    public fun err_amount_in_is_zero() : u64 {
        abort 0
    }

    public fun err_amount_out_slippage_check_failed() : u64 {
        abort 3
    }

    public fun err_exceed_max_amount_in() : u64 {
        abort 4
    }

    public fun err_invalid_fee_recipient() : u64 {
        abort 1
    }

    public fun err_not_support_b2a() : u64 {
        abort 5
    }

    public fun err_remains_balance() : u64 {
        abort 6
    }

    public fun err_target_mismatch() : u64 {
        abort 7
    }

    public fun err_target_not_found() : u64 {
        abort 8
    }

    public fun err_too_large_fee_rate() : u64 {
        abort 2
    }

    // decompiled from Move bytecode v6
}

