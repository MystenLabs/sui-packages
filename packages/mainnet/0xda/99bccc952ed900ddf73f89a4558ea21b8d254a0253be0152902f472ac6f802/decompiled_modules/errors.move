module 0xda99bccc952ed900ddf73f89a4558ea21b8d254a0253be0152902f472ac6f802::errors {
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

