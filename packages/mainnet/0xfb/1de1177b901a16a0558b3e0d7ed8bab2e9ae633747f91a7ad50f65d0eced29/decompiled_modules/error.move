module 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::error {
    public fun addLiquidityDisabled() : u64 {
        11
    }

    public fun address_not_whitelisted() : u64 {
        21
    }

    public fun amountZero() : u64 {
        16
    }

    public fun callerNotAdmin() : u64 {
        10
    }

    public fun claim_does_not_exist() : u64 {
        30
    }

    public fun deposit_amount_too_low() : u64 {
        29
    }

    public fun feeInvalid() : u64 {
        15
    }

    public fun incorrectPoolConstantPostSwap() : u64 {
        14
    }

    public fun insufficientBalance() : u64 {
        3
    }

    public fun invalidLPToken() : u64 {
        18
    }

    public fun invalid_pool() : u64 {
        31
    }

    public fun invalid_vault_cap() : u64 {
        20
    }

    public fun liquidityInsufficientAAmount() : u64 {
        5
    }

    public fun liquidityInsufficientBAmount() : u64 {
        4
    }

    public fun liquidityInsufficientMinted() : u64 {
        7
    }

    public fun liquidityOverLimitADesired() : u64 {
        6
    }

    public fun locked_base_asset_found() : u64 {
        22
    }

    public fun locked_quote_asset_found() : u64 {
        23
    }

    public fun notEnoughInitialLiquidity() : u64 {
        12
    }

    public fun removeAdminNotAllowed() : u64 {
        13
    }

    public fun reserveZero() : u64 {
        17
    }

    public fun reservesEmpty() : u64 {
        2
    }

    public fun strategy_not_active() : u64 {
        25
    }

    public fun strategy_not_ready_for_deposit_processing() : u64 {
        26
    }

    public fun strategy_not_ready_for_withdrawal_processing() : u64 {
        27
    }

    public fun strategy_not_ready_to_make_active() : u64 {
        24
    }

    public fun strategy_not_ready_to_start() : u64 {
        28
    }

    public fun swapOutLessthanExpected() : u64 {
        8
    }

    public fun unauthorized() : u64 {
        9
    }

    public fun version_mismatch() : u64 {
        19
    }

    public fun wrongFee() : u64 {
        1
    }

    public fun zeroAmount() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

