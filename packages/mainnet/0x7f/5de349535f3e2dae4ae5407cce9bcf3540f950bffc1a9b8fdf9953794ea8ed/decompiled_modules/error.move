module 0x7f5de349535f3e2dae4ae5407cce9bcf3540f950bffc1a9b8fdf9953794ea8ed::error {
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

