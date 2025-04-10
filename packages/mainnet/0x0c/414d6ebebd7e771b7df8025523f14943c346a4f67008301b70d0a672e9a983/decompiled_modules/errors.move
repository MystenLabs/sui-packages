module 0xc414d6ebebd7e771b7df8025523f14943c346a4f67008301b70d0a672e9a983::errors {
    public fun err_incorrect_amount_in() : u64 {
        abort 1
    }

    public fun err_incorrect_amount_out() : u64 {
        abort 2
    }

    public fun err_invalid_version() : u64 {
        abort 5
    }

    public fun err_max_fee_rate_limit() : u64 {
        abort 3
    }

    public fun err_version_deprecated() : u64 {
        abort 4
    }

    // decompiled from Move bytecode v6
}

