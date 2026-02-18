module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::keys {
    struct IdleLiquidityKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct FeeKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct LockedProfitKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
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

