module 0xd0587f397e47d31a79d1c36710c2c28f48ff8f1e8ea73b6a54fa2ec6fdfe0a7d::errors {
    public fun allocated_lp_amount_exceed() : u64 {
        abort 13
    }

    public fun already_paused() : u64 {
        abort 8
    }

    public fun already_redeemed() : u64 {
        abort 5
    }

    public fun balance_not_enough() : u64 {
        abort 7
    }

    public fun invalid_version() : u64 {
        abort 1
    }

    public fun lock_time_not_end() : u64 {
        abort 4
    }

    public fun period_illegal() : u64 {
        abort 3
    }

    public fun pool_not_match() : u64 {
        abort 9
    }

    public fun position_attacked() : u64 {
        abort 11
    }

    public fun position_not_match() : u64 {
        abort 10
    }

    public fun version_deprecated() : u64 {
        abort 0
    }

    public fun vester_not_match() : u64 {
        abort 12
    }

    public fun vesting_paused() : u64 {
        abort 2
    }

    // decompiled from Move bytecode v6
}

