module 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types {
    struct InterestRateTier has copy, drop, store {
        from_seconds: u64,
        rate_bps: u64,
    }

    public fun collateral_policy_direct_claim() : u8 {
        0
    }

    public fun collateral_policy_liquidator_buyout() : u8 {
        1
    }

    public fun is_collateral_claim_mode(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_loan_finalized(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    public fun is_principal_redeemable_mode(arg0: u8) : bool {
        if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    public fun is_request_open(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_valid_collateral_policy(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun is_valid_liquidation_trigger(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun liquidation_trigger_open() : u8 {
        0
    }

    public fun liquidation_trigger_whitelisted_only() : u8 {
        1
    }

    public fun loan_active() : u8 {
        0
    }

    public fun loan_bought_out() : u8 {
        4
    }

    public fun loan_defaulted() : u8 {
        2
    }

    public fun loan_liquidated() : u8 {
        3
    }

    public fun loan_repaid() : u8 {
        1
    }

    public fun new_interest_rate_tier(arg0: u64, arg1: u64) : InterestRateTier {
        InterestRateTier{
            from_seconds : arg0,
            rate_bps     : arg1,
        }
    }

    public fun request_active() : u8 {
        0
    }

    public fun request_cancelled() : u8 {
        2
    }

    public fun request_matched() : u8 {
        1
    }

    public fun tier_from_seconds(arg0: &InterestRateTier) : u64 {
        arg0.from_seconds
    }

    public fun tier_rate_bps(arg0: &InterestRateTier) : u64 {
        arg0.rate_bps
    }

    public fun vault_mode_active() : u8 {
        1
    }

    public fun vault_mode_closed() : u8 {
        4
    }

    public fun vault_mode_collecting() : u8 {
        0
    }

    public fun vault_mode_defaulted() : u8 {
        3
    }

    public fun vault_mode_settled() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

