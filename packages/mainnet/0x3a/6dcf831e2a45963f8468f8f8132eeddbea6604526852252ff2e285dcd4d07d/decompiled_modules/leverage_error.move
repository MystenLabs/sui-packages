module 0x3a6dcf831e2a45963f8468f8f8132eeddbea6604526852252ff2e285dcd4d07d::leverage_error {
    public fun already_assigned_caller_cap() : u64 {
        1000015
    }

    public fun borrow_coin_type_mismatch() : u64 {
        1000005
    }

    public fun cannot_repay_flash_loan() : u64 {
        1000008
    }

    public fun deposit_coin_type_mismatch() : u64 {
        1000006
    }

    public fun inconsistent_total_leverage_value() : u64 {
        1000020
    }

    public fun invalid_market() : u64 {
        1000013
    }

    public fun leverage_not_on_going() : u64 {
        1000018
    }

    public fun leverage_on_going() : u64 {
        1000017
    }

    public fun market_already_exists() : u64 {
        1000014
    }

    public fun market_not_found() : u64 {
        1000011
    }

    public fun market_not_supported() : u64 {
        1000001
    }

    public fun no_caller_cap() : u64 {
        1000016
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    public fun token_amount_not_expected_value() : u64 {
        1000019
    }

    public fun version_mismatch() : u64 {
        1000012
    }

    public fun withdrawn_too_much_collateral() : u64 {
        1000009
    }

    // decompiled from Move bytecode v6
}

