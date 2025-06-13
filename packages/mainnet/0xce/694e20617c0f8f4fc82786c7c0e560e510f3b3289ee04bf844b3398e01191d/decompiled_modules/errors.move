module 0xce694e20617c0f8f4fc82786c7c0e560e510f3b3289ee04bf844b3398e01191d::errors {
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

