module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys {
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

