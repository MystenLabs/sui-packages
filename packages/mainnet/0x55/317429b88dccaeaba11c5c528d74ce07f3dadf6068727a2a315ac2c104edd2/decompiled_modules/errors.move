module 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::errors {
    public fun err_amount_in_is_zero() : u64 {
        abort 3
    }

    public fun err_invalid_fee_recipient() : u64 {
        abort 4
    }

    public fun err_less_amount_out() : u64 {
        abort 1
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

