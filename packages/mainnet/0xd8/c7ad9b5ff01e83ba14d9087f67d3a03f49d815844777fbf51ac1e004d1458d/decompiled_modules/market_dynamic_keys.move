module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market_dynamic_keys {
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

