module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error {
    public fun borrow_coin_type_error() : u64 {
        2
    }

    public fun difference_too_high() : u64 {
        3
    }

    public fun external_reward_platform_token() : u64 {
        4
    }

    public fun fee_too_high_error() : u64 {
        5
    }

    public fun high_slippage() : u64 {
        24
    }

    public fun incorrect_pool() : u64 {
        22
    }

    public fun input_error() : u64 {
        6
    }

    public fun insufficient_balance_error() : u64 {
        7
    }

    public fun insufficient_balance_to_add_liquidity() : u64 {
        8
    }

    public fun insufficient_deposit_amount() : u64 {
        9
    }

    public fun invalid_receipt_error() : u64 {
        10
    }

    public fun out_of_range() : u64 {
        23
    }

    public fun pending_rewards_error() : u64 {
        11
    }

    public fun pool_already_present_error() : u64 {
        12
    }

    public fun pool_has_weight_error() : u64 {
        13
    }

    public fun pool_not_present_error() : u64 {
        14
    }

    public fun pool_paused() : u64 {
        15
    }

    public fun position_existed() : u64 {
        25
    }

    public fun receipt_not_empty() : u64 {
        16
    }

    public fun reward_not_set_error() : u64 {
        17
    }

    public fun unlock_time_exceeded_error() : u64 {
        18
    }

    public fun version_mismatch_error() : u64 {
        1
    }

    public fun withdraw_before_cliff_error() : u64 {
        19
    }

    public fun wrong_platform_token_type() : u64 {
        21
    }

    public fun zero_deposit_error() : u64 {
        20
    }

    // decompiled from Move bytecode v6
}

