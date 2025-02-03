module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market_dynamic_keys {
    struct BorrowFeeKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowFeeRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow_fee_key(arg0: 0x1::type_name::TypeName) : BorrowFeeKey {
        BorrowFeeKey{type: arg0}
    }

    public fun borrow_fee_recipient_key() : BorrowFeeRecipientKey {
        BorrowFeeRecipientKey{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

