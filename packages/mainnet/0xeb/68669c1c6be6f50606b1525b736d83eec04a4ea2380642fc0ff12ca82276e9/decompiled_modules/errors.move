module 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors {
    public fun error_invalid_protocol_version() : u64 {
        1003
    }

    public fun error_invalid_time() : u64 {
        1001
    }

    public fun error_max_staked_amount() : u64 {
        1013
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

    public fun error_suspicious_position() : u64 {
        1011
    }

    public fun error_user_position_already_exists() : u64 {
        1012
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

