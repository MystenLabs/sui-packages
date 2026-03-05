module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_pool {
    struct SupplierCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarginPool<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun mint_supplier_cap(arg0: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_registry::MarginRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : SupplierCap {
        abort 0
    }

    public fun mint_supply_referral<T0>(arg0: &MarginPool<T0>, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 0
    }

    public fun supply<T0>(arg0: &mut MarginPool<T0>, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_registry::MarginRegistry, arg2: &SupplierCap, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public fun user_supply_amount<T0>(arg0: &MarginPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public fun user_supply_shares<T0>(arg0: &MarginPool<T0>, arg1: 0x2::object::ID) : u64 {
        abort 0
    }

    public fun withdraw<T0>(arg0: &mut MarginPool<T0>, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_registry::MarginRegistry, arg2: &SupplierCap, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun withdraw_referral_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::margin_registry::MarginRegistry, arg2: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::protocol_fees::SupplyReferral, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

