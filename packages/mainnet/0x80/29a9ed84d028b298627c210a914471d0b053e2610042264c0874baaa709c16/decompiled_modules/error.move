module 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::error {
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

    public fun zero_amount() : u64 {
        10
    }

    // decompiled from Move bytecode v6
}

