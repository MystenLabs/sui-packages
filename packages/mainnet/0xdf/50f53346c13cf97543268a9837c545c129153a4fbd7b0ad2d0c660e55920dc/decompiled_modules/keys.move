module 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::keys {
    struct ExtensionMetadataKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct IdleLiquidityKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct FeeKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct LockedProfitKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    public(friend) fun to_extension_metadata_key(arg0: 0x1::type_name::TypeName) : ExtensionMetadataKey {
        ExtensionMetadataKey{pos0: arg0}
    }

    public(friend) fun to_fee_key(arg0: 0x1::type_name::TypeName) : FeeKey {
        FeeKey{pos0: arg0}
    }

    public(friend) fun to_idle_liquidity_key(arg0: 0x1::type_name::TypeName) : IdleLiquidityKey {
        IdleLiquidityKey{pos0: arg0}
    }

    public(friend) fun to_locked_profit_key(arg0: 0x1::type_name::TypeName) : LockedProfitKey {
        LockedProfitKey{pos0: arg0}
    }

    // decompiled from Move bytecode v6
}

