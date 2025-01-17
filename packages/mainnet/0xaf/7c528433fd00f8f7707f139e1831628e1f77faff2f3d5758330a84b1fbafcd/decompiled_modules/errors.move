module 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::errors {
    public fun error_invalid_protocol_version() : u64 {
        1003
    }

    public fun error_invalid_time() : u64 {
        1001
    }

    public fun error_not_allow_stake() : u64 {
        1002
    }

    public fun error_not_enough_balance() : u64 {
        1006
    }

    public fun error_not_exist_reward_config() : u64 {
        1004
    }

    public fun error_reward_info_not_registered() : u64 {
        1010
    }

    public fun error_stake_position_staked_amount_not_zero() : u64 {
        1007
    }

    public fun error_user_position_not_exist() : u64 {
        1008
    }

    public fun error_value_overflow() : u64 {
        1005
    }

    public fun error_waiting_claim_reward_not_empty() : u64 {
        1009
    }

    // decompiled from Move bytecode v6
}

