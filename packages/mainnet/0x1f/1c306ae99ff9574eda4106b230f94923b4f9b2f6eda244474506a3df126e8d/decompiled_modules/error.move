module 0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::error {
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

