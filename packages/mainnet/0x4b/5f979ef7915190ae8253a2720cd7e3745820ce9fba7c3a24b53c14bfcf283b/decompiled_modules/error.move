module 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error {
    public fun admin_error() : u64 {
        abort 5
    }

    public fun already_claimed_error() : u64 {
        abort 3
    }

    public fun claim_not_start_error() : u64 {
        abort 6
    }

    public fun no_allocate_error() : u64 {
        abort 2
    }

    public fun not_enough_fund_error() : u64 {
        abort 4
    }

    public fun start_time_error() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

