module 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::errors {
    public fun already_redeemed() : u64 {
        abort 8
    }

    public fun amount_overflow() : u64 {
        abort 3
    }

    public fun balance_not_enough() : u64 {
        abort 9
    }

    public fun invalid_version() : u64 {
        abort 1
    }

    public fun lock_time_not_end() : u64 {
        abort 7
    }

    public fun not_attacked_position() : u64 {
        abort 12
    }

    public fun percentage_not_equal() : u64 {
        abort 4
    }

    public fun period_illegal() : u64 {
        abort 6
    }

    public fun pool_not_match() : u64 {
        abort 10
    }

    public fun position_not_match() : u64 {
        abort 11
    }

    public fun release_time_error() : u64 {
        abort 2
    }

    public fun version_deprecated() : u64 {
        abort 0
    }

    public fun vesting_paused() : u64 {
        abort 5
    }

    public fun vesting_period_not_match() : u64 {
        abort 13
    }

    // decompiled from Move bytecode v6
}

