module 0xc14866d64854a1dd6ecb417f32849f24daa662b3eb855226c40a144f767fe7f5::error {
    public fun already_whitelisted() : u64 {
        8
    }

    public fun inavlid_auth() : u64 {
        6
    }

    public fun inavlid_farm() : u64 {
        7
    }

    public fun invalid_reward_type() : u64 {
        1
    }

    public fun invalid_stake_receipt_for_farm() : u64 {
        5
    }

    public fun no_unharvested_rewards() : u64 {
        2
    }

    public fun not_whitelisted() : u64 {
        9
    }

    public fun reward_not_claimable() : u64 {
        4
    }

    public fun unstake_amount_too_much() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

