module 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error {
    public fun borrow_coin_type_error() : u64 {
        101
    }

    public fun fee_too_high_error() : u64 {
        200
    }

    public fun input_error() : u64 {
        301
    }

    public fun insufficient_balance_error() : u64 {
        103
    }

    public fun invalid_receipt_error() : u64 {
        102
    }

    public fun pending_rewards_error() : u64 {
        305
    }

    public fun pool_already_present_error() : u64 {
        302
    }

    public fun pool_has_weight_error() : u64 {
        304
    }

    public fun pool_not_present_error() : u64 {
        303
    }

    public fun reward_not_set_error() : u64 {
        300
    }

    public fun version_mismatch_error() : u64 {
        0
    }

    public fun withdraw_before_cliff_error() : u64 {
        201
    }

    public fun zero_deposit_error() : u64 {
        100
    }

    // decompiled from Move bytecode v6
}

