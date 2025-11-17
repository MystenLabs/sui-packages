module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market_dynamic_keys {
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

