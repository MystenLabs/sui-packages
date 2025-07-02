module 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors {
    public fun err_coin_not_in_vault() : u64 {
        abort 9
    }

    public fun err_expired() : u64 {
        abort 12
    }

    public fun err_incorrect_amount_in() : u64 {
        abort 1
    }

    public fun err_incorrect_amount_out() : u64 {
        abort 2
    }

    public fun err_insufficient_balance() : u64 {
        abort 13
    }

    public fun err_invalid_amount() : u64 {
        abort 8
    }

    public fun err_invalid_cap() : u64 {
        abort 7
    }

    public fun err_invalid_coin_type() : u64 {
        abort 6
    }

    public fun err_invalid_nonce() : u64 {
        abort 15
    }

    public fun err_invalid_signature() : u64 {
        abort 11
    }

    public fun err_invalid_signer() : u64 {
        abort 10
    }

    public fun err_invalid_version() : u64 {
        abort 5
    }

    public fun err_max_fee_rate_limit() : u64 {
        abort 3
    }

    public fun err_scheme_not_support() : u64 {
        abort 14
    }

    public fun err_version_deprecated() : u64 {
        abort 4
    }

    // decompiled from Move bytecode v6
}

