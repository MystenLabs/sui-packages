module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_admin {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun new_vault<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        abort 1000
    }

    public fun set_is_spring_vault<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: bool) {
        abort 1000
    }

    public fun set_pool_id<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::AdminCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: 0x2::object::ID) {
        abort 1000
    }

    // decompiled from Move bytecode v7
}

