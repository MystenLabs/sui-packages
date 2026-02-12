module 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_error {
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

    public fun obligation_already_has_position() : u64 {
        1000002
    }

    public fun obligation_inconsistent_operation() : u64 {
        1000004
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    public fun principle_not_intact() : u64 {
        1000007
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

