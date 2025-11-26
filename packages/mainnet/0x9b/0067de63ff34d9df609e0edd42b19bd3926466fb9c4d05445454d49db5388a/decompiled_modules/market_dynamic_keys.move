module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market_dynamic_keys {
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

