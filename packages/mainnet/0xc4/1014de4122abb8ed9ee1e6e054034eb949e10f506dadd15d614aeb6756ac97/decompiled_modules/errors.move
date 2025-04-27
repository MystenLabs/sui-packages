module 0xc41014de4122abb8ed9ee1e6e054034eb949e10f506dadd15d614aeb6756ac97::errors {
    public fun already_claimed_error() : u64 {
        abort 4
    }

    public fun claim_has_end_error() : u64 {
        abort 7
    }

    public fun claim_not_start_error() : u64 {
        abort 6
    }

    public fun end_time_error() : u64 {
        abort 2
    }

    public fun err_invalid_version() : u64 {
        abort 9
    }

    public fun err_not_vesta_manager() : u64 {
        abort 10
    }

    public fun err_version_deprecated() : u64 {
        abort 8
    }

    public fun no_allocate_error() : u64 {
        abort 3
    }

    public fun not_enough_fund_error() : u64 {
        abort 5
    }

    public fun start_time_error() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

