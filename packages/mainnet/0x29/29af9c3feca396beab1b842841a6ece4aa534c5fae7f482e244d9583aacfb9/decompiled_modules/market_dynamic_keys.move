module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys {
    struct BorrowFeeKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowFeeRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SupplyLimitKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    public fun borrow_fee_key(arg0: 0x1::type_name::TypeName) : BorrowFeeKey {
        BorrowFeeKey{type: arg0}
    }

    public fun borrow_fee_recipient_key() : BorrowFeeRecipientKey {
        BorrowFeeRecipientKey{dummy_field: false}
    }

    public fun supply_limit_key(arg0: 0x1::type_name::TypeName) : SupplyLimitKey {
        SupplyLimitKey{type: arg0}
    }

    // decompiled from Move bytecode v6
}

