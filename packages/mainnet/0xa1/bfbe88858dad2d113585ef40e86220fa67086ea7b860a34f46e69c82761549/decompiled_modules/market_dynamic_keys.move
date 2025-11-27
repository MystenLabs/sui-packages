module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market_dynamic_keys {
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

