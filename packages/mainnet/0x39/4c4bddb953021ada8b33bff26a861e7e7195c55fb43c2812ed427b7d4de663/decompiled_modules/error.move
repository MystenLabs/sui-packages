module 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::error {
    public fun invalid_reward_type() : u64 {
        1
    }

    public fun invalid_stake_receipt_for_farm() : u64 {
        5
    }

    public fun no_unharvested_rewards() : u64 {
        2
    }

    public fun reward_not_claimable() : u64 {
        4
    }

    public fun unstake_amount_too_much() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

