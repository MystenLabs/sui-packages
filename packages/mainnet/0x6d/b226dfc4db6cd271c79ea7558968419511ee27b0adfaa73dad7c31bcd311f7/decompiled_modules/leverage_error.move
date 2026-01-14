module 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_error {
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

    public fun version_mismatch() : u64 {
        1000012
    }

    public fun withdrawn_too_much_collateral() : u64 {
        1000009
    }

    // decompiled from Move bytecode v6
}

