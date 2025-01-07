module 0x12b190f688900912b4f6df1cabc0c9bb92a96053831a65864e17b0392d33e5d1::error {
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

