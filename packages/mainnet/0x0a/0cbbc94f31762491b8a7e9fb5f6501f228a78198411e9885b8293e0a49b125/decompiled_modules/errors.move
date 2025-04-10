module 0xa0cbbc94f31762491b8a7e9fb5f6501f228a78198411e9885b8293e0a49b125::errors {
    public fun err_incorrect_amount() : u64 {
        abort 1
    }

    public fun err_invalid_version() : u64 {
        abort 4
    }

    public fun err_max_fee_rate_limit() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 3
    }

    // decompiled from Move bytecode v6
}

