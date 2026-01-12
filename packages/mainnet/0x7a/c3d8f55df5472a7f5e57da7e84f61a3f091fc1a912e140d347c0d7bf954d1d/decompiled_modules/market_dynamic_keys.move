module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market_dynamic_keys {
    struct BorrowFeeKey has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
    }

    struct BorrowLimitKey has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
    }

    public fun borrow_fee_key(arg0: 0x1::type_name::TypeName) : BorrowFeeKey {
        BorrowFeeKey{asset_type: arg0}
    }

    public fun borrow_limit_key(arg0: 0x1::type_name::TypeName) : BorrowLimitKey {
        BorrowLimitKey{asset_type: arg0}
    }

    // decompiled from Move bytecode v6
}

