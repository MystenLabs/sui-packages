module 0xcfdf422e99550a786bbca6a478a4d319c348ea172dd64b62d93b96c91ebf4731::errors {
    public fun add_check_failed() : u64 {
        1017
    }

    public fun insufficient_amount() : u64 {
        1003
    }

    public fun insufficient_coin_balance() : u64 {
        1004
    }

    public fun insufficient_liquidity() : u64 {
        1015
    }

    public fun insufficient_pool_balance() : u64 {
        1005
    }

    public fun invalid_coins() : u64 {
        1013
    }

    public fun invalid_fee_growth() : u64 {
        1016
    }

    public fun invalid_last_update_time() : u64 {
        1022
    }

    public fun invalid_observation_timestamp() : u64 {
        1014
    }

    public fun invalid_pool() : u64 {
        1011
    }

    public fun invalid_price_limit() : u64 {
        1009
    }

    public fun invalid_tick_range() : u64 {
        1002
    }

    public fun invalid_timestamp() : u64 {
        1020
    }

    public fun non_empty_position() : u64 {
        1018
    }

    public fun not_authorized() : u64 {
        1023
    }

    public fun overflow() : u64 {
        1008
    }

    public fun pool_is_paused() : u64 {
        1012
    }

    public fun position_does_not_belong_to_pool() : u64 {
        1019
    }

    public fun reward_index_not_found() : u64 {
        1021
    }

    public fun slippage_exceeds() : u64 {
        1010
    }

    public fun swap_amount_exceeds() : u64 {
        1007
    }

    public fun tick_score_out_of_bounds() : u64 {
        1006
    }

    public fun update_rewards_info_check_failed() : u64 {
        1024
    }

    public fun version_mismatch() : u64 {
        1001
    }

    // decompiled from Move bytecode v6
}

