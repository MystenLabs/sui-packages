module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys {
    struct BorrowFeeKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowFeeRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SupplyLimitKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowLimitKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct IsolatedAssetKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    public fun borrow_fee_key(arg0: 0x1::type_name::TypeName) : BorrowFeeKey {
        BorrowFeeKey{type: arg0}
    }

    public fun borrow_fee_recipient_key() : BorrowFeeRecipientKey {
        BorrowFeeRecipientKey{dummy_field: false}
    }

    public fun borrow_limit_key(arg0: 0x1::type_name::TypeName) : BorrowLimitKey {
        BorrowLimitKey{type: arg0}
    }

    public fun isolated_asset_key(arg0: 0x1::type_name::TypeName) : IsolatedAssetKey {
        IsolatedAssetKey{type: arg0}
    }

    public fun supply_limit_key(arg0: 0x1::type_name::TypeName) : SupplyLimitKey {
        SupplyLimitKey{type: arg0}
    }

    // decompiled from Move bytecode v6
}

