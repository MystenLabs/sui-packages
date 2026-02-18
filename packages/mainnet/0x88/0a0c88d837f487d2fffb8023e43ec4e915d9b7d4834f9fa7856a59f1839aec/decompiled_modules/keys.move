module 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::keys {
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

