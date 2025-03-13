module 0x4fe103fb0c34d47bb0df88400af3d65584dd34145ae68c2fb96ad550f1999d56::error {
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

