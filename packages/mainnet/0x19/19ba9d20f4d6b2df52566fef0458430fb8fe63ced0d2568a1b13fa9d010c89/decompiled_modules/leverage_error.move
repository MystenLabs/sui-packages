module 0x1919ba9d20f4d6b2df52566fef0458430fb8fe63ced0d2568a1b13fa9d010c89::leverage_error {
    public fun borrow_coin_type_mismatch() : u64 {
        1000005
    }

    public fun cannot_repay_flash_loan() : u64 {
        1000008
    }

    public fun deposit_coin_type_mismatch() : u64 {
        1000006
    }

    public fun market_not_supported() : u64 {
        1000001
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

    public fun withdrawn_more_than_principle() : u64 {
        1000010
    }

    public fun withdrawn_too_much_collateral() : u64 {
        1000009
    }

    // decompiled from Move bytecode v6
}

