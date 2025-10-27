module 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys {
    struct BorrowFeeKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowFeeRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SupplyLimitKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct MinCollateralAmountKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct BorrowLimitKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct IsolatedAssetKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct MinPriceHistoryKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct ApmThresholdKey has copy, drop, store {
        type: 0x1::type_name::TypeName,
    }

    struct PauseAuthorityRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun apm_threshold_key(arg0: 0x1::type_name::TypeName) : ApmThresholdKey {
        ApmThresholdKey{type: arg0}
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

    public fun delegated_authorize_key() : BorrowFeeRecipientKey {
        BorrowFeeRecipientKey{dummy_field: false}
    }

    public fun isolated_asset_key(arg0: 0x1::type_name::TypeName) : IsolatedAssetKey {
        IsolatedAssetKey{type: arg0}
    }

    public fun min_collateral_amount_key(arg0: 0x1::type_name::TypeName) : MinCollateralAmountKey {
        MinCollateralAmountKey{type: arg0}
    }

    public fun min_price_history_key(arg0: 0x1::type_name::TypeName) : MinPriceHistoryKey {
        MinPriceHistoryKey{type: arg0}
    }

    public fun pause_authority_registry_key() : PauseAuthorityRegistryKey {
        PauseAuthorityRegistryKey{dummy_field: false}
    }

    public fun supply_limit_key(arg0: 0x1::type_name::TypeName) : SupplyLimitKey {
        SupplyLimitKey{type: arg0}
    }

    // decompiled from Move bytecode v6
}

