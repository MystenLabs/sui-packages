module 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::keys {
    struct ExtensionMetadataKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct IdleLiquidityKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct FeeKey has copy, drop, store {
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

    // decompiled from Move bytecode v6
}

