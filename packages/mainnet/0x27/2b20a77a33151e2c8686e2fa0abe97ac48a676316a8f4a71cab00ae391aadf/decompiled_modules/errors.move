module 0x272b20a77a33151e2c8686e2fa0abe97ac48a676316a8f4a71cab00ae391aadf::errors {
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

