module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors {
    public(friend) fun already_migrated() : u64 {
        24002
    }

    public(friend) fun cap_holder_mismatch() : u64 {
        24018
    }

    public(friend) fun f_token_deposit_insignificant() : u64 {
        20001
    }

    public(friend) fun f_token_invalid_params() : u64 {
        20004
    }

    public(friend) fun f_token_liquidity_exchange_price_unexpected() : u64 {
        20011
    }

    public(friend) fun f_token_liquidity_mode_unexpected() : u64 {
        20012
    }

    public(friend) fun f_token_min_amount_out() : u64 {
        20002
    }

    public(friend) fun f_token_unauthorized() : u64 {
        20005
    }

    public(friend) fun insufficient_assets() : u64 {
        24005
    }

    public(friend) fun insufficient_shares() : u64 {
        24003
    }

    public(friend) fun invalid_start_tvl() : u64 {
        24014
    }

    public(friend) fun invalid_window() : u64 {
        24015
    }

    public(friend) fun invalid_yearly_reward() : u64 {
        24021
    }

    public(friend) fun last_admin_not_removable() : u64 {
        24011
    }

    public(friend) fun lending_factory_liquidity_not_configured() : u64 {
        22004
    }

    public(friend) fun overlapping_window() : u64 {
        24017
    }

    public(friend) fun rebalance_gap_not_closed() : u64 {
        24013
    }

    public(friend) fun rewards_rate_above_cap() : u64 {
        24022
    }

    public(friend) fun rewards_still_configured() : u64 {
        24023
    }

    public(friend) fun role_already_assigned() : u64 {
        24009
    }

    public(friend) fun role_not_assigned() : u64 {
        24010
    }

    public(friend) fun vault_not_live() : u64 {
        24008
    }

    public(friend) fun window_in_past() : u64 {
        24016
    }

    public(friend) fun window_too_long() : u64 {
        24020
    }

    public(friend) fun wrong_reserve() : u64 {
        24006
    }

    public(friend) fun wrong_version() : u64 {
        24001
    }

    // decompiled from Move bytecode v7
}

