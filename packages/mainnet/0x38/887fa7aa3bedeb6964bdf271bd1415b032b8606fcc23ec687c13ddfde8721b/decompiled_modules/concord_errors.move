module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors {
    public fun already_finalized() : u64 {
        23
    }

    public fun borrower_not_whitelisted() : u64 {
        27
    }

    public fun collateral_not_pledged() : u64 {
        38
    }

    public fun deposit_deadline_passed() : u64 {
        31
    }

    public fun funding_window_active() : u64 {
        33
    }

    public fun funding_window_expired() : u64 {
        34
    }

    public fun insufficient_buyout_amount() : u64 {
        52
    }

    public fun insufficient_collateral() : u64 {
        21
    }

    public fun insufficient_collateralization() : u64 {
        39
    }

    public fun insufficient_liquidity() : u64 {
        22
    }

    public fun invalid_amount() : u64 {
        57
    }

    public fun invalid_argument() : u64 {
        3
    }

    public fun invalid_buyout_amount() : u64 {
        58
    }

    public fun invalid_duration() : u64 {
        55
    }

    public fun invalid_interest_rate() : u64 {
        54
    }

    public fun invalid_interest_schedule() : u64 {
        56
    }

    public fun invalid_liquidator() : u64 {
        71
    }

    public fun invalid_ltv() : u64 {
        50
    }

    public fun invalid_principal_amount() : u64 {
        32
    }

    public fun invalid_state() : u64 {
        4
    }

    public fun lender_not_whitelisted() : u64 {
        26
    }

    public fun liquidation_not_configured() : u64 {
        72
    }

    public fun liquidation_not_triggered() : u64 {
        73
    }

    public fun loan_not_matured() : u64 {
        70
    }

    public fun ltv_not_configured() : u64 {
        40
    }

    public fun matcher_not_whitelisted() : u64 {
        28
    }

    public fun math_overflow() : u64 {
        7
    }

    public fun max_rate_exceeded() : u64 {
        53
    }

    public fun no_pending_upgrade() : u64 {
        60
    }

    public fun no_surplus_to_sweep() : u64 {
        35
    }

    public fun not_found() : u64 {
        5
    }

    public fun nothing_to_redeem() : u64 {
        82
    }

    public fun oracle_not_whitelisted() : u64 {
        25
    }

    public fun oracle_price_invalid() : u64 {
        42
    }

    public fun oracle_stale() : u64 {
        41
    }

    public fun paused() : u64 {
        2
    }

    public fun processor_cancel_too_early() : u64 {
        51
    }

    public fun request_has_deposits() : u64 {
        37
    }

    public fun self_match_forbidden() : u64 {
        20
    }

    public fun share_vault_mismatch() : u64 {
        80
    }

    public fun soft_cap_not_reached() : u64 {
        29
    }

    public fun token_not_whitelisted() : u64 {
        24
    }

    public fun unauthorized() : u64 {
        1
    }

    public fun upgrade_already_pending() : u64 {
        61
    }

    public fun upgrade_policy_too_permissive() : u64 {
        63
    }

    public fun upgrade_timelock_active() : u64 {
        62
    }

    public fun vault_already_deployed() : u64 {
        36
    }

    public fun vault_full() : u64 {
        30
    }

    public fun wrong_claim_method() : u64 {
        84
    }

    public fun wrong_governance() : u64 {
        64
    }

    public fun wrong_vault_mode() : u64 {
        83
    }

    public fun wrong_version() : u64 {
        6
    }

    public fun zero_shares() : u64 {
        81
    }

    // decompiled from Move bytecode v7
}

